--get input file
io.input(io.open("input"))

--set input values in array
instructions = {}
for line in io.lines() do table.insert(instructions, line) end

io.close()


--find the value of accumulator
--this whole way of proceding is very inefficient but I haven't the time to spend on this problem
indextoreplace = 1
wholeprogramran = false
while not wholeprogramran do
    previouslyvisitedindices = {}
    index = 1
    accumulator = 0
    while not previouslyvisitedindices[index] and index <= table.getn(instructions) do
        previouslyvisitedindices[index] = true
        instruction = instructions[index]
        operation, argument = instruction:match("(%a%a%a)%s([%+%-]%d+)")

        if indextoreplace == index then if operation == "jmp" then operation = "nop" elseif operation == "nop" then operation = "jmp" end end

        if operation == "acc" then
            accumulator = accumulator + tonumber(argument)
            index = index + 1
        elseif operation == "jmp" then
            index = index + tonumber(argument)
        elseif operation == "nop" then
            index = index + 1
        end
    end
    if index == table.getn(instructions) + 1 then wholeprogramran = true end
    indextoreplace = indextoreplace + 1
end
print("Accumulator value at end of program runtime is "..accumulator)
