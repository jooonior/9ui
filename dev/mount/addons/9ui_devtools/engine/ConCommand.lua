local ffi = require "ffi"

local class = require "9ui_devtools.ffi.class"

-- FFI definitions.
require "9ui_devtools.engine.CCommand"


ffi.cdef [[
// Taken source-sdk-2013: <tier1/convar.h>.

typedef void ( *FnCommandCallback_t )( const CCommand &command );

struct ConCommand
{
  // Virtual function table poiner.
  void **__vt;

  // ConCommandBase data members.

  void *m_pNext;

  bool m_bRegistered;

  const char *m_pszName;
  const char *m_pszHelpString;

  int m_nFlags;

  // ConCommand data members.

  FnCommandCallback_t m_fnCommandCallback;
  void *m_fnCompletionCallback;

  bool m_bHasCompletionCallback : 1;
  bool m_bUsingNewCommandCallback : 1;
  bool m_bUsingCommandCallbackInterface : 1;
};
]]

local vtable = nil

local function find_vtable()
  local ifc = require "9ui_devtools.interfaces"

  if ifc.cvar == nil then
    return nil
  end

  local command = ifc.cvar:FindCommand("echo")
  if command == nil then
    return nil
  end

  if not command:IsCommand() then
    return nil
  end

  return ffi.cast("void ***", command)[0]
end

local metatable = {}

---@class ConCommandSpec
---@field name string
---@field description string
---@field flags? integer
---@field callback fun(args: unknown): nil

---Create a new ConCommand. It must not be garbage collected while registered.
---@param opts ConCommandSpec
---@return ffi.cdata* ConCommand
function metatable:__new(opts)
  local name = assert(opts.name, "missing option 'name'")
  local description = assert(opts.description, "missing option 'description'")
  local flags = opts.flags or 0
  local callback = assert(opts.callback, "missing option 'callback'")

  if vtable == nil then
    vtable = find_vtable()
    assert(vtable ~= nil, "cannot locate ConCommand vtable")
  end

  local safe_callback = ffi.cast("FnCommandCallback_t", function(args)
    args = ffi.cast("CCommand *", args)
    local success, result = pcall(callback, args)
    if not success then
      warn(result)
    end
  end)

  local command = ffi.new("ConCommand", {
    __vt = vtable,
    m_pNext = nil,
    m_bRegistered = false,
    m_pszName = name,
    m_pszHelpString = description,
    m_nFlags = flags,
    m_fnCommandCallback = safe_callback,
    m_fnCompletionCallback = nil,
    m_bHasCompletionCallback = false,
    m_bUsingNewCommandCallback = true,
    m_bUsingCommandCallbackInterface = false,
  })

  return command
end

function metatable:__gc()
  self.m_fnCommandCallback:free()
end

return class {
  "ConCommand",
  vtable = {
    [1] = [[
      bool IsCommand()
    ]],
  },
  metatable = metatable,
}
