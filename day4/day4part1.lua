--get input file
io.input(io.open("input"))

--make a table of tables where the subtables are the passports
passports = {}
index = 1
for line in io.lines() do
    --switch to next passport
    if line == "" then index = index + 1 else
        --fill properties of passport
        if not passports[index] then passports[index] = {} end
        for property in string.gmatch(line, "%S+") do
            seperatorindex = property:find(":")
            key = property:sub(1,seperatorindex-1)
            value = property:sub(seperatorindex+1)
            passports[index][key] = value
        end
    end
end

io.close()


--find the number of "valid" passports
count = 0
for index, passport in ipairs(passports) do
    if passport["byr"] and passport["iyr"] and passport["eyr"] 
    and passport["hgt"] and passport["hcl"] and passport["ecl"] 
    and passport["pid"] then count = count + 1 end
end
print("The number of \"valid\" passports is "..count)
