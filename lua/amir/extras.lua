-- lua/amir/extras.lua
local config = require("amir.config")

-- ToggleTerm (terminal integration)
if config.enable_terminal then
  require("toggleterm").setup({
    direction = "float",
    open_mapping = [[<c-\>]],
  })
end


-- Close dashboard tab after file is opened from it
vim.api.nvim_create_autocmd("User", {
  pattern = "AlphaReady",
  callback = function()
    local alpha_tab = vim.api.nvim_get_current_tabpage()

    vim.api.nvim_create_autocmd("BufReadPost", {
      once = true,
      callback = function()
        local current_tab = vim.api.nvim_get_current_tabpage()
        if current_tab ~= alpha_tab then
          vim.cmd("tabclose " .. alpha_tab)
        end
      end,
    })
  end,
})


-- Extra HELP!!!!

vim.api.nvim_create_user_command("EasyNvimHelp", function()
  vim.cmd("vsplit " .. vim.fn.stdpath("config") .. "/README.md")
  vim.cmd("set filetype=markdown")  
end, {})


-- Surround editing
if config.enable_surround then
  require("nvim-surround").setup({})
end

-- Auto-pairs for brackets and quotes
if config.enable_autopairs then
  require("nvim-autopairs").setup({})
end


local function tips_README()
  local tips = {}
  local start_marker = "<!----easynvim_tips_start-->"
  local end_marker = "<!----easynvim_tips_end-->"
  local readme_path = vim.fn.stdpath("config") .. "/README.md"

  local file = io.open(readme_path, "r")
  if not file then
    return "💡 Could not find README.md"
  end

  local lines = {}
  for line in file:lines() do
    table.insert(lines, line)
  end
  file:close()

  local start_idx, end_idx
  for i, line in ipairs(lines) do
    if not start_idx and line:find(start_marker, 1, true) then
      start_idx = i + 3 -- Skip marker + table title + separator line
    elseif start_idx and line:find(end_marker, 1, true) then
      end_idx = i - 1
      break
    end
  end

  if not start_idx or not end_idx then
    return "💡 Could not locate tip block in README.md"
  end

  for i = start_idx, end_idx do
    local line = lines[i]
    local keymap, mode, desc = line:match("|%s*`(.-)`%s*|%s*(.-)%s*|%s*(.-)%s*|")
    if keymap and mode and desc then
      table.insert(tips, { keys = keymap, desc = desc })
    end
  end

  if #tips == 0 then
    return "💡 No keymap tips found in README.md"
  end

  math.randomseed(os.time())
  local tip = tips[math.random(1, #tips)]
 return "Use `" .. tip.keys .. "` to " .. tip.desc .. "."
end

return {
  tips_README = tips_README,
}
