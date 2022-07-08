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


local hl = require("custom.hl");
local hi, hi_link = hl.hi, hl.hi_link
local Color = require("custom.color").Color

function M.generate_diff_colors(opt)
  opt = opt or {}
  local bg = vim.o.bg
  local hl_bg_normal = hl.get_bg("Normal") or (bg == "dark" and "#111111" or "#eeeeee")

  if type(opt.no_derive) == "nil" then
    opt.no_derive = {}
  elseif type(opt.no_derive) == "boolean" then
    opt.no_derive = { all = true }
  end

  local bg_normal = Color.from_hex(hl_bg_normal)
  local bright = bg_normal.lightness >= 0.5

  local base_colors = {}
  if not opt.no_derive.all then
    base_colors.add = not opt.no_derive.add and Color.from_hl("diffAdded", "fg") or nil
    base_colors.del = not opt.no_derive.del and Color.from_hl("diffRemoved", "fg") or nil
    base_colors.mod = not opt.no_derive.mod and Color.from_hl("diffChanged", "fg") or nil
  end

  if bright then
    base_colors = vim.tbl_extend("keep", base_colors, {
      add = Color.from_hex("#97BE65"):mod_lightness(-0.2),
      del = Color.from_hex("#FF6C69"):mod_lightness(-0.1),
      mod = Color.from_hex("#51afef"):mod_lightness(-0.1):mod_value(-0.15),
    })
  else
    base_colors = vim.tbl_extend("keep", base_colors, {
      add = Color.from_hex("#97BE65"),
      del = Color.from_hex("#FF6C69"),
      mod = Color.from_hex("#51afef"),
    })
  end

  ---@type Color
  local base_add = base_colors.add
  ---@type Color
  local base_del = base_colors.del
  ---@type Color
  local base_mod = base_colors.mod

  local bg_add = base_add:blend(bg_normal, 0.85):mod_saturation(0.05)
  local bg_add_text = base_add:blend(bg_normal, 0.7):mod_saturation(0.05)
  local bg_del = base_del:blend(bg_normal, 0.85):mod_saturation(0.05)
  local bg_del_text = base_del:blend(bg_normal, 0.7):mod_saturation(0.05)
  local bg_mod = base_mod:blend(bg_normal, 0.85):mod_saturation(0.05)
  local bg_mod_text = base_mod:blend(bg_normal, 0.7):mod_saturation(0.05)

  if not opt.no_override then
    hi("DiffAdd", { bg = bg_add:to_css(), fg = "NONE", gui = "NONE" })
    hi("DiffDelete", { bg = bg_del:to_css(), fg = "NONE", gui = "NONE" })
    hi("DiffChange", { bg = bg_mod:to_css(), fg = "NONE", gui = "NONE" })
    hi("DiffText", { bg = bg_mod_text:to_css(), fg = "NONE", gui = "NONE" })

    hi("diffAdded", { fg = base_add:to_css(), bg = "NONE", gui = "NONE" })
    hi("diffRemoved", { fg = base_del:to_css(), bg = "NONE", gui = "NONE" })
    hi("diffChanged", { fg = base_mod:to_css(), bg = "NONE", gui = "NONE" })
  end

  hi("DiffAddText", { bg = bg_add_text:to_css(), fg = "NONE", gui = "NONE" })
  hi("DiffDeleteText", { bg = bg_del_text:to_css(), fg = "NONE", gui = "NONE" })

  hi("DiffInlineAdd", { bg = bg_add:to_css(), fg = base_add:to_css(), gui = "NONE" })
  hi("DiffInlineDelete", { bg = bg_del:to_css(), fg = base_del:to_css(), gui = "NONE" })
  hi("DiffInlineChange", { bg = bg_mod:to_css(), fg = base_mod:to_css(), gui = "NONE" })
end

local diff_gen_opt = { no_derive = { mod = true } }
M.generate_diff_colors(diff_gen_opt);


hi("DiffAddAsDelete", {
  bg = hl.get_bg("DiffDelete", true) or "#FF6C69",
  fg = hl.get_fg("DiffDelete", true) or "NONE",
  gui = hl.get_gui("DiffDelete", true) or "NONE",
})
hi_link("DiffDelete", "Comment")
hi_link("GitSignsAddLn", "DiffInlineAdd")
hi_link("GitSignsDeleteLn", "DiffInlineDelete")
hi_link("GitSignsChangeLn", "DiffInlineChange")
hi_link("GitSignsAdd", "diffAdded")
hi_link("GitSignsDelete", "diffRemoved")
hi_link("GitSignsChange", "diffChanged")

hi_link("NeogitCommitViewHeader", "Title")
hi_link("NeogitDiffAddHighlight", "DiffInlineAdd")
hi_link("NeogitDiffDeleteHighlight", "DiffInlineDelete")

function M.apply_terminal_defaults()
  -- black
  vim.g.terminal_color_0  = "#15161E"
  vim.g.terminal_color_8  = "#414868"
  -- red
  vim.g.terminal_color_1  = "#f7768e"
  vim.g.terminal_color_9  = "#f7768e"
  -- green
  vim.g.terminal_color_2  = "#9ece6a"
  vim.g.terminal_color_10 = "#9ece6a"
  -- yellow
  vim.g.terminal_color_3  = "#e0af68"
  vim.g.terminal_color_11 = "#e0af68"
  -- blue
  vim.g.terminal_color_4  = "#7aa2f7"
  vim.g.terminal_color_12 = "#7aa2f7"
  -- magenta
  vim.g.terminal_color_5  = "#bb9af7"
  vim.g.terminal_color_13 = "#bb9af7"
  -- cyan
  vim.g.terminal_color_6  = "#7dcfff"
  vim.g.terminal_color_14 = "#7dcfff"
  -- white
  vim.g.terminal_color_7  = "#a9b1d6"
  vim.g.terminal_color_15 = "#c0caf5"
end

M.apply_terminal_defaults()

local bg_normal = Color.from_hex("#101317")
local cursor_line_bg =  bg_normal:clone():mod_value(-0.05)

hi("LspReferenceText", {
  bg = cursor_line_bg:highlight(0.08):to_css(),
  unlink = true,
  explicit = true,
})
hi_link({ "LspReferenceRead", "LspReferenceWrite" }, "LspReferenceText", { clear = true })
hi_link(
  { "illuminateWord", "illuminatedWord", "illuminatedCurWord" },
  "LspReferenceText",
  { clear = true }
)
hi_link("IndentBlanklineSpaceChar", "Whitespace")

-- end git color config

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

