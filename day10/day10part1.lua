function open(filename, lineoperation)
    io.input(io.open(filename))
    for line in io.lines() do lineoperation(line) end
    io.close()
end

input = {}
open("input", function(line) table.insert(input, tonumber(line)) end)
table.sort(input)


--do the code
for k, v in ipairs(input) do
    print(k.." "..v)
end
