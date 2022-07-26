# vim-registers-lite.nvim

[registers.nvim](https://github.com/tversteeg/registers.nvim) for Vim.

- This is a simple poting, not perfect. (I have not seen the source code.)
- The options of registers.nvim are not supported.

## Requires

Vim9script

## Install

```vim
call dein#add('utubo/vim-registers-lite.nvim')
```

## Usage

Type `"` in Nomal-mode or `<C-r>` in Insert-mode.

- `j`, `<C-n>`, `<Tab>`, `<Down>`<br>
  Move selection down
- `k`, `<C-p>`, `<S-Tab>`, `<Up>`<br>
  Move selection up
- `G`<br>
  Goto last line
- `<CR>`, `<Space>`<br>
  Feedkeys `"{selection}`
- Other keys
  Feedkeys `"{key}`

## Configuration

### `g:registerslite_max_width`

Maximum width of the window.

Default: `100`

### `g:registerslite_max_height`

Maximum height of the window.

## `g:registerslite_hide_dupricate`

Hide regsters with dupricate value.

Default: `1`

### Hilight colors
Default:
```vim
hi link RegistersLite        PMenu
hi link RegistersLiteNumber  Number
hi link RegistersLiteChar    Directory
hi link RegistersLiteSymbol  Delimiter
hi link RegistersLiteCoron   Comment
hi link RegistersLiteNonText Comment
```

## LICENSE

The GPLv3 License (GPLv3)

Author
- tversteeg(registers.nvim)
- utubo(vim-registers-lite)

