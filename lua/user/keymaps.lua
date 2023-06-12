local opts = { noremap = true, silent = true }

local term_opts = { silent = true }

-- Shorten function name
local keymap = vim.api.nvim_set_keymap

--Remap space as leader key
-- keymap("", "<Space>", "<Nop>", opts)
-- vim.g.mapleader = " "
-- vim.g.maplocalleader = " "

-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

-- Normal --
-- Better window navigation
-- keymap("n", "<C-h>", "<C-w>h", opts)
-- keymap("n", "<C-j>", "<C-w>j", opts)
-- keymap("n", "<C-k>", "<C-w>k", opts)
-- keymap("n", "<C-l>", "<C-w>l", opts)
--

-- Ctrl+c/Ctrl+v to copy and paste --
-- keymap("n", "<C-c>", '"*yy', opts)
-- keymap("v", "<C-c>", '"*y', opts)
-- keymap("n", "<C-v>", '"*p', opts)
-- keymap("v", "<C-v>", '"*p<CR>', opts)

-- -- Flip nvim and system clipboard
-- keymap("v", "<C-c>", ':let @+=@"<CR>', opts)
-- keymap("n", "<C-c>", ':let @+=@"<CR>', opts)
-- keymap("v", "<C-v>", ':let @"=@+<CR>', opts)
-- keymap("n", "<C-v>", ':let @"=@+<CR>', opts)

-- -- Resize with arrows
keymap("n", "<C-Up>", ":resize -2<CR>", opts)
keymap("n", "<C-Down>", ":resize +2<CR>", opts)
keymap("n", "<C-Left>", ":vertical resize -2<CR>", opts)
keymap("n", "<C-Right>", ":vertical resize +2<CR>", opts)
--
-- -- Navigate buffer
keymap("n", "<S-l>", ":bnext<CR>", opts)
keymap("n", "<S-h>", ":bprevious<CR>", opts)
keymap("n", "<C-q>", "<cmd>lua MiniBufremove.delete()<CR>", opts)
--
-- -- Move text up and down
-- keymap("n", "<A-j>", "<Esc>:m .+1<CR>==gi", opts)
-- keymap("n", "<A-k>", "<Esc>:m .-2<CR>==gi", opts)
--
-- -- Insert --
-- -- Press jk fast to exit insert mode 
-- keymap("i", "jk", "<ESC>", opts)
-- keymap("i", "kj", "<ESC>", opts)
--
-- -- Visual --
-- -- Stay in indent mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)
--
-- -- Move text up and down
-- keymap("v", "<A-j>", ":m .+1<CR>==", opts)
-- keymap("v", "<A-k>", ":m .-2<CR>==", opts)
-- keymap("v", "p", '"_dP', opts)
--
-- -- Visual Block --
-- -- Move text up and down
-- keymap("x", "J", ":move '>+1<CR>gv-gv", opts)
-- keymap("x", "K", ":move '<-2<CR>gv-gv", opts)
-- keymap("x", "<A-j>", ":move '>+1<CR>gv-gv", opts)
-- keymap("x", "<A-k>", ":move '<-2<CR>gv-gv", opts)
--
-- -- Nvim Tree --
keymap("n", "<leader>e", ":NvimTreeToggle<cr>", opts)

-- Terminal --
-- Better terminal navigation
-- keymap("t", "<C-h>", "<C-\\><C-N><C-w>h", term_opts)
-- keymap("t", "<C-j>", "<C-\\><C-N><C-w>j", term_opts)
-- keymap("t", "<C-k>", "<C-\\><C-N><C-w>k", term_opts)
-- keymap("t", "<C-l>", "<C-\\><C-N><C-w>l", term_opts)

-- keymap("n", "<leader>f", "<cmd>lua require'telescope.builtin'.find_files()<cr>", opts)
keymap("n", "<leader>f", "<cmd>lua require'telescope.builtin'.find_files(require('telescope.themes').get_dropdown({previewer = false}))<cr>", opts)
-- keymap("n", "<leader>g", "<cmd>lua require'telescope.builtin'.live_grep({ layout_stategory = 'vertical' })<cr>", opts)
keymap("n", "<leader>g", "<cmd>lua require'telescope'.extensions.live_grep_args.live_grep_args()<CR>", opts)
keymap("n", "<leader>b", "<cmd>lua require'telescope.builtin'.buffers({ ignore_current_buffer = true, sort_mru = true})<cr>", opts)
-- keymap("n", [[<c-\>]], "<cmd>lua require'telescope.builtin'.commands({})<cr>", opts)
keymap("n", "<leader>p", "<cmd>Telescope neoclip theme=dropdown<cr>", opts)
keymap("n", "<leader>o", "<cmd>lua require'telescope'.extensions.projects.projects()<cr>", opts)
keymap("n", "<leader>d", "<cmd>lua require'telescope'.extensions.file_browser.file_browser()<cr>", opts)
keymap("n", "<leader>D", "<cmd>lua require'telescope'.extensions.file_browser.file_browser({initial_mode = 'insert'})<cr>", opts)

keymap("n", "<leader>q", "<cmd>lua ToggleQuickfixList()<cr>", opts)
-- keymap("n", "[q", ":cprev<cr>", opts)
-- keymap("n", "]q", ":cnext<cr>", opts)

function _SET_CLIPBOARD(clip_value)
  local current_clip_value = vim.api.nvim_exec("set clipboard?", true)
  local current_value = string.match(current_clip_value, "=(.+)") 
  if current_value == clip_value then
    clip_value=""
  end
  vim.cmd("set clipboard=" .. clip_value)
  vim.cmd("set clipboard?")
end

keymap("n", "`", "<cmd>lua _SET_CLIPBOARD('unnamedplus')<cr>", opts)

vim.cmd([[
          function! QuickfixMapping()
            " Go to the previous location and stay in the quickfix window
            nnoremap <buffer> K :cprev<CR>zz<C-w>w
          " Go to the next location and stay in the quickfix window
            nnoremap <buffer> J :cnext<CR>zz<C-w>w

            nnoremap <buffer> <Tab> <CR>zz<C-w>w
            " Begin the search and replace
            nnoremap <buffer> <leader>r :cdo s/// \| update<C-Left><C-Left><Left><Left><Left>
          endfunction

          augroup quickfix_group
            autocmd!
            
            " Use custom keybindings
            autocmd filetype qf call QuickfixMapping()
            
            " Add the errorformat to be able to update the quickfix list
            autocmd filetype qf setlocal errorformat+=%f\|%l\ col\ %c\|%m
          augroup END
       ]])

