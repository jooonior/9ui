local ffi = require "ffi"

if jit.os == "Windows" then

  -- Windows API functions and constants.

  ffi.cdef [[
    typedef int BOOL;
    typedef char CHAR;
    typedef unsigned long DWORD;
    typedef void *HANDLE;
    typedef const CHAR *LPCSTR;
    typedef unsigned short WORD;

    typedef struct _FILETIME {
      DWORD dwLowDateTime;
      DWORD dwHighDateTime;
    } FILETIME, *PFILETIME, *LPFILETIME;

    typedef struct _WIN32_FIND_DATAA {
      DWORD    dwFileAttributes;
      FILETIME ftCreationTime;
      FILETIME ftLastAccessTime;
      FILETIME ftLastWriteTime;
      DWORD    nFileSizeHigh;
      DWORD    nFileSizeLow;
      DWORD    dwReserved0;
      DWORD    dwReserved1;
      CHAR     cFileName[260];  // MAX_PATH
      CHAR     cAlternateFileName[14];
      DWORD    dwFileType; // Obsolete. Do not use.
      DWORD    dwCreatorType; // Obsolete. Do not use
      WORD     wFinderFlags; // Obsolete. Do not use
    } WIN32_FIND_DATAA, *PWIN32_FIND_DATAA, *LPWIN32_FIND_DATAA;

    HANDLE FindFirstFileA(
      LPCSTR             hFindFile,
      LPWIN32_FIND_DATAA lpFindFileData
    );

    BOOL FindNextFileA(
      HANDLE             hFindFile,
      LPWIN32_FIND_DATAA lpFindFileData
    );

    BOOL FindClose(
      HANDLE hFindFile
    );
  ]]

  local INVALID_HANDLE_VALUE = ffi.cast("HANDLE", ffi.cast("DWORD", -1))
  local FILE_ATTRIBUTE_DIRECTORY = 0x00000010

  ---Iterate over files and directories matching specified `pattern`.
  ---Found directories will end with a trailing backslash.
  ---@param pattern string
  ---@return fun(): string | nil
  local function glob(pattern)
    local data = ffi.new("WIN32_FIND_DATAA")
    local handle = ffi.gc(
      ffi.C.FindFirstFileA(pattern, data),
      ffi.C.FindClose
    )

    return function()
      while handle ~= INVALID_HANDLE_VALUE do
        local filename = ffi.string(data.cFileName)

        if ffi.C.FindNextFileA(handle, data) == 0 then
          handle = INVALID_HANDLE_VALUE
        end

        -- Skip current and parent directories.
        if filename ~= "." and filename ~= ".." then
          -- Append trailing slash to directories.
          if bit.band(data.dwFileAttributes, FILE_ATTRIBUTE_DIRECTORY) ~= 0 then
            filename = filename .. "\\"
          end

          return filename
        end
      end

      ffi.C.FindClose(ffi.gc(handle, nil))
      return nil
    end
  end

  return glob

else
  error(("%s not supported"):format(jit.os))
end
