-- plugin_config/coc.lua

vim.g.coc_global_extensions = {
  "coc-json",
  "coc-tsserver",
  "coc-pyright",
  "coc-snippets",
  "coc-clangd",
}

-- Hover 문서
vim.keymap.set("n", "K", ":call CocActionAsync('doHover')<CR>", { silent = true, desc = "coc hover" })

-- Go to
vim.keymap.set("n", "gd", "<Plug>(coc-definition)", { silent = true })
vim.keymap.set("n", "gi", "<Plug>(coc-implementation)", { silent = true })
vim.keymap.set("n", "gy", "<Plug>(coc-type-definition)", { silent = true })
vim.keymap.set("n", "gr", "<Plug>(coc-references)", { silent = true })

-- Enter 키 자동완성 적용
vim.cmd([[
inoremap <silent><expr> <CR> pumvisible() ? coc#_select_confirm() : "\<CR>"
]])

vim.keymap.set("n", "<leader>rn", "<Plug>(coc-rename)", { desc = "coc rename" })
vim.keymap.set("n", "<leader>f", "<Plug>(coc-format)", { desc = "coc format" })


