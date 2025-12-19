vim9script

if exists('g:registerslite_loaded')
  finish
endif
g:registerslite_loaded = 1

# Hilight
if !hlexists('RegistersLite')
  hi link RegistersLite        PMenu
  hi link RegistersLiteNumber  Number
  hi link RegistersLiteChar    Directory
  hi link RegistersLiteSymbol  Delimiter
  hi link RegistersLiteCoron   Comment
  hi link RegistersLiteNonText Comment
endif

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
