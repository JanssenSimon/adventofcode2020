history = {}

--puzzle input, starting numbers
table.insert(history, 10)
table.insert(history, 16)
table.insert(history, 6)
table.insert(history, 0)
table.insert(history, 1)
table.insert(history, 17)


while #history ~= 30000000 do
    lastelem = history[#history]
    notunique = false
    lastindex = 1
    for i, elem in ipairs(history) do
        if elem == lastelem and i ~= #history then
            --print("I've seen "..elem.." before at "..i)
            notunique = true
            lastindex = i
        end
    end
    if notunique then table.insert(history, #history-lastindex)
    else table.insert(history, 0) end
    print(#history)
end

--for i, elem in ipairs(history) do
--    print(i.." "..elem)
--end
print(history[#history])
