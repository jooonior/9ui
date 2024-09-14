local ffi = require "ffi"

local class = require "9ui_devtools.ffi.class"

-- FFI definitions.
require "9ui_devtools.engine.IKeyValuesSystem"


ffi.cdef [[
IKeyValuesSystem *KeyValuesSystem();
]]

local vstdlib = ffi.load("vstdlib")

local function KeyValuesSystem()
  return vstdlib.KeyValuesSystem()
end


ffi.cdef [[
// Taken source-sdk-2013: <tier1/KeyValues.h>.

struct KeyValues;
typedef struct KeyValues KeyValues;

struct KeyValues
{
  int m_iKeyName;

  char *m_sValue;
  wchar_t *m_wsValue;

  union
  {
    int m_iValue;
    float m_flValue;
    void *m_pValue;
    unsigned char m_Color[4];
  };

  char m_iDataType;
  char m_bHasEscapeSequences;
  char m_bEvaluateConditionals;
  char unused[1];

  KeyValues *m_pPeer;   // pointer to next key in list
  KeyValues *m_pSub;    // pointer to Start of a new sub key list
  KeyValues *m_pChain;  // Search here if it's not in our list
};

enum types_t
{
  TYPE_NONE = 0,
  TYPE_STRING,
  TYPE_INT,
  TYPE_FLOAT,
  TYPE_PTR,
  TYPE_WSTRING,
  TYPE_COLOR,
  TYPE_UINT64,
  TYPE_NUMTYPES,
};
]]

local TYPE_NONE = ffi.C.TYPE_NONE
local TYPE_STRING = ffi.C.TYPE_STRING
local TYPE_INT = ffi.C.TYPE_INT
local TYPE_FLOAT = ffi.C.TYPE_FLOAT
local TYPE_PTR = ffi.C.TYPE_PTR
local TYPE_WSTRING = ffi.C.TYPE_WSTRING
local TYPE_COLOR = ffi.C.TYPE_COLOR
local TYPE_UINT64 = ffi.C.TYPE_UINT64
local TYPE_NUMTYPES = ffi.C.TYPE_NUMTYPES

local INVALID_KEY_SYMBOL = -1

local metatable = {
  __index = {}
}

function metatable:__new(name)
  local keyvalues = ffi.new("KeyValues", {
    m_iKeyName = INVALID_KEY_SYMBOL,
    m_iDataType = TYPE_NONE,

    m_pSub = nil,
    m_pPeer = nil,
    m_pChain = nil,

    m_sValue = nil,
    m_wsValue = nil,
    m_pValue = nil,

    m_bHasEscapeSequences = false,
    m_bEvaluateConditionals = true,
  })

  if name ~= nil then
    keyvalues:SetName(name)
  end

  return keyvalues
end

function metatable.__index.GetSymbolForStringClassic(name, create)
  create = create ~= nil and create or true
  return KeyValuesSystem():GetSymbolForString(name, create)
end

function metatable.__index.GetStringForSymbolClassic(symbol)
  return ffi.string(KeyValuesSystem():GetStringForSymbol(symbol))
end

function metatable.__index:GetName()
  return self.GetStringForSymbolClassic(self.m_iKeyName)
end

function metatable.__index:SetName(name)
  self.m_iKeyName = self.GetSymbolForStringClassic(name, true)
end

function metatable.__index:GetString()
  if self.m_sValue ~= nil then
    return ffi.string(self.m_sValue)
  elseif self.m_iDataType == TYPE_INT then
    return tostring(self.m_iValue)
  elseif self.m_iDataType == TYPE_FLOAT then
    return tostring(self.m_flValue)
  elseif self.m_iDataType == TYPE_PTR then
    return tostring(self.m_pValue)
  elseif self.m_iDataType == TYPE_UINT64 then
    return tostring(self.m_sValue)
  elseif self.m_iDataType == TYPE_WSTRING then
    return ffi.string(self.m_wsValue)
  else
    return ""
  end
end

function metatable.__index:GetFirstTrueSubKey()
  local subkey = self.m_pSub
  while subkey ~= nil and subkey.m_iDataType ~= TYPE_NONE do
    subkey = subkey.m_pPeer
  end
  return subkey
end

function metatable.__index:GetNextTrueSubKey()
  local subkey = self.m_pPeer
  while subkey ~= nil and subkey.m_iDataType ~= TYPE_NONE do
    subkey = subkey.m_pPeer
  end
  return subkey
end

function metatable.__index:GetFirstValue()
  local value = self.m_pSub
  while value ~= nil and value.m_iDataType == TYPE_NONE do
    value = value.m_pPeer
  end
  return value
end

function metatable.__index:GetNextValue()
  local value = self.m_pPeer
  while value ~= nil and value.m_iDataType == TYPE_NONE do
    value = value.m_pPeer
  end
  return value
end

local function iprint(indent, head, ...)
  print(("  "):rep(indent) .. tostring(head), ...)
end

function metatable.__index:Dump(depth)
  depth = depth or 0

  iprint(depth, ('"%s"'):format(self:GetName()))
  iprint(depth, "{")

  local value = self:GetFirstValue()
  while value ~= nil do
    iprint(depth + 1, ('"%s" "%s"'):format(value:GetName(), value:GetString()))
    value = value:GetNextValue()
  end

  local subkey = self:GetFirstTrueSubKey()
  while subkey ~= nil do
    subkey:Dump(depth + 1)
    subkey = subkey:GetNextTrueSubKey()
  end

  iprint(depth, "}")
end

return class {
  "KeyValues",
  metatable = metatable,
}
