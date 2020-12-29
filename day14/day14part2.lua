function open(filename, lineoperation)
    io.input(io.open(filename))
    for line in io.lines() do lineoperation(line) end
    io.close()
end

function numto36bit(num)
    local t = {}
    while num > 0 do
        rest = num % 2
        table.insert(t,1,rest)
        num = math.floor((num-rest)/2)
    end
    while #t < 36 do table.insert(t,1,0) end
    return table.concat(t)
end
function bintonum(binary, onechar)
    onechar = onechar or '1'
    if not binary:match(onechar) then return 0 end
    if binary:sub(-1) == onechar then
        return (bintonum(binary:sub(1,-2), onechar)<<1) + 1
    else
        return bintonum(binary:sub(1,-2), onechar)<<1
    end
end

function maskedaddresses(address, mask)
    address = numto36bit(tonumber(address))
    local i, n = -1, 1<<select(2, mask:gsub("X",""))
    --for all X and 1 in mask, replace with that in address
    for k = 1, #mask do
        if mask:sub(k,k) == "X" then
            address = address:sub(1,k-1).."X"..address:sub(k+1)
        elseif mask:sub(k,k) == "1" then
            address = address:sub(1,k-1).."1"..address:sub(k+1)
        end
    end
    return function()
        i = i + 1
        if i < n then
            local bits = numto36bit(i)
            local j = 0
            return address:gsub("X", function(c)
                j = j - 1
                return bits:sub(j,j)
            end)
        end
    end
end

RAM = {}
mask = ""
function decodeV2(register)
    instruction, argument = register:match("(.+)%s=%s(.+)")
    if instruction == "mask" then
        mask = argument
    elseif instruction:match("mem") then
        address = instruction:match("mem%[(%d+)]")
        for addr in maskedaddresses(address, mask) do
            RAM[bintonum(addr)] = tonumber(argument)
        end
    end
end

open("input", decodeV2)

sum = 0
for addr, val in pairs(RAM) do sum = sum + val end
print("Sum of values in memory is :"..sum)
