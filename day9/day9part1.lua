--get input file
io.input(io.open("input"))

--set input values as indices of table
input = {}
for line in io.lines() do table.insert(input, line) end

io.close()


function findsumpairs(sum, numbers)
    --set the numbers in a hashTable
    hashTable = {}
    for index, value in ipairs(numbers) do
        hashTable[tonumber(value)] = true
    end

    addends = {}
    --find pairs in hashtable that sum to target
    for index, value in pairs(hashTable) do
        if hashTable[sum-index] then print(index.." + "..sum-index.." = sum")
            addends[index] = sum-index
        end
    end
    return addends
end

addends = findsumpairs(5, {'2', '3', '6', '1', '4'})
for i, v in pairs(addends) do
    print(i.." and "..v)
end
