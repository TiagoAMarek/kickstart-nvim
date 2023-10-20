local M = {}

--- Get an icon from the kickstart internal icons if it is available and return it
---@param kind string The kind of icon in kickstart.icons to retrieve
---@param padding? integer Padding to add to the end of the icon
---@param no_fallback? boolean Whether or not to disable fallback to text icon
---@return string icon
function M.get_icon(kind, padding, no_fallback)
  if not vim.g.icons_enabled and no_fallback then return "" end
  local icon_pack = vim.g.icons_enabled and "icons" or "text_icons"
  if not M[icon_pack] then
    M.icons = require("kickstart.icons.nerd_font")
    M.text_icons = require("kickstart.icons.text")
  end
  local icon = M[icon_pack] and M[icon_pack][kind]
  return icon and icon .. string.rep(" ", padding or 0) or ""
end

--- Check if a plugin is defined in lazy. Useful with lazy loading when a plugin is not necessarily loaded yet
---@param plugin string The plugin to search for
---@return boolean available # Whether the plugin is available
function M.is_available(plugin)
  local lazy_config_avail, lazy_config = pcall(require, "lazy.core.config")
  return lazy_config_avail and lazy_config.spec.plugins[plugin] ~= nil
end

return M
