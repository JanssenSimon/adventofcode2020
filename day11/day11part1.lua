function open(filename, lineoperation)
    io.input(io.open(filename))
    for line in io.lines() do lineoperation(line) end
    io.close()
end
function toarray(line)
    output = {}
    for character in line:gmatch"." do table.insert(output, character) end
    return output
end

input = {}
open("input", function(line) table.insert(input, toarray(line)) end)


function getsumofsurrounding(li, i, state)
    sumofsurrounding = 0
    if state[li-1] then
        if state[li-1][i-1] and state[li-1][i-1] == "#" then 
                sumofsurrounding = sumofsurrounding + 1 end
        if state[li-1][i] == "#" then
            sumofsurrounding = sumofsurrounding + 1 end
        if state[li-1][i+1] and state[li-1][i+1] == "#" then 
                sumofsurrounding = sumofsurrounding + 1 end
    end
    if state[li][i-1] and state[li][i-1] == "#" then 
            sumofsurrounding = sumofsurrounding + 1 end
    if state[li][i+1] and state[li][i+1] == "#" then 
            sumofsurrounding = sumofsurrounding + 1 end
    if state[li+1] then
        if state[li+1][i-1] and state[li+1][i-1] == "#" then 
                sumofsurrounding = sumofsurrounding + 1 end
        if state[li+1][i] == "#" then
            sumofsurrounding = sumofsurrounding + 1 end
        if state[li+1][i+1] and state[li+1][i+1] == "#" then 
                sumofsurrounding = sumofsurrounding + 1 end
    end
    return sumofsurrounding
end
function getstateafter(state)
    nextstate = {}
    for lineindex, line in ipairs(state) do
        nextstate[lineindex] = {}
        for index, character in ipairs(line) do
            newcharacter = '.'
            if character == 'L' then
                shouldbefull = getsumofsurrounding(lineindex,index,state) == 0
                if shouldbefull then newcharacter = '#'
                else newcharacter = 'L' end
            elseif character == '#' then
                shouldbeempty = getsumofsurrounding(lineindex,index,state) >= 4
                if shouldbeempty then newcharacter = 'L'
                else newcharacter = '#' end
            end
            nextstate[lineindex][index] = newcharacter
        end
    end
    return nextstate
end
function printstate(state)
    for lineindex, line in ipairs(state) do print(table.concat(line, "")) end
end
function areequaltables(table1, table2)
    for k, v in pairs(table1) do 
        if type(v) == 'table' then 
            if not areequaltables(v, table2[k]) then return false end
        elseif table2[k] ~= v then return false end
    end
    return true
end
function countoccupiedseats(state)
    count = 0
    for lineindex, line in ipairs(state) do 
        for index, char in ipairs(line) do 
            if char == "#" then count = count + 1 end
        end
    end
    return count
end

state = input
newstate = getstateafter(input)
while not areequaltables(newstate, state) do
    state = newstate
    newstate = getstateafter(newstate)
end
print("When the state stabilizes, the number of occupied seats is "..countoccupiedseats(state))
