--get input file
io.input(io.open("input"))

--set input in an array
contains = {}
for line in io.lines() do
    container, contents = line:match("(.+)%sbags%scontain%s(.+)%.")
    for bagtype in contents:gmatch("%d%s(%a+%s%a+)%sbag") do
        if not contains[bagtype] then contains[bagtype] = {} end
        table.insert(contains[bagtype], container)
    end
end

io.close()


count = 0
counted = {}
function countcontainers(bagtype)
    if contains[bagtype] then
        for i, container in ipairs(contains[bagtype]) do
            if not counted[container] then
                counted[container] = true
                count = count + 1
                countcontainers(container)
            end
        end
    end
end
countcontainers("shiny gold")
print("The number of types of bags which can ultimately contain a gold one is: "..count)
