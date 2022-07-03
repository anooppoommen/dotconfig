-- Just an example, supposed to be placed in /lua/custom/

local M = {}

local function termcodes(str)
   return vim.api.nvim_replace_termcodes(str, true, true, true)
end

-- make sure you maintain the structure of `core/default_config.lua` here,
-- example of changing theme:

M.ui = {
   theme = "radium",
   theme_toggle = { "onedark", "one_light", "rxyhn" },
}





-- set highight color
vim.cmd [[ highlight IndentBlankline ctermfg=yellow guifg=#E5C07B gui=nocombine ]]
-- abandoing this as it could be performance issue will check this later
-- vim.cmd [[ set autoread | au CursorHold * checktime | call feedkeys("lh") ]]


vim.opt.list = true
vim.opt.listchars:append("space:⋅")
vim.opt.listchars:append("eol:↴")

M.plugins = {
   options = {
      lspconfig = {
         setup_lspconf = "custom.config.plugins.lspconfig",
      },
   },
   override = {
     ["kyazdani42/nvim-tree.lua"] = {
      view = {
        side = "right",
        width = 27,
      },
      filters = {
        exclude = { ".git/" }
      },
      git = {
        enable = true,
        -- make sure ignore files and folder are visible
        ignore = false,
      },
      renderer = {
        highlight_git = true,
        icons = {
          show = {
            git = true,
          },
        },
      },
     },
     treesitter = {
       ensure_installed = {
         "vim",
         "html",
         "css",
         "javascript",
         "json",
         "toml",
         "markdown",
         "c",
         "bash",
         "lua",
         "norg",
         "go",
       }
     },
     blankline = {
      filetype_exclude = {
        "help",
        "terminal",
        "alpha",
        "packer",
        "lspinfo",
        "TelescopePrompt",
        "TelescopeResults",
        "nvchad_cheatsheet",
        "lsp-installer",
        "norg",
        "",
      },
     },
     space_char_blankline = " ",
     char_highlight_list = { "IndentBlankline" },
  },
  user = require "custom.plugins",
}

M.mappings =  {
  nvterm = {
    t = {
      ['<Esc>'] = {termcodes "<C-\\><C-N>", "Switch terminal mode"}
    }
  },
  general = {
    n = {
      ['<A-Left>'] = { ':vertical resize +3<CR>', "Resize vertical window" },
      ['<A-Right>'] = { ':vertical resize -3<CR>', "Resize vertical window" },
      ['<A-Up>'] = { ':resize +3<CR>', "Resize horizontal window" },
      ['<A-Down>'] = { ':resize -3<CR>', "Resize horizontal window" },
      ['<leader>ss'] = { ":lua require('custom.session').load_session()<CR><CR>", "Load last saved session"},
     }
  }
}

-- Auot session stuff
require("custom.session").setup()


return M

