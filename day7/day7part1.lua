--get input file
io.input(io.open("input"))

--set input in an array
rules = {}
index = 1
for line in io.lines() do
    rules[index] = {}
    rules[index].container, contents = line:match("(.+)%sbags%scontain%s(.+)%.")
    index = index + 1
end

io.close()


