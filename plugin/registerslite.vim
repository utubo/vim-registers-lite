vim9script

if exists('g:registerslite')
  finish
endif
g:registerslite = 1

nnoremap <silent> " :<C-u>call registerslite#Popup('n')<CR>
inoremap <silent> <C-r> <C-o>:call registerslite#Popup('i')<CR>
tnoremap <silent> <C-w>" <C-w>:call registerslite#Popup('t')<CR>

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
augroup End

