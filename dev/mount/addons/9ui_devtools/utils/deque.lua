local deque = {}

function deque.new()
  local instance = {
    first = 0,
    last = -1,
  }
  return setmetatable(instance, {
    __index = deque,
  })
end

function deque:push_left(item)
  local index = self.first - 1
  self[index] = item
  self.first = index
end

function deque:push_right(item)
  local index = self.last + 1
  self[index] = item
  self.last = index
end

function deque:pop_left()
  local first = self.first
  if first > self.last then
    return nil
  end

  local item = self[first]
  self[first] = nil
  self.first = first + 1
  return item
end

function deque:pop_right()
  local last = self.last
  if self.first > last then
    return nil
  end

  local item = self[last]
  self[last] = nil
  self.last = last - 1
  return item
end

function deque:empty()
  return self.first > self.last
end

return deque
