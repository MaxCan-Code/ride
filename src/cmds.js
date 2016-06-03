D.modules.cmds=function(){'use strict'

// This is the list of command-to-keystroke mappings that are configurable in Preferences>Keys.
// The list does not necessarily contain all commands and all keystrokes in RIDE, only those in Preferences>Keys.
this.cmds=[
  //code description                default keys
  ['ABT','About',                   ['Shift-F1']],
  ['AC', 'Align comments',          []],
  ['AO', 'Add comments',            []],
  ['BK', 'Backward or Undo',        ['Shift-Ctrl-Backspace']],
  ['BP', 'Toggle breakpoint',       []],
  ['BT', 'Back Tab between windows',['Shift-Ctrl-Tab']],
  ['CNC','Connect',                 []],
  ['DMK','Toggle key display mode', []],
  ['DMN','Next line in demo',       []],
  ['DMP','Previous line in demo',   []],
  ['DMR','Load demo file',          []],
  ['DO', 'Delete comments',         []],
  ['ED', 'Edit',                    ['Shift-Enter']],
  ['EP', 'Exit (and save changes)', ['Esc']],
  ['ER', 'Execute line',            ['Enter']],
  ['EXP','Expand selection',        ['Shift-Alt-Up']],
  ['FD', 'Forward or Redo',         ['Shift-Ctrl-Enter']],
  ['FX', 'Fix the current function',[]],
  ['HLP','Help',                    ['F1']],
  ['JBK','Jump back',               ['Shift-Ctrl-J']],
  ['JSC','Show JavaScript console', ['F12']],
  ['LBR','Toggle language bar',     []],
  ['LN', 'Toggle line numbers',     []],
  ['LOG','Show RIDE protocol log',  ['Ctrl-F12']],
  ['MA', 'Continue execution of all threads',[]],
  ['MNU','Open menu',               ['F10']],
  ['NEW','New session',             ['Ctrl-N']],
  ['PRF','Show preferences',        []],
  ['QIT','Quit',                    ['Ctrl-Q']],
  ['QT', 'Quit (and lose changes)', ['Shift-Esc']],
  ['RD', 'Reformat',                []],
  ['RP', 'Replace (in editors)',    []],
  ['SC', 'Search (in editors)',     []],
  ['SI', 'Strong interrupt',        []],
  ['TB', 'Tab between windows',     ['Ctrl-Tab']],
  ['TC', 'Trace',                   ['Ctrl-Enter']],
  ['TGC','Toggle comment',          []],
  ['TIP','Show value tip',          []],
  ['TL', 'Toggle localisation',     ['Ctrl-Up']],
  ['TO', 'Toggle fold',             []],
  ['VAL','Evaluate selection or name under cursor',[]],
  ['WI', 'Weak interrupt',          ['Ctrl-Pause']],
  ['WSE','Toggle workspace explorer',[]],
  ['ZMI','Increase font size',      ['Ctrl-=','Shift-Ctrl-='].concat(D.mac?['Cmd-=','Shift-Cmd-=']:[])],
  ['ZMO','Decrease font size',      ['Ctrl--'].concat(D.mac?'Cmd--':[])],
  ['ZMR','Reset font size',         ['Ctrl-0'].concat(D.mac?'Cmd-0':[])]
]

}
