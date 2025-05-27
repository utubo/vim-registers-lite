# vim-registers-lite

The [registers.nvim](https://github.com/tversteeg/registers.nvim) clone for Vim.

- This is a simple poting, not perfect. (I have not seen the source code.)
- The options of registers.nvim are not supported.

## Requires

Vim9script

## Install

```vim
call dein#add('utubo/vim-registers-lite')
```

## Usage

Type `"` in Nomal-mode or `<C-r>` in Insert-mode.

Popup-menu
  - `j`, `<C-n>`, `<Tab>`, `<Down>`<br>
    Move the selection down
  - `k`, `<C-p>`, `<S-Tab>`, `<Up>`<br>
    Move the selection up
  - `g`<br>
    Goto the first line
  - `G`<br>
    Goto the last line
  - `<CR>`, `<Space>`<br>
    Feedkeys `"{selection}`
  - Other keys<br>
    Feedkeys `"{key}`

## Configuration

### `g:registerslite_bind_keys`

The Dict of key mappings.

Default:
```
{
  'nnoremap': '"',
  'noremap!': '<C-r>',
  'tnoremap': '<C-w>"',
}
```

### `g:registerslite_max_width`

Maximum width of the window.

Default: `32`

### `g:registerslite_max_height`

Maximum height of the window.

### `g:registerslite_delay`

How long, in seconds, to wait before applying the function.

Default: `0`

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

