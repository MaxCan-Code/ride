jQuery ($) ->
  debug = 1

  socket = io()

  if debug
    {emit, onevent} = socket
    socket.emit = (a...) -> console.info 'send:' + JSON.stringify(a)[..1000]; emit.apply socket, a
    socket.onevent = (packet) -> console.info 'recv:' + JSON.stringify(packet.data)[..1000]; onevent.apply socket, [packet]

  winInfos = {}
  editorWin = null
  debuggerWin = null

  ed = DyalogEditor '#editor',
    close: -> socket.emit 'close', editorWin
    save: (s) -> socket.emit 'save', editorWin, (winInfos[editorWin].text = s)

  db = DyalogEditor '#debugger',
    debugger: true
    close: -> socket.emit 'close', debuggerWin
    save: (s) -> socket.emit 'save', debuggerWin, (winInfos[debuggerWin].text = s)

  session = DyalogSession '#session',
    edit: (s, i) -> socket.emit 'edit', s, i
    exec: (lines, trace) -> (for s in lines then socket.emit 'exec', s + '\n', +!!trace); return
    autocomplete: (s, i) -> socket.emit 'autocomplete', s, i, 0

  socket.on 'title', (s) -> $('title').text s
  socket.on 'add', (s) -> session.add s
  socket.on 'prompt', -> session.prompt()
  socket.on 'focus', (win) -> if win then ed.focus() else session.focus()

  socket.on 'open', (name, text, token, bugger) ->
    winInfos[token] = {name, text}
    if bugger
      layout.open 'south'
      if debuggerWin? then winInfos[debuggerWin].text = db.getValue()
      debuggerWin = token
      db.open name, text
    else
      layout.open 'east'
      if editorWin? then winInfos[editorWin].text = ed.getValue()
      editorWin = token
      ed.open name, text

  socket.on 'close', (win) ->
    delete winInfos[win]
    for win, v of winInfos then break
    if v
      editorWin = win
      ed.open v.name, v.text
    else
      editorWin = null
      layout.close 'east'

  socket.on 'autocomplete', (token, skip, options) ->
    if token == 0 then session.autocomplete skip, options

  # language bar
  $('#lbar').append(
    '← +-×÷*⍟⌹○!? |⌈⌊⊥⊤⊣⊢ =≠≤<>≥≡≢ ∨∧⍱⍲ ↑↓⊂⊃⌷⍋⍒ ⍳⍷∪∩∊~ /\\⌿⍀ ,⍪⍴⌽⊖⍉ ¨⍨⍣.∘⍤ ⍞⎕⍠⌸⍎⍕ ⋄⍝→⍵⍺∇& ¯⍬'
      .replace /\S+/g, (g) ->
        """<span class="group">#{g.replace /(.)/g, '<span class="glyph">$1</span>'}</span>"""
  )
  $('#lbar').on 'mousedown', -> false
  $('.glyph', '#lbar').on 'mousedown', (e) ->
    for x in [session, ed] when x.hasFocus() then x.insert $(e.target).text()
    false
  $('#lbar-close').on 'click', -> layout.close 'north'; false

  # tooltips
  ttid = null # tooltip timeout id
  $('.glyph', '#lbar').on 'mouseover focus', (e) ->
    clearTimeout ttid
    ttid = setTimeout(
      ->
        ttid = null
        $t = $ e.target; p = $t.position(); x = $t.text()
        h = help[x] or [x, '']
        $('#tip-desc').text h[0]
        $('#tip-text').text h[1]
        $('#tip').css(left: p.left - 21, top: p.top + $t.height() + 2).show()
      500
    )
  $('.glyph', '#lbar').on 'mouseout blur', ->
    clearTimeout ttid; ttid = null; $('#tip').hide()

  layout = $('body').layout
    defaults: enableCursorHotkey: 0
    north: resizable: 0, togglerLength_closed: '100%', togglerTip_closed: 'Show Language Bar', spacing_open: 0
    east: spacing_closed: 0, size: '50%', resizable: 1, togglerClass: 'hidden'
    south: spacing_closed: 0, size: '50%', resizable: 1, togglerClass: 'hidden'
    center: onresize: -> console.info 'resized'; for x in [session, ed, db] then x.updateSize()
  layout.close 'east' # "east:{initOpen:false}" doesn't work---the resizer doesn't get rendered
  layout.close 'south'
