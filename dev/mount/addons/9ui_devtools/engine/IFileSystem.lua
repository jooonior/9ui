local class = require "9ui_devtools.ffi.class"


return class {
  "IFileSystem",
  vtable = {
    [7] = [[
      void AddSearchPath(const char *path, const char *pathID, int addType)
    ]],
    [8] = [[
      void RemoveSearchPath(const char *path, const char *pathID)
    ]],
    [13] = [[
      int GetSearchPath(const char *pathID, bool getPackFiles, char *out, int maxLenInChars)
    ]],
  },
}
