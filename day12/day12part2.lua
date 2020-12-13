function open(filename, lineoperation)
    io.input(io.open(filename))
    for line in io.lines() do lineoperation(line) end
    io.close()
end

input = {}
open("input", function(line)
    instruction, argument = line:match("([NSEWLRF])(.+)")
    table.insert(input, {inst=instruction, arg=tonumber(argument)})
end)


function addvectors(vec1, vec2)
    output = {}
    output.x = vec1.x + vec2.x
    output.y = vec1.y + vec2.y
    return output
end
function scalevector(vec, scalar)
    output = {}
    output.x = vec.x * scalar
    output.y = vec.y * scalar
    return output
end
currentwaypointpos = {x=10,y=1}
displacement = {x=0,y=0}
for index, command in ipairs(input) do
    if command.inst == 'F' then displacement = addvectors(displacement, scalevector(currentwaypointpos, command.arg))
    elseif command.inst == 'N' then currentwaypointpos = addvectors(currentwaypointpos, {x=0,y=command.arg})
    elseif command.inst == 'E' then currentwaypointpos = addvectors(currentwaypointpos, {x=command.arg,y=0})
    elseif command.inst == 'S' then currentwaypointpos = addvectors(currentwaypointpos, {x=0,y=-command.arg})
    elseif command.inst == 'W' then currentwaypointpos = addvectors(currentwaypointpos, {x=-command.arg,y=0})
    elseif command.inst == 'L' then command.inst = 'R' command.arg = 360 - command.arg end
    if command.inst == 'R' then
        if command.arg == 90 then temp = currentwaypointpos.x currentwaypointpos.x = currentwaypointpos.y currentwaypointpos.y = -temp
        elseif command.arg == 180 then currentwaypointpos.x = -currentwaypointpos.x currentwaypointpos.y = -currentwaypointpos.y
        elseif command.arg == 270 then temp = currentwaypointpos.x currentwaypointpos.x = -currentwaypointpos.y currentwaypointpos.y = temp end
    end
end
manhattandistance = math.abs(displacement.x) + math.abs(displacement.y)
print("The manhattan distance is "..manhattandistance)
