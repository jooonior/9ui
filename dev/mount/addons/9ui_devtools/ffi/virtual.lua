-- FFI definitions for calling virtual member functions of objects.

local ffi = require "ffi"

ffi.cdef [[
  struct vfunc;
  typedef struct { struct vfunc **__vt; } virtual;
]]

ffi.metatype("struct vfunc", {
  __index = {
    ---Cast `self` to specified `signature`. Automatically adds the _this_
    ---pointer as the first parameter.
    as = function(self, signature)
      local returns, params = string.match(signature, "([^(]+)(%b())")

      -- Insert `virtual * this` as first parameter.
      if params:match('%(%s*%)') or params:match('%(%s*void%s*%)') then
        params = "(virtual * this)"
      else
        params = ("(virtual * this, %s"):format(params:sub(2))
      end

      -- Cast to function pointer.
      local ctype = ("%s (*)%s"):format(returns, params)
      ---@diagnostic disable-next-line:param-type-mismatch
      return ffi.cast(ctype, self)
    end
  }
})

---Holds bound methods for all `cdata<virtual *>` instances.
local virtual = setmetatable({}, {
  -- Automatically create tables for new instances.
  __index = function(self, k)
    local v = {}
    self[k] = v
    return v
  end,
  -- Don't prevent `cdata<virtual *>` keys from being garbage collected.
  __mode = "k",
})

---Binds virtual function at index `i` with specified `signature`.
local function bind(self, i, signature)
  -- Parse function signature.
  local returns, name, params = string.match(
    signature,
    "%s*([^%(]-)%s*([%a_][%w_]*)%s*(%b())"
  )
  virtual[self][name] = self.__vt[i]:as(returns .. params)
end

-- Expose `__bind` as a method of `cdata<virtual *>` instances.
ffi.metatype("virtual", {
  __index = function(self, k)
    return k == '__bind' and bind or virtual[self][k]
  end,
})

-- So that you can access the binding table if you want to.
return virtual
