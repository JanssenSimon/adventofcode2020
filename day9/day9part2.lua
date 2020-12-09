--get input file
io.input(io.open("input"))

--set input values as indices of table
input = {}
for line in io.lines() do table.insert(input, line) end

io.close()


invalidnum = 507622668
sum = 0
nums = {}
stop = false
for i, v in ipairs(input) do
    if not stop then
        while sum > invalidnum do
            sum = sum - table.remove(nums, 1)
        end
        if sum == invalidnum then 
            max = math.max(unpack(nums))
            min = math.min(unpack(nums))
            print(min.." + "..max.." = "..min+max) 
            stop = true 
        else
            sum = sum + v
            table.insert(nums, v)
        end
    end
end
