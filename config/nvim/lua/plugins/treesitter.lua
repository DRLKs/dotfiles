return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = { "BufReadPost", "BufNewFile" },
    dependencies = {
      "nvim-treesitter/nvim-treesitter-textobjects",
    },
    opts = {
      ensure_installed = { 
        "lua", "vim", "vimdoc", "javascript", "typescript", "python", 
        "html", "css", "json", "yaml", "markdown", "bash", "go", "rust" 
      },
      highlight = { 
        enable = true,
        additional_vim_regex_highlighting = false,
      },
      indent = { enable = true },
      textobjects = {
        select = {
          enable = true,
          lookahead = true,
          keymaps = {
            ["af"] = "@function.outer",
            ["if"] = "@function.inner",
            ["ac"] = "@class.outer",
            ["ic"] = "@class.inner",
          },
        },
      },
    },
    config = function(_, opts)
      require("nvim-treesitter.configs").setup(opts)
      
      -- Customize highlights for different languages
      vim.api.nvim_create_autocmd("ColorScheme", {
        callback = function()
          -- JavaScript/TypeScript
          vim.api.nvim_set_hl(0, "@variable.javascript", { fg = "#e06c75" })
          vim.api.nvim_set_hl(0, "@variable.typescript", { fg = "#e06c75" })
          vim.api.nvim_set_hl(0, "@function.javascript", { fg = "#61afef" })
          vim.api.nvim_set_hl(0, "@function.typescript", { fg = "#61afef" })
          vim.api.nvim_set_hl(0, "@keyword.javascript", { fg = "#c678dd" })
          vim.api.nvim_set_hl(0, "@keyword.typescript", { fg = "#c678dd" })
          vim.api.nvim_set_hl(0, "@string.javascript", { fg = "#98c379" })
          vim.api.nvim_set_hl(0, "@string.typescript", { fg = "#98c379" })
          
          -- TypeScript specific
          vim.api.nvim_set_hl(0, "@type.typescript", { fg = "#d19a66" })
          vim.api.nvim_set_hl(0, "@interface.typescript", { fg = "#56b6c2" })
          
          -- Python
          vim.api.nvim_set_hl(0, "@variable.python", { fg = "#e5c07b" })
          vim.api.nvim_set_hl(0, "@function.python", { fg = "#56b6c2" })
          vim.api.nvim_set_hl(0, "@keyword.python", { fg = "#d19a66" })
          vim.api.nvim_set_hl(0, "@string.python", { fg = "#98c379" })
          
          -- Lua
          vim.api.nvim_set_hl(0, "@variable.lua", { fg = "#abb2bf" })
          vim.api.nvim_set_hl(0, "@function.lua", { fg = "#61afef" })
          vim.api.nvim_set_hl(0, "@keyword.lua", { fg = "#c678dd" })
          vim.api.nvim_set_hl(0, "@string.lua", { fg = "#98c379" })
          
          -- HTML
          vim.api.nvim_set_hl(0, "@tag.html", { fg = "#e06c75" })
          vim.api.nvim_set_hl(0, "@tag.attribute.html", { fg = "#d19a66" })
          
          -- CSS
          vim.api.nvim_set_hl(0, "@property.css", { fg = "#56b6c2" })
          vim.api.nvim_set_hl(0, "@type.css", { fg = "#e5c07b" })
        end,
      })
    end,
  },
}