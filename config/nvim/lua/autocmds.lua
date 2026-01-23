--============================================================--
--                      Neovim Autocommands                    --
--============================================================--

-- API helpers
local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

-- Create a general group for user autocommands
local general_group = augroup("UserAutocmds", { clear = true })

-- [[ Template insertion on new files ]]
autocmd("BufNewFile", {
  group = general_group,
  pattern = "*.c",
  command = "0r ~/.vim/templates/skeleton.c",
})

autocmd("BufNewFile", {
  group = general_group,
  pattern = "*.cpp",
  command = "0r ~/.vim/templates/skeleton.cpp",
})

autocmd("BufNewFile", {
  group = general_group,
  pattern = "*.java",
  command = "0r ~/.vim/templates/skeleton.java",
})

autocmd("BufNewFile", {
  group = general_group,
  pattern = "Makefile",
  command = "0r ~/.vim/templates/skeleton_makefile",
})

autocmd("BufNewFile", {
  group = general_group,
  pattern = "README.md",
  command = "0r ~/.vim/templates/README.md",
})

-- [[ Auto-format C/C++ headers and sources on save ]]
autocmd("BufWritePre", {
  group = general_group,
  pattern = { "*.cpp", "*.h" },
  callback = function()
    vim.fn.CocAction("format")
  end,
})

-- 저장 시 자동 포맷 (Python 제외 - coc-settings.json에서 처리)
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = { "*.js", "*.ts" },
  command = "silent! call CocAction('format')",
})

-- [[ Auto-open Location List if errors exist (on Save) ]]
autocmd("BufWritePost", {
  group = general_group,
  pattern = "*",
  callback = function()
    -- 약간의 딜레이를 주어 린터가 업데이트될 시간을 줌
    vim.defer_fn(function()
      local info = vim.fn.CocAction("diagnosticList")
      
      -- Location List에 넣을 아이템 목록 구성
      local items = {}
      if type(info) == "table" then
        for _, d in ipairs(info) do
          -- Error와 Warning 모두 추가 (필터링 가능)
          if d.severity == 'Error' then
            table.insert(items, {
              filename = d.file,
              lnum = d.lnum,
              col = d.col,
              text = '[' .. d.severity .. '] ' .. d.message, -- 메시지 앞에 타입 표시
              type = (d.severity == 'Error') and 'E'
            })
          end
        end
      end

      if #items > 0 then
        -- Location List를 갱신하고 열기
        vim.fn.setloclist(0, items, 'r')
        vim.cmd("lopen 5") -- 높이 5로 열기
        vim.cmd("wincmd p") -- 커서는 다시 편집창으로
      else
        -- 에러 없으면 닫기
        vim.cmd("lclose")
      end
    end, 200) -- 0.2초 딜레이
    
    -- 저장 후 Tree-sitter 하이라이팅 강제 재활성화 (색상 사라짐 방지)
    vim.cmd("TSBufEnable highlight")
  end,
})
