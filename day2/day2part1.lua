--get input file
io.input(io.open("input"))

--set input values in table
inputtable = {}
for line in io.lines() do table.insert(inputtable, line) end

io.close()

--function for checking if a password is valid
function verifypassword(line)
    --extract important values: lowerbound, upperbound, character, password
    local values = {}
    for val in string.gmatch(line, '[^%-%s:]+') do table.insert(values, val) end

    --count and compare
    local count = select(2, string.gsub(values[4], values[3], ""))
    if count >= tonumber(values[1]) and count <= tonumber(values[2]) then 
        return 1 end
    return 0
end

--count number of valid passwords
count = 0
for index, value in ipairs(inputtable) do
    count = count + verifypassword(value)
end
print("Number of valid passwords: "..tostring(count))
