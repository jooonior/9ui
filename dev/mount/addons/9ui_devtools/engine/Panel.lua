local class = require "9ui_devtools.ffi.class"

-- FFI definitions.
require "9ui_devtools.engine.KeyValues"


return class {
  "Panel",
  vtable = {
    [90] = [[
      void GetSettings(KeyValues *outResourceData)
    ]],
  },
}
