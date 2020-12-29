history = {}

--puzzle input, starting numbers
history[10] = 1
history[16] = 2
history[6] = 3
history[0] = 4
history[1] = 5
history[17] = 6


turn = 7
unique = true
difference = 0
while turn <= 30000000 do
    elem = difference
    difference = history[elem] and (turn - history[elem]) or 0
    history[elem] = turn
    turn = turn + 1
    print(elem)
end
