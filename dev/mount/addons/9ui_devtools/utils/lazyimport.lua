---Create a metatable `__index` function that `require`s missing keys.
---@param path string Module path (as in `arg[0]`).
---@return fun(self: table, key: string): unknown
local function lazyimport(path)
  ---Module root (without `.init`) path.
  local basepath = string.gsub(path, "%.?init$", "")

  return function(self, key)
    local success, value = pcall(require, ("%s.%s"):format(basepath, key))

    if not success then
      return nil
    end

    self[key] = value
    return value
  end
end

return lazyimport
