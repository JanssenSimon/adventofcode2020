function open(filename, lineoperation)
    io.input(io.open(filename))
    for line in io.lines() do lineoperation(line) end
    io.close()
end

fields = {}
ticket = {}
othertickets = {}
readstate = 0
index = 1
open("input", function(line)
    if line == "" then readstate = readstate + 1 end
    if readstate == 0 then      --ticket fields
        fieldname, min1, max1, min2, max2 = line:match("(.+):%s(%d+)%-(%d+)%sor%s(%d+)%-(%d+)")
        fields[fieldname] = {tonumber(min1), tonumber(max1), tonumber(min2), tonumber(max2)}
    elseif readstate == 1 then  --personal ticket
        if line ~= "your ticket:" then
            for field in line:gmatch("%d+") do
                table.insert(ticket, tonumber(field))
            end
        end
    elseif readstate == 2 then  --proximity tickets
        if line ~= "nearby tickets:" then
            othertickets[index] = {}
            for field in line:gmatch("%d+") do
                table.insert(othertickets[index], tonumber(field))
            end
            index = index + 1
        end
    end
end)


sanitizedothertickets = {}
for index, ticket in ipairs(othertickets) do
    invalidticket = false
    for field, value in ipairs(ticket) do
        wrongfields = 0
        for fieldname, bounds in pairs(fields) do
            if not ((value >= bounds[1] and value <= bounds[2]) or (value >= bounds[3] and value <= bounds[4])) then
                wrongfields = wrongfields + 1
            end
        end
        if wrongfields == 20 then
            invalidticket = true
        end
    end
    if not invalidticket then table.insert(sanitizedothertickets, ticket) end
end

for fieldname, bounds in pairs(fields) do
    print(fieldname)
    possibleindexes = {}
    for i=1,20 do
        possibleindexes[i] = true
    end
    for index, ticket in ipairs(sanitizedothertickets) do
        for fieldindex, value in ipairs(ticket)do
            if not ((value >= bounds[1] and value <= bounds[2]) or (value >= bounds[3] and value <= bounds[4])) then
                if possibleindexes[fieldindex] then
                    possibleindexes[fieldindex] = nil
                    print("Index "..fieldindex.." doesn't work because of ticket "..index)
                end
            end
        end
    end
    for i=1,20 do
        if possibleindexes[i] then print(i) end
    end
end

print(157*151*83*149*79*137)
