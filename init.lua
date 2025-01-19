local Terminal = require('toggleterm.terminal').Terminal

local M = {}

-- Create aider terminal instance
local DEFAULT_ARGS = "--no-pretty --no-auto-commit --no-gitignore --watch-files"
local aider = Terminal:new({
  cmd = "aider " .. DEFAULT_ARGS,
  hidden = true,
  direction = "float",
})

-- Function to get current file path
local function get_current_file()
  return vim.fn.expand('%:p')
end

-- Function to add current file to aider
local function aider_add_file()
  local file = get_current_file()
  aider:send('/add ' .. file)
end

-- Function to drop current file from aider
local function aider_drop_file()
  local file = get_current_file()
  aider:send('/drop ' .. file)
end

-- Function to add file from nvim-tree
local function aider_add_tree_file()
  local node = require('nvim-tree.api').tree.get_node_under_cursor()
  if node then
    aider:send('/add ' .. node.absolute_path)
  end
end

-- Function to drop file from nvim-tree
local function aider_drop_tree_file()
  local node = require('nvim-tree.api').tree.get_node_under_cursor()
  if node then
    aider:send('/drop ' .. node.absolute_path)
  end
end

-- Aider terminal toggle
local function aider_toggle()
  aider:toggle()
  if aider:is_open() then
    vim.schedule(function()
      vim.cmd('startinsert')
    end)
  end
end

-- Function to handle aider file operations based on context
local function aider_smart_add()
  if vim.bo.filetype == 'NvimTree' then
    aider_add_tree_file()
  else
    aider_add_file()
  end
end

local function aider_smart_drop()
  if vim.bo.filetype == 'NvimTree' then
    aider_drop_tree_file()
  else
    aider_drop_file()
  end
end

function M.setup(opts)
  opts = opts or {}
  
  -- Configure aider command if specified
  if opts.args then
    aider.cmd = "aider " .. opts.args
  end
  
  -- Set up keymaps
  vim.keymap.set('n', opts.toggle_key or '<leader>as', aider_toggle, { desc = 'Toggle Aider terminal' })
  vim.keymap.set('t', opts.toggle_key or '<leader>as', '<C-\\><C-n>:lua require("aider-nvim").toggle()<CR>', { desc = 'Toggle Aider terminal' })
  vim.keymap.set('n', opts.add_key or '<leader>aa', aider_smart_add, { desc = 'Add file to Aider' })
  vim.keymap.set('n', opts.drop_key or '<leader>ad', aider_smart_drop, { desc = 'Drop file from Aider' })
end

-- Expose functions for external use
M.toggle = aider_toggle
M.add_file = aider_smart_add
M.drop_file = aider_smart_drop

return M
