function open(filename, lineoperation)
    io.input(io.open(filename))
    for line in io.lines() do lineoperation(line) end
    io.close()
end

absolutechanges = {N=0,S=0,E=0,W=0}
relativechanges = {}
open("input", function(line)
    instruction, argument = line:match("([NSEWLRF])(.+)")
    if instruction == "N" or instruction == "S" or instruction == "E" or instruction == "W" then
        absolutechanges[instruction] = absolutechanges[instruction] + tonumber(argument)
    else
        table.insert(relativechanges, {instruction, argument}) 
    end
end)
table.sort(absolutechanges)


function getdirection(num)
    if num == 0 then return "N" end
    if num == 1 then return "E" end
    if num == 2 then return "S" end
    if num == 3 then return "W" end
end
function getnum(direction)
    if direction == "N" then return 0 end
    if direction == "E" then return 1 end
    if direction == "S" then return 2 end
    if direction == "W" then return 3 end
end
direction = "E"
for index, command in ipairs(relativechanges) do
    if command[1] == "F" then absolutechanges[direction] = absolutechanges[direction] + tonumber(command[2]) end
    if command[1] == "L" then command[1] = "R" command[2] = 360 - tonumber(command[2]) end
    if command[1] == "R" then direction = getdirection((getnum(direction) + tonumber(command[2])/90) % 4) end
end
--for dir, mag in pairs(absolutechanges) do print(dir.." "..mag) end

manhattandistance = (absolutechanges["S"] - absolutechanges["N"]) + (absolutechanges["W"] - absolutechanges["E"])
print("The manhattan distance is "..manhattandistance)
