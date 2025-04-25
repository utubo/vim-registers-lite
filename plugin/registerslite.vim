vim9script

if exists('g:registers_lite_loaded')
  finish
endif
g:registers_lite_loaded = 1

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
nmap <Plug>(registers-lite) <Cmd>call registerslite#Popup(mode())<CR>
map! <Plug>(registers-lite) <Cmd>call registerslite#Popup(mode())<CR>
tmap <Plug>(registers-lite) <Cmd>call registerslite#Popup(mode())<CR>

nnoremap " <Plug>(registers-lite)
noremap! <C-r> <Plug>(registers-lite)
tnoremap <C-w>" <Plug>(registers-lite)

