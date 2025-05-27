vim9script

const NAMES = '"0123456789abcdefghijklmnopqrstuvwxyz-*~.:%#/'
const prefixs = {
  n: '"',
  i: "\<C-r>",
  c: "\<C-r>",
  t: "\<C-w>\"",
}
var winid = 0
var timer = 0
var items = []

export def PopupDelay(mode: string)
  const sec = get(g:, 'registerslite_delay', 0)
  Popup(mode, !!sec)
  if !!sec
    timer = timer_start(
      float2nr(sec * 1000),
      (_) => ShowItems(mode)
    )
  endif
enddef

def SetupItems()
  items = []
  var values = []
  const hideDup = !!get(g:, 'registerslite_hide_dupricate', 1)
  for name in NAMES
    # NOTE: prevent W24 message
    silent! var value = getreg(name, 1)
      ->substitute('\t', '›', 'g')
      ->substitute('\n', '↵', 'g')
    if value ==# '' || hideDup && index(values, value) !=# -1
      continue
    endif
    items->add(printf('%s: %s', name, value))
    values->add(value)
  endfor
enddef

def ShowItems(mode: string)
  popup_setoptions(winid, GetPos(mode, false))
  popup_settext(winid, items)
enddef

def GetPos(mode: string, is_delay: bool): dict<any>
  return is_delay ? {
    # hidden (right bottom of screen)
    col: &columns + 1,
    line: &lines + 1,
    highlight: 'MsgArea',
    cursorline: false,
  } : mode ==# 'c' ? {
    # command mode
    col: getcmdpos() + 1,
    line: &lines - 1,
    highlight: 'RegistersLite',
    cursorline: true,
  } : {
    # normal mode, insert mode, terminal
    col: 'cursor',
    line: 'cursor-1',
    highlight: 'RegistersLite',
    cursorline: true,
  }
enddef

export def Popup(mode: string, is_delay: bool = false)
  SetupItems()
  const prefix = get(prefixs, mode, '"')
  const winline = win_screenpos(0)[0] + winline() - 1
  var maxheight = (winline <= &lines / 2 + 1) ? &lines - winline - 2 : &lines
  maxheight = min([maxheight, get(g:, 'registerslite_max_height', &lines)])
  winid = popup_atcursor(is_delay ? '' : items, {
    mapping: 0,
    maxwidth: min([get(g:, 'registerslite_max_width', 32), &columns]),
    maxheight: maxheight,
    moved: 'any',
    wrap: false,
    filter: (id, key) => {
      if index(["\<C-p>", "\<S-TAB>", "\<Up>", "k"], key) !=# -1
        return popup_filter_menu(id, 'k')
      elseif index(["\<C-n>", "\<TAB>", "\<Down>", "j"], key) !=# -1
        return popup_filter_menu(id, 'j')
      elseif index(["\<CR>", " "], key) !=# -1
        return popup_filter_menu(id, ' ')
      elseif key ==# "g"
        win_execute(winid, 'setpos(".", [0, 1, 1, 0])')
        return true
      elseif key ==# "G"
        win_execute(winid, printf('setpos(".", [0, %d, 1, 0])', len(items)))
        return true
      elseif key ==# "\<CursorHold>"
        return true
      else
        popup_close(id, -1)
        redraw
        feedkeys(prefix .. key, 'n')
        return true
      endif
    },
    callback: (id, result) => {
      if result !=# -1
        feedkeys(prefix .. items[result - 1][0], 'n')
      endif
    },
  }->extend(GetPos(mode, is_delay)))
  win_execute(winid, 'syntax match RegistersLiteNumber  /^\d/')
  win_execute(winid, 'syntax match RegistersLiteChar    /^[a-z]/')
  win_execute(winid, 'syntax match RegistersLiteSymbol  /^[^0-9a-z]/')
  win_execute(winid, 'syntax match RegistersLiteCoron   /\(^.\)\@<=:/')
  win_execute(winid, 'syntax match RegistersLiteNonText /[›↵]/')
  redraw
enddef

