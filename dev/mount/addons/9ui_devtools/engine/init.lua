local lazyimport = require "9ui_devtools.utils.lazyimport"


return setmetatable({}, {
  __index = lazyimport(...)
})
