--============================================================--
--                        Neovim Mappings                      --
--============================================================--

local map = vim.keymap.set
local default_opts = { noremap = true, silent = true }

-- Normal mode mappings
map("n", "<Leader>rc", ":rightbelow vnew $MYVIMRC<CR>", default_opts)
map("n", "<Leader>=", ":resize +3<CR>", default_opts)
map("n", "<Leader>-", ":resize -3<CR>", default_opts)
map("n", "<Leader>]", ":vertical resize +8<CR>", default_opts)
map("n", "<Leader>[", ":vertical resize -8<CR>", default_opts)
map("n", "<Leader>+", ":resize " .. math.floor(vim.fn.winheight(0) * 3 / 2) .. "<CR>", default_opts)
map("n", "<Leader>_", ":resize " .. math.floor(vim.fn.winheight(0) * 2 / 3) .. "<CR>", default_opts)
map("n", "<Leader>}", ":vertical resize " .. math.floor(vim.fn.winheight(0) * 3 / 2) .. "<CR>", default_opts)
map("n", "<Leader>{", ":vertical resize " .. math.floor(vim.fn.winheight(0) * 2 / 3) .. "<CR>", default_opts)
map("n", "<Leader>m", ":bprevious<CR>", default_opts)
map("n", "<Leader>.", ":bnext<CR>", default_opts)
map("n", "<Leader>bq", ":bp <BAR> bd #<CR>", default_opts)
map("n", "<Leader>n", ":NERDTreeToggle<CR>", default_opts)
map("n", "<C-F>", ":NERDTreeFind<CR>", default_opts)
map("n", "<C-h>", "<C-w>h", default_opts)
map("n", "<C-j>", "<C-w>j", default_opts)
map("n", "<C-k>", "<C-w>k", default_opts)
map("n", "<C-l>", "<C-w>l", default_opts)

-- Terminal mode mappings
map("t", "<ESC>", [[<C-\><C-n>]], default_opts)

-- Insert mode mappings
map("i", "<C-c>", "<Esc>" .. '"+yiw', default_opts)

-- Visual mode mappings
map("v", "<C-c>", '"+y', default_opts)

-- Coc.nvim related
map("n", "gr", "<Plug>(coc-references)", {})
map("n", "gd", "<Plug>(coc-definition)", {})
map("n", "gy", "<Plug>(coc-type-definition)", {})
map("n", "gi", "<Plug>(coc-implementation)", {})
map("n", "go", "<C-o>", default_opts)
map("n", "K", ":call v:lua.ShowDocumentation()<CR>", default_opts)

-- Insert completion navigation
vim.cmd [[
  inoremap <silent><expr> <C-j> coc#pum#visible() ? coc#pum#next(1) : "\<Tab>"
  inoremap <silent><expr> <C-k> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"
  inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
  inoremap <nowait><expr> <C-m> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1, 1)\<cr>" : "\<Right>"
  inoremap <nowait><expr> <C-,> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0, 1)\<cr>" : "\<Left>"
]]

-- ESC 관련 UX 개선
map("n", "<ESC>j", "j", {})
map("n", "<ESC>k", "k", {})
map("n", "<ESC>h", "h", {})
map("n", "<ESC>l", "l", {})
map("n", "<ESC>:", ":", {})
map("n", "<C-o>", "o", {})
map("n", "<C-p>", "p", {})
map("n", "<ESC><ESC>", "<ESC>", default_opts)
map("n", "<ESC>", "<ESC>:w<CR>", default_opts)


--Git vim-fugitive
vim.keymap.set("n", "<leader>gs", ":Git<CR>", { desc = "Git status" })
vim.keymap.set("n", "<leader>gb", ":Git blame<CR>", { desc = "Git blame" })
