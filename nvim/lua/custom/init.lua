local autocmd = vim.api.nvim_create_autocmd
local new_cmd = vim.api.nvim_create_user_command
local opt = vim.opt

--autocmd Filetype css setlocal tabstop=4
autocmd("Filetype", {
  pattern = "go",
  callback = function ()
    opt.shiftwidth=2
    opt.tabstop=2
    opt.expandtab=false
  end
})

-- TODO: Move this to a helper script
local function list(value, str, sep)
  sep = sep or ","
  str = str or ""
  value = type(value) == "table" and table.concat(value, sep) or value
  return str ~= "" and table.concat({value, str}, sep) or value
end

opt.list = true
opt.listchars:append("space:⋅")
opt.listchars:append("eol:↴")

opt.fillchars = list {
  -- "vert:▏",
  "vert:│",
  "diff:╱",
  "foldclose:",
  "foldopen:",
  "eob: "
}
