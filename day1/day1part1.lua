--get input file
io.input(io.open("input"))

--set input values as indices of table
hashTable = {}
for line in io.lines() do hashTable[tonumber(line)] = true end

io.close()


--find the first pair that sums to 2020
for index, value in pairs(hashTable) do
    if hashTable[2020-index] then print(index.." + "..2020-index.." = 2020")
        --print product of pair
        print(index.." * "..2020-index.." = "..index*(2020-index))
        os.exit()
    end
end
