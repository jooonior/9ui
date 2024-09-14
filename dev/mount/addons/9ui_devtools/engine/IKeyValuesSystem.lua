local ffi = require "ffi"

local class = require "9ui_devtools.ffi.class"


ffi.cdef [[
typedef int HKeySymbol;
]]

return class {
  "IKeyValuesSystem",
  vtable = {
    [3] = [[
      HKeySymbol GetSymbolForString(const char *name, bool create)
    ]],
    [4] = [[
      const char *GetStringForSymbol(HKeySymbol symbol)
    ]],
  },
}
