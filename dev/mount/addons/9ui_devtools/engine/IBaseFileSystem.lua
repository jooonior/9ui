local class = require "9ui_devtools.ffi.class"


return class {
  "IBaseFileSystem",
  vtable = {
    [10] = [[
      bool FileExists(const char *fileName, const char *pathID)
    ]],
  },
}
