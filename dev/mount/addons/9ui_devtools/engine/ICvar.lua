local class = require "9ui_devtools.ffi.class"

-- FFI definitions.
require "9ui_devtools.engine.ConCommand"


return class {
  "ICvar",
  vtable = {
    [6] = [[
      void RegisterConCommand(ConCommand *command)
    ]],
    [7] = [[
      void UnregisterConCommand(ConCommand *command)
    ]],
    [14] = [[
      ConCommand *FindCommand(const char *name)
    ]],
  },
}
