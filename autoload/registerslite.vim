vim9script

const NAMES = '"0123456789abcdefghijklmnopqrstuvwxyz-.:%#/='
var winid = 0
export def Popup(mode: string)
  var prefix = mode ==# 'i' ? "\<C-r>" : mode ==# 't' ? "\<C-w>\"" : '"'
  var items = []
  var values = []
  var hideDup = get(g:, 'registerslite_hide_dupricate', 1)
  for name in NAMES
    var value = getreg(name, 1)
      ->substitute('\t', '›', 'g')
      ->substitute('\n', '↵', 'g')
    if value ==# '' || hideDup ==# 1 && index(values, value) !=# -1
      continue
    endif
    items->add(printf('%s: %s', name, value))
    values->add(value)
  endfor
  var winline = win_screenpos(0)[0] + winline() - 1
  var maxheight = (winline <= &lines / 2 + 1) ? &lines - winline - 2 : &lines
  maxheight = min([maxheight, get(g:, 'registerslite_max_height', &lines)])
  winid = popup_atcursor(items, {
    cursorline: true,
    mapping: 0,
    maxwidth: min([get(g:, 'registerslite_max_width', 100), &columns]),
    maxheight: maxheight,
    moved: 'any',
    wrap: false,
    highlight: 'RegistersLite',
    filter: (id, key) => {
      if index(["\<C-p>", "\<S-TAB>", "\<Up>", "k"], key) !=# -1
        return popup_filter_menu(id, 'k')
      elseif index(["\<C-n>", "\<TAB>", "\<Down>", "j"], key) !=# -1
        return popup_filter_menu(id, 'j')
      elseif index(["\<CR>", " "], key) !=# -1
        return popup_filter_menu(id, ' ')
      elseif key ==# "G"
        win_execute(winid, printf('setpos(".", [0, %d, 1, 0])', len(items)))
        return true
      else
        popup_close(id, -1)
        feedkeys(prefix .. key, 'n')
        return true
      endif
    },
    callback: (id, result) => {
      if result !=# -1
        feedkeys(prefix .. items[result - 1][0], 'n')
      endif
    },
  })
  win_execute(winid, 'syntax match RegistersLiteNumber  /^\d/')
  win_execute(winid, 'syntax match RegistersLiteChar    /^[a-z]/')
  win_execute(winid, 'syntax match RegistersLiteSymbol  /^[^0-9a-z]/')
  win_execute(winid, 'syntax match RegistersLiteCoron   /\(^.\)\@<=:/')
  win_execute(winid, 'syntax match RegistersLiteNonText /[›↵]/')
enddef

