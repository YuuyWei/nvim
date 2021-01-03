local vim = vim
local path = vim.fn.stdpath('config')..'/xiaohe.txt'
local max = 4

local function parse(string)
  local words = {}
  for a, chinese in string.gmatch(string, [[(%l+)=%d+,(%S+)]]) do
    local code = string.format('[%s]', a)
    table.insert(words, {
      -- 总体宽度 UTF8中一个汉字3个字节，而等宽字体一般占2个字母宽度
      width = math.ceil(#chinese/3*2) + (#code),
      string = string.format('%s%s', chinese, code),
      chinese = chinese
    })
  end
  return words
end

local function search(input)
  -- 使用rg搜索词典
  local lines = vim.fn.system(string.format([[rg -e '^%s=' %s]], input, path))
  return {
    head = 0,
    words = parse(lines),
  }
end

local function values_at_most(t, max)
  local i = 0
  return function() i=i+1
    if i < max then 
      return t.words[t.head+i]
    else 
      t.head = t.head+i 
      return t.words[t.head+i]
    end
  end
end

local function process(result)
  local line_width = 0
  local line = ''

  if result.words[result.head + 1] then
    for word in values_at_most(result, max) do
      line_width = line_width + word.width + 1
      line = string.format('%s%s ', line, word.string)
    end
    line = vim.trim(line)
    line_width = line_width - 1
    header_width = #result.words[result.head+1].string
  else
    header_width = 1
    line_width = 1
  end
  return line, line_width, header_width
end

return {
  search = search,
  process = process
} 
