function open(filename, lineoperation)
    io.input(io.open(filename))
    for line in io.lines() do lineoperation(line) end
    io.close()
end

input = {}
open("input", function(line) table.insert(input, tonumber(line)) end)
table.sort(input)


function isvalidjoltagedelta(delta)
    return delta >= 1 and delta <= 3 end

permutationscount = {}
for index, joltage in ipairs(input) do
    permutationstohere = 0

    --hack because lua ipairs starts at 1
    if joltage <= 3 then permutationstohere = 1 end

    if input[index-1] and isvalidjoltagedelta(joltage - input[index-1]) then
        permutationstohere = permutationstohere + permutationscount[index-1]
    end
    if input[index-2] and isvalidjoltagedelta(joltage - input[index-2]) then
        permutationstohere = permutationstohere + permutationscount[index-2]
    end
    if input[index-3] and isvalidjoltagedelta(joltage - input[index-3]) then
        permutationstohere = permutationstohere + permutationscount[index-3]
    end
    permutationscount[index] = permutationstohere
end
print("The number of ways to permute the adapters is "..permutationscount[#permutationscount])
