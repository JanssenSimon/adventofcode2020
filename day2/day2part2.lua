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

    --check if characters at indices match the one given
    firstcharcorreponds =
    string.sub(values[4], tonumber(values[1]), tonumber(values[1])) == values[3]
    secondcharcorreponds =
    string.sub(values[4], tonumber(values[2]), tonumber(values[2])) == values[3]

    --compare
    if (firstcharcorreponds or secondcharcorreponds) 
    and not (firstcharcorreponds and secondcharcorreponds) then 
        return 1 end
    return 0
end

--count number of valid passwords
count = 0
for index, value in ipairs(inputtable) do
    count = count + verifypassword(value)
end
print("Number of valid passwords: "..tostring(count))
