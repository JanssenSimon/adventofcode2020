io.input(io.open('input'))
currenttime = tonumber(io.read())
busids = {}
for id in string.gmatch(io.read(), '%d+') do table.insert(busids, tonumber(id)) end
io.close()


nobusfound = true
waittime = 0
firstbus = 0
while nobusfound do
    for _, id in ipairs(busids) do
        if (currenttime + waittime) % id == 0 then nobusfound = false firstbus = id end
    end
    if nobusfound then waittime = waittime + 1 end
end

print("The product of the bus id and the wait time is "..waittime * firstbus)
