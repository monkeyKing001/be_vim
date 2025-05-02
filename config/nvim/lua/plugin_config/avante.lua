-- Minimal placeholder config for avante.nvim
return function()
    require("avante").setup({
        provider = "gemini",
        gemini = {
            -- @see https://ai.google.dev/gemini-api/docs/models/gemini
            model = "gemini-2.0-flash",
            -- model = "gemini-1.5-flash",
            temperature = 0,
            max_tokens = 10000,
            timeout = 30000,
        },
        behaviour = {
            auto_suggestions = false, -- Experimental stage
            auto_set_highlight_group = true,
            auto_set_keymaps = true,
            auto_apply_diff_after_generation = false,
            support_paste_from_clipboard = false,
        },
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
