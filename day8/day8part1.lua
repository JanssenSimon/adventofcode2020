--get input file
io.input(io.open("input"))

--set input values in array
instructions = {}
for line in io.lines() do table.insert(instructions, line) end

io.close()


--find the value of accumulator
previouslyvisitedindices = {}
index = 1
accumulator = 0
while not previouslyvisitedindices[index] do
    previouslyvisitedindices[index] = true
    instruction = instructions[index]
    operation, argument = instruction:match("(%a%a%a)%s([%+%-]%d+)")

    if operation == "acc" then
        accumulator = accumulator + tonumber(argument)
        index = index + 1
    elseif operation == "jmp" then
        index = index + tonumber(argument)
    elseif operation == "nop" then
        index = index + 1
    end
end
print("Accumulator value at end of program runtime is "..accumulator)
