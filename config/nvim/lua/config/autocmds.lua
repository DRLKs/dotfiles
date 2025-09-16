-- Auto commands for language-specific highlighting
local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

-- Language-specific color adjustments
autocmd("FileType", {
  group = augroup("LanguageColors", { clear = true }),
  pattern = { "javascript", "typescript" },
  callback = function()
    -- Enhanced JS/TS highlighting
    vim.api.nvim_set_hl(0, "@variable", { fg = "#7aa2f7" })
    vim.api.nvim_set_hl(0, "@function.call", { fg = "#bb9af7", bold = true })
    vim.api.nvim_set_hl(0, "@keyword.function", { fg = "#f7768e", italic = true })
  end,
})

autocmd("FileType", {
  group = augroup("PythonColors", { clear = true }),
  pattern = "python",
  callback = function()
    -- Enhanced Python highlighting
    vim.api.nvim_set_hl(0, "@variable", { fg = "#e0af68" })
    vim.api.nvim_set_hl(0, "@function", { fg = "#7dcfff", bold = true })
    vim.api.nvim_set_hl(0, "@keyword", { fg = "#bb9af7", italic = true })
  end,
})

autocmd("FileType", {
  group = augroup("LuaColors", { clear = true }),
  pattern = "lua",
  callback = function()
    -- Enhanced Lua highlighting
    vim.api.nvim_set_hl(0, "@variable", { fg = "#c0caf5" })
    vim.api.nvim_set_hl(0, "@function", { fg = "#7aa2f7", bold = true })
    vim.api.nvim_set_hl(0, "@keyword", { fg = "#f7768e", italic = true })
  end,
})