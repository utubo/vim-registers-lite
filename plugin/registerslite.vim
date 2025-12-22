vim9script

if exists('g:registerslite_loaded')
  finish
endif
g:registerslite_loaded = 1

# Highlight
def Color()
  hi default link RegistersLite        PMenu
  hi default link RegistersLiteNumber  Number
  hi default link RegistersLiteChar    Directory
  hi default link RegistersLiteSymbol  Delimiter
  hi default link RegistersLiteCoron   Comment
  hi default link RegistersLiteNonText Comment
enddef
Color()
augroup registerslite
  au! ColorScheme * Color()
augroup END

# Mapping
nmap <Plug>(registerslite) <Cmd>call registerslite#PopupDelay(mode())<CR>
map! <Plug>(registerslite) <Cmd>call registerslite#PopupDelay(mode())<CR>
tmap <Plug>(registerslite) <Cmd>call registerslite#PopupDelay(mode())<CR>

const keys = get(g:, 'registerslite_bind_keys', {
  'nnoremap': '"',
  'noremap!': '<C-r>',
  'tnoremap': '<C-w>"',
})
if !!keys
  for m in keys->keys()
    execute $'silent! {m} <unique> {keys[m]} <Plug>(registerslite)'
  endfor
endif
