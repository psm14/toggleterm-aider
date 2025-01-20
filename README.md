# toggleterm-aider

A Neovim plugin for seamless integration with [aider](https://github.com/paul-gauthier/aider), an AI pair programming tool.

## Features

- Floating terminal integration for aider CLI
- Easy file management with add/drop commands
- Support for both buffer and nvim-tree operations
- Customizable keymaps

## Prerequisites

- Neovim >= 0.7.0
- [toggleterm.nvim](https://github.com/akinsho/toggleterm.nvim)
- [nvim-tree.lua](https://github.com/nvim-tree/nvim-tree.lua) (optional, for tree integration)
- [aider](https://github.com/paul-gauthier/aider) CLI tool

## Installation

Using [lazy.nvim](https://github.com/folke/lazy.nvim):

```lua
{
    'psm14/toggleterm-aider',
    dependencies = {
        'akinsho/toggleterm.nvim',
        'nvim-tree/nvim-tree.lua', -- optional
    },
    config = function()
        require('toggleterm-aider').setup()
    end
}
```

## Configuration

The plugin can be configured with custom options:

```lua
require('toggleterm-aider').setup({
    -- Custom aider CLI arguments (optional)
    args = "--no-pretty --no-auto-commit --watch-files",
    
    -- Custom keymaps (optional)
    toggle_key = '<leader>as', -- Toggle aider terminal
    add_key = '<leader>aa',    -- Add file to aider
    drop_key = '<leader>ad'    -- Drop file from aider
})
```

## Default Keymaps

- `<leader>as`: Toggle aider terminal
- `<leader>aa`: Add current file to aider session
- `<leader>ad`: Drop current file from aider session

These keymaps work in both normal buffers and nvim-tree.

## Usage

1. Open Neovim and press `<leader>as` to start an aider session
2. Navigate to a file you want to edit with aider
3. Press `<leader>aa` to add the file to the session
4. Start chatting with aider in the floating terminal
5. Use `<leader>ad` to drop files from the session when needed

## License

MIT
