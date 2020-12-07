--get input file
io.input(io.open("input"))

--set input in an array
boardingpasses = {}
index = 1
for line in io.lines() do boardingpasses[index] = line index = index + 1 end

io.close()


function convertfrombinary(binary, onechar)
    bin = string.reverse(binary)
    local sum = 0
    for i = 1, bin:len() do
        num = string.sub(bin, i,i) == onechar and 1 or 0
        sum = sum + num * math.pow(2, i-1)
    end
    return sum
end
seatids = {}
--find missing boarding pass through process of elimination
for index, boardingpass in ipairs(boardingpasses) do
    row = convertfrombinary(boardingpass:match("[BF]+"), "B")
    column = convertfrombinary(boardingpass:match("[LR]+"), "R")

    seatid = row * 8 + column
    seatids[seatid] = true
end
previndex = nil
for index, seatid in pairs(seatids) do
    if previndex and previndex < (index - 1) then 
        print("Missing seatid is "..index-1)
        previndex = index
    else previndex = index end
end
