io.input(io.open('input'))
currenttime = tonumber(io.read())
busids = {}
for id in string.gmatch(io.read(), '[%dx]+') do table.insert(busids, id) end
io.close()


--for index, id in pairs(busids) do print(index.." "..id) end
product = 1
cleanbusids = {}
for index, id in pairs(busids) do
    if not (id == 'x') then cleanbusids[index] = tonumber(id) product = product * tonumber(id) end
end
time = product - 23
timenotfound = true
while timenotfound do
    print(time)
    timenotfound = false
    for index, id in pairs(cleanbusids) do
        if not ((time+(index-1))%id == 0) then timenotfound = true end
    end
    if timenotfound then time = time - 479 end
end

print("The timestamp for the occurence is "..time)
