-- Minimal placeholder config for avante.nvim
return function()
    require("avante").setup({
        provider = "openai",
        openai = {
          endpoint = "https://api.openai.com/v1",
          model = "gpt-4o", -- your desired model (or use gpt-4o, etc.)
          timeout = 30000, -- Timeout in milliseconds, increase this for reasoning models
          temperature = 0,
          max_completion_tokens = 8192, -- Increase this to include reasoning tokens (for reasoning models)
          --reasoning_effort = "medium", -- low|medium|high, only used for reasoning models
        },
        rag_service = {
          enabled = false, -- 일단 OFF로 테스트 추천
                  host_mount = vim.fn.getcwd(), -- 필요한 경우 프로젝트 루트 mount
          runner = "docker",
          provider = "openai",
          llm_model = "gpt-4o",
          embed_model = "text-embedding-ada-002",
        },
    })
end
