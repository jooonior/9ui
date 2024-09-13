---@diagnostic disable-next-line:lowercase-global
function assertf(v, fmt, ...)
  return v or error(string.format(fmt, ...))
end
