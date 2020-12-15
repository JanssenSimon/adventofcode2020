function open(filename, lineoperation)
    io.input(io.open(filename))
    for line in io.lines() do lineoperation(line) end
    io.close()
end

input = {}
open("input", function(line) table.insert(input, line) end)


function numto36bit(num)
    local t={}
    while num > 0 do
        rest=num%2
        table.insert(t,1,rest)
        num=(num-rest)/2
    end
    while #t < 36 do table.insert(t,1,0) end
    return table.concat(t)
end
function convertfrombinary(binary, onechar)
    onechar = onechar or '1'
    bin = string.reverse(binary)
    local sum = 0
    for i = 1, bin:len() do
        num = string.sub(bin, i,i) == onechar and 1 or 0
        sum = sum + num * math.pow(2, i-1)
    end
    return sum
end

memory = {}
mask = "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX"
for index, line in ipairs(input) do
    command, argument = line:match("(.+)%s=%s(.+)")
    if command == "mask" then
        mask = argument
    else
        memaddress = tonumber(command:match("mem%[(%d+)]"))
        argument = numto36bit(tonumber(argument))
        --apply mask
        i = 0
        for c in mask:gmatch"." do
            i = i + 1
            if c ~= "X" then argument = argument:sub(1,i-1)..c..argument:sub(i+1) end
        end
        --save in memory
        memory[memaddress] = argument
    end
end

sum = 0
for index, number in pairs(memory) do
    sum = sum + convertfrombinary(number)
end
print("The sum of the numbers in memory is "..sum)
