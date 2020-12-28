local vim = vim
local input = 'wo'
local path = vim.fn.stdpath('config')..'/xiaohe.txt'
local lines = vim.fn.system(string.format([[rg -e '^%s=' %s]], input, path))


local parse = function(string)
    local results = {}
    for alphas, chinese in string.gmatch(string, [[(%l+)=%d+,(%S+)]]) do
        table.insert(results, {
            -- 总体宽度 UTF8中一个汉字3个字节，而等宽字体一般占2个字母宽度
            width = math.ceil(#chinese/3*2) + #alphas + 2,
            string = chinese .. '['.. alphas ..']',
        })
    end
    return results
end

return parse(lines)

