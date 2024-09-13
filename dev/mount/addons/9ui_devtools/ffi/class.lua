local ffi = require "ffi"


local function parse_member_function(signature)
  local returns, name, params = string.match(
    signature,
    "%s*([^%(]-)%s*([%a_][%w_]*)%s*(%b())"
  )

  -- Insert `void *this` as first parameter.
  if params:match('%(%s*%)') or params:match('%(%s*void%s*%)') then
    params = "(void *this)"
  else
    params = ("(void *this, %s"):format(params:sub(2))
  end

  -- Cast to function pointer.
  local cdecl = ("%s (*)%s"):format(returns, params)
  ---@cast cdecl ffi.cdecl*
  return name, cdecl
end


---@class ClassSpec
---@field [1] ffi.cdecl* Name of the class.
---@field base? ffi.cdecl* Name of base class (if any).
---@field vtable? table<integer, ffi.cdecl*> Virtual functions (if any).
---@field metatable? metatable

---Declare a C++ class as a FFI metatype.
---@param opts ClassSpec
---@return ffi.ctype*
local function class(opts)
  local name = opts[1]
  local base = opts.base or nil
  local vtable = opts.vtable or {}
  local metatable = opts.metatable or {}

  local members = {}

  for index, signature in pairs(vtable) do
    local fn_name, fn_cdecl = parse_member_function(signature)
    local fn_ctype = ffi.typeof(fn_cdecl)

    members[fn_name] = function(self, ...)
      local vt = ffi.cast("void ***", self)[0]
      local vf = ffi.cast(fn_ctype, vt[index])
      return vf(self, ...)
    end
  end

  local index = metatable.__index or {}
  assert(type(index) ~= "function", "function '__index' not supported")
  setmetatable(index, { __index = members })

  if base == nil then
    metatable.__index = index
  else
    local base_ptr = ffi.typeof(base .. "*")
    function metatable:__index(key)
      return index[key] or ffi.cast(base_ptr, self)[key]
    end
  end

  ffi.cdef(("struct %s; typedef struct %s %s;"):format(name, name, name))
  return ffi.metatype(name, metatable)
end


return class
