--get input file
io.input(io.open("input"))

--set input in an array
bagsin = {}
for line in io.lines() do
    container, contents = line:match("(.+)%sbags%scontain%s(.+)%.")
    bagsin[container] = {}
    for number, bagcolour in contents:gmatch("(%d)%s(%a+%s%a+)%sbag") do
        table.insert(bagsin[container], {c=bagcolour, n=number})
    end
end

io.close()


--count total amount of bags inside of shiny gold one
function countbagsin(bagtype)
    sum = 0
    for i, nestedbag in ipairs(bagsin[bagtype]) do
        sum = sum + tonumber(nestedbag.n) + tonumber(nestedbag.n) * countbagsin(nestedbag.c)
    end
    return sum
end
print("The total amount of bags in the gold one is: "..countbagsin("shiny gold"))
