local ffi = require "ffi"

local class = require "9ui_devtools.ffi.class"

-- FFI definitions.
require "9ui_devtools.engine.Panel"


ffi.cdef [[
typedef void *VPANEL;
]]


return class {
  "IPanel",
  vtable = {
    [15] = [[
      bool IsVisible(VPANEL vguiPanel)
    ]],
    [17] = [[
      int GetChildCount(VPANEL vguiPanel)
    ]],
    [18] = [[
      VPANEL GetChild(VPANEL vguiPanel, int index)
    ]],
    [36] = [[
      const char *GetName(VPANEL vguiPanel)
    ]],
    [55] = [[
      Panel *GetPanel(VPANEL vguiPanel, const char *destinationModule)
    ]],
  },
}
