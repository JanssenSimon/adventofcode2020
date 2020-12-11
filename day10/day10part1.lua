function open(filename, lineoperation)
    io.input(io.open(filename))
    for line in io.lines() do lineoperation(line) end
    io.close()
end

input = {}
open("input", function(line) table.insert(input, tonumber(line)) end)
table.sort(input)


differencesofthreecount = 1 --starts at one for device to final adapter
differencesofonecount = 1 --starts at one for wall to first adapter
for index, joltage in ipairs(input) do
    if index > 1 then
        if joltage - input[index-1] == 1 then
            differencesofonecount = differencesofonecount + 1
        elseif joltage - input[index-1] == 3 then 
            differencesofthreecount = differencesofthreecount + 1
        end
    end
end
print("When using every adapter, the product of the number of differences of three and the number of differences of one is "..differencesofthreecount * differencesofonecount)
