local jass = require 'jass.common'
local japi = require 'jass.japi'

local mt = {}

function mt:__index(key)
    local v = japi[key] or jass[key]
    if not v then
        return nil
    end
    self[key] = v
    return v
end

setmetatable(_G, mt)


local mt = {}
function mt:__index(i)
    if i < 0 or i > 8191 then
        error('数组索引越界:'..i)
    end
    return self._default
end

function mt:__newindex(i, v)
    if i < 0 or i > 8191 then
        error('数组索引越界:'..i)
    end
    rawset(self, i, v)
end

function _array(default)
    return setmetatable({ _default = default }, mt)
end


function ExecuteFunc(name)
    if _G[name] and type(_G[name]) == 'function' then
        pcall(_G[name])
    else
        jass.ExecuteFunc(name)
    end
end