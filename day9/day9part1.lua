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
        if hashTable[sum-index] then addends[index] = sum-index end
    end
    return addends
end

for i, v in ipairs(input) do
if i > 25 then
    prevnumbers = {}
    --load 25 previous values of input
    for j=-25,-1 do prevnumbers[j+26] = input[i+j] end

    sumpairs = findsumpairs(v, prevnumbers)
    if next(sumpairs) == nil then print(v) os.exit() end
end
end
