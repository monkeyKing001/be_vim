-- plugin_config/coc.lua

vim.g.coc_global_extensions = {
  "coc-json",
  "coc-tsserver",
  "coc-pyright",
  "coc-snippets",
  "coc-clangd",
}

-- [[ Python Virtual Environment Auto-Detection ]]
local function get_python_path()
  -- Try to find project root by looking for .git or .venv
  local root_patterns = { ".git", ".venv", "venv", "env", "pyproject.toml", "requirements.txt" }
  local root_dir = vim.fs.dirname(vim.fs.find(root_patterns, { upward = true })[1]) or vim.fn.getcwd()

  local venv_paths = {
    "/bin/python",
    "/bin/python3",
    "/.venv/bin/python",
    "/venv/bin/python",
    "/env/bin/python",
    "/.env/bin/python",
    "/.venv/Scripts/python.exe",
    "/venv/Scripts/python.exe",
  }

  -- 1. Check if VIRTUAL_ENV is already set (activated shell)
  if vim.env.VIRTUAL_ENV then
    local env_python = vim.env.VIRTUAL_ENV .. "/bin/python"
    if vim.fn.executable(env_python) == 1 then
      return env_python
    end
  end

  -- 2. Check for local venvs relative to project root
  for _, path in ipairs(venv_paths) do
    local full_path = root_dir .. path
    if vim.fn.executable(full_path) == 1 then
      return full_path
    end
  end

  -- 3. Check for local venvs relative to current directory
  local cwd = vim.fn.getcwd()
  for _, path in ipairs(venv_paths) do
    local full_path = cwd .. path
    if vim.fn.executable(full_path) == 1 then
      return full_path
    end
  end

  -- Fallback to system python
  return vim.fn.exepath("python3") or vim.fn.exepath("python") or "python"
end

-- coc-pyright 설정 업데이트
local python_path = get_python_path()
vim.g.coc_user_config = vim.tbl_deep_extend("force", vim.g.coc_user_config or {}, {
  ["python.pythonPath"] = python_path,
  ["python.defaultInterpreterPath"] = python_path
})

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

