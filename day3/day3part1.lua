--Loads the nth batch of size batchsize in filename. 2d array of chars
function loadbatch(filename, batchsize, n)
    --open input file
    io.input(io.open(filename))

    --load batch
    local batch = {}
    local index = 1
    local linelength
    for line in io.lines() do 
        if linelength == nil then linelength = string.len(line) end
        if index >= batchsize * (n - 1) + 1 and index <= batchsize * n + 1 then
            batch[index] = {}
            line:gsub(".", function(char) table.insert(batch[index], char) end)
        end
        index = index + 1
    end

    io.close()
    return batch, linelength, index - 1
end
batch, filelinelength, filelinecount = loadbatch("input", 323, 1)


--find the number of trees that would be encountered
position = {x = 1, y = 1}
treecount = 0
while position.y <= filelinecount do
    if batch[position.y][position.x] == '#' then treecount = treecount + 1 end
    position.y = position.y + 1
    position.x = (position.x + 3 - 1) % filelinelength + 1
end
print("The number of trees encountered is: "..tostring(treecount))
