return {
  -- Multiple colorschemes
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require("tokyonight").setup({
        style = "night", -- storm, moon, night, day
        transparent = false,
        terminal_colors = true,
        styles = {
          comments = { italic = true },
          keywords = { italic = true },
          functions = { bold = true },
          variables = {},
        },
        sidebars = { "qf", "help" },
        day_brightness = 0.3,
        hide_inactive_statusline = false,
        dim_inactive = false,
        lualine_bold = false,
        
        -- Custom colors for different languages
        on_colors = function(colors)
          colors.git = { change = "#6183bb", add = "#449dab", delete = "#f7768e" }
        end,
        
        on_highlights = function(highlights, colors)
          -- JavaScript specific
          highlights["@variable.javascript"] = { fg = "#7aa2f7" }
          highlights["@function.call.javascript"] = { fg = "#bb9af7" }
          highlights["@keyword.javascript"] = { fg = "#f7768e", style = { italic = true } }
          
          -- Python specific
          highlights["@variable.python"] = { fg = "#e0af68" }
          highlights["@function.python"] = { fg = "#7dcfff" }
          highlights["@keyword.python"] = { fg = "#bb9af7", style = { italic = true } }
          
          -- Lua specific
          highlights["@variable.lua"] = { fg = "#c0caf5" }
          highlights["@function.lua"] = { fg = "#7aa2f7", style = { bold = true } }
        end,
      })
      vim.cmd([[colorscheme tokyonight]])
    end,
  },
  
  -- Alternative colorschemes
  { "catppuccin/nvim", name = "catppuccin", lazy = true },
  { "rebelot/kanagawa.nvim", lazy = true },
  { "ellisonleao/gruvbox.nvim", lazy = true },
}