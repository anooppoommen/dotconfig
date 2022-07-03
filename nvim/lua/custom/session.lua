local M = {}

vim.opt.sessionoptions = "buffers,curdir,folds,help,tabpages,winsize,winpos,terminal"
vim.g.session_dir = vim.fn.stdpath "config" .. "/sessions"

if vim.fn.isdirectory(vim.g.session_dir) == 0 then
  vim.fn.mkdir(vim.g.session_dir, "p")
end


local function get_session_name()
  if vim.fn.trim(vim.fn.system "git rev-parse --is-inside-work-tree") == "true" then
    return vim.fn.trim(vim.fn.system "basename `git rev-parse --show-toplevel`") .. ".vim"
  else
    return "Session.vim"
  end
end

local function make_session(session_name)
  local cmd = "mks! " .. session_name
  vim.cmd(cmd)
end

local function info(msg)
  vim.notify(msg, vim.log.levels.INFO)
end

function M.save_sesion()
  local session_name = get_session_name()
  session_name = vim.g.session_dir .. "/" ..session_name
  make_session(session_name)
  info("Session save successfully to " .. session_name)
end

function M.load_session()
  local session_name = get_session_name()
  session_name = vim.g.session_dir .. "/" .. session_name

  -- check if file exists
  local f=io.open(session_name,"r")
  if f == nil then
    info("No sesion file found")
    return
  else
    io.close(f)
  end

  local cmd = "source " .. session_name
  vim.cmd(cmd)
  info("Loadded session " .. session_name)
end



function M.setup()
  local session_name = get_session_name()
  session_name = vim.g.session_dir .. "/" .. session_name

  -- Create autocmd
  local grp = vim.api.nvim_create_augroup("SessionTracking", { clear = true })
  vim.api.nvim_create_autocmd("VimLeave", {
    pattern = "*",
    callback = function()
      M.save_sesion()
    end,
    group = grp,
  })

  -- autoload session on restart 
  vim.api.nvim_create_autocmd("VimEnter", {
    pattern = "*",
    callback = function()
      -- this simply does not work as 
      -- not all the require plugins will be loaded in time 
      -- for us to use so skipping this for now 😭
      -- as a temporary fix we will map over this funtionality 
      -- to <leader>ss
      -- M.load_session()
    end,
    group = grp
  })
end

return M
