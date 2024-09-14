local ffi = require "ffi"

local class = require "9ui_devtools.ffi.class"


ffi.cdef [[
// Taken source-sdk-2013: <tier1/convar.h>.

enum
{
  COMMAND_MAX_ARGC = 64,
  COMMAND_MAX_LENGTH = 512,
};

struct CCommand
{
  int m_nArgc;
  int m_nArgv0Size;
  char m_pArgSBuffer[ COMMAND_MAX_LENGTH ];
  char m_pArgvBuffer[ COMMAND_MAX_LENGTH ];
  const char *m_ppArgv[ COMMAND_MAX_ARGC ];
};
]]

local metatable = {
  __index = {},
}

function metatable.__index:ArgC()
  return self.m_nArgc
end

function metatable.__index:Arg(index)
  if index < self:ArgC() then
    return ffi.string(self.m_ppArgv[index])
  else
    return nil
  end
end

function metatable.__index:ArgS()
  if self.m_nArgv0Size > 0 then
    return ffi.string(self.m_pArgSBuffer + self.m_nArgv0Size)
  else
    return ""
  end
end

return class {
  "CCommand",
  metatable = metatable,
}
