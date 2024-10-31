vim9script

def Hilight()
  silent! hi link RegistersLite        PMenu
  silent! hi link RegistersLiteNumber  Number
  silent! hi link RegistersLiteChar    Directory
  silent! hi link RegistersLiteSymbol  Delimiter
  silent! hi link RegistersLiteCoron   Comment
  silent! hi link RegistersLiteNonText Comment
enddef

if exists('g:registerslite')
  finish
endif
g:registerslite = 1

nnoremap " <Cmd>call registerslite#Popup('n')<CR>
inoremap <C-r> <C-o><Cmd>call registerslite#Popup('i')<CR>
tnoremap <C-w>" <Cmd>call registerslite#Popup('t')<CR>

Hilight()

augroup registerslite
  au!
  au ColorScheme * call Hilight()
augroup END

