vim9script

if exists('g:registerslite_loaded')
  finish
endif
g:registerslite_loaded = 1

# Hilight
def Hilight()
  silent! hi link RegistersLite        PMenu
  silent! hi link RegistersLiteNumber  Number
  silent! hi link RegistersLiteChar    Directory
  silent! hi link RegistersLiteSymbol  Delimiter
  silent! hi link RegistersLiteCoron   Comment
  silent! hi link RegistersLiteNonText Comment
enddef

Hilight()

augroup registerslite
  au!
  au ColorScheme * call Hilight()
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
