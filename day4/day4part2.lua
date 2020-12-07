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
valideyecolors = {amb=1, blu=1, brn=1, gry=1, grn=1, hzl=1, oth=1}
for index, passport in ipairs(passports) do
    if passport["byr"] and passport["byr"]:len() == 4 and tonumber(passport["byr"]) <= 2002 and tonumber(passport["byr"]) >= 1920
    and passport["iyr"] and passport["iyr"]:len() == 4 and tonumber(passport["iyr"]) <= 2020 and tonumber(passport["iyr"]) >= 2010
    and passport["eyr"] and passport["eyr"]:len() == 4 and tonumber(passport["eyr"]) <= 2030 and tonumber(passport["eyr"]) >= 2020
    and passport["hgt"] and tonumber(passport["hgt"]:match("%d+")) 
        and ((passport["hgt"]:find("%d+cm") and tonumber(passport["hgt"]:match("%d+")) >= 150 and tonumber(passport["hgt"]:match("%d+")) <= 193)
        or (passport["hgt"]:find("%d+in") and tonumber(passport["hgt"]:match("%d+")) >= 59 and tonumber(passport["hgt"]:match("%d+")) <= 76))
    and passport["hcl"] and passport["hcl"]:match("#%x%x%x%x%x%x") == passport["hcl"]
    and passport["ecl"] and valideyecolors[passport["ecl"]]
    and passport["pid"] and passport["pid"]:match("%d%d%d%d%d%d%d%d%d") == passport["pid"]
    then
        count = count + 1
    end
end
print("The number of \"valid\" passports is "..count)
