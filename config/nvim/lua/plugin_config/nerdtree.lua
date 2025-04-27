-- plugin_config/nerdtree.lua

-- 자동 실행 (VimEnter)
vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    vim.cmd("NERDTree")
  end,
})

-- 단축키 설정
vim.keymap.set("n", "<Leader>n", ":NERDTreeToggle<CR>", {
  noremap = true,
  silent = true,
  desc = "Toggle NERDTree file explorer"
})

vim.keymap.set("n", "<C-F>", ":NERDTreeFind<CR>", {
  noremap = true,
  silent = true,
  desc = "Find current file in NERDTree"
})


