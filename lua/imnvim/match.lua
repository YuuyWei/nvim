local vim = vim
local path = vim.fn.stdpath('config')..'/xiaohe.txt'

local parse = function(string)
    local results = {}
    for alphas, chinese in string.gmatch(string, [[(%l+)=%d+,(%S+)]]) do
        table.insert(results, {
            -- 总体宽度 UTF8中一个汉字3个字节，而等宽字体一般占2个字母宽度
            width = math.ceil(#chinese/3*2) + #alphas + 2,
            string = string.format('%s[%s]', chinese, alphas)
        })
    end
    return results
end

local function search(input)
    -- 使用rg搜索词典
    local lines = vim.fn.system(string.format([[rg -e '^%s=' %s]], input, path))
    return parse(lines)
end


return search

