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
    function checkright(y,x)
        if state[y][x+1] then
            if state[y][x+1] == "#" then return 1
            elseif state[y][x+1] == "L" then return 0
            elseif state[y][x+1] == "." then return checkright(y, x+1) end
        end
        return 0
    end
    function checkupright(y,x)
        if state[y-1] and state[y-1][x+1] then
            if state[y-1][x+1] == "#" then return 1
            elseif state[y-1][x+1] == "L" then return 0
            elseif state[y-1][x+1] == "." then return checkupright(y-1, x+1) end
        end
        return 0
    end
    function checkup(y,x)
        if state[y-1] and state[y-1][x] then
            if state[y-1][x] == "#" then return 1
            elseif state[y-1][x] == "L" then return 0
            elseif state[y-1][x] == "." then return checkup(y-1, x) end
        end
        return 0
    end
    function checkupleft(y,x)
        if state[y-1] and state[y-1][x-1] then
            if state[y-1][x-1] == "#" then return 1
            elseif state[y-1][x-1] == "L" then return 0
            elseif state[y-1][x-1] == "." then return checkupleft(y-1, x-1) end
        end
        return 0
    end
    function checkleft(y,x)
        if state[y][x-1] then
            if state[y][x-1] == "#" then return 1
            elseif state[y][x-1] == "L" then return 0
            elseif state[y][x-1] == "." then return checkleft(y, x-1) end
        end
        return 0
    end
    function checkdownleft(y,x)
        if state[y+1] and state[y+1][x-1] then
            if state[y+1][x-1] == "#" then return 1
            elseif state[y+1][x-1] == "L" then return 0
            elseif state[y+1][x-1] == "." then return checkdownleft(y+1, x-1) end
        end
        return 0
    end
    function checkdown(y,x)
        if state[y+1] and state[y+1][x] then
            if state[y+1][x] == "#" then return 1
            elseif state[y+1][x] == "L" then return 0
            elseif state[y+1][x] == "." then return checkdown(y+1, x) end
        end
        return 0
    end
    function checkdownright(y,x)
        if state[y+1] and state[y+1][x+1] then
            if state[y+1][x+1] == "#" then return 1
            elseif state[y+1][x+1] == "L" then return 0
            elseif state[y+1][x+1] == "." then return checkdownright(y+1, x+1) end
        end
        return 0
    end
    sumofsurrounding = checkright(li,i) + checkupright(li,i) + checkup(li,i) + checkupleft(li,i) + checkleft(li,i) + checkdownleft(li,i) + checkdown(li,i) + checkdownright(li,i)
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
                shouldbeempty = getsumofsurrounding(lineindex,index,state) >= 5
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
