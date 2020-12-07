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

--Returns the tree count of a particular slope
function countencounteredtrees(deltax, deltay, batch, linelength, linecount)
    --find the number of trees that will be encountered
    local pos = {x = 1, y = 1}
    local treecount = 0
    while pos.y <= linecount do
        if batch[pos.y][pos.x] == '#' then treecount = treecount + 1 end
        pos.y = pos.y + deltay
        pos.x = (pos.x + deltax - 1) % linelength + 1
    end
    return treecount
end


firstslope = countencounteredtrees(1,1,batch,filelinelength,filelinecount)
secondslope = countencounteredtrees(3,1,batch,filelinelength,filelinecount)
thirdslope = countencounteredtrees(5,1,batch,filelinelength,filelinecount)
fourthslope = countencounteredtrees(7,1,batch,filelinelength,filelinecount)
fifthslope = countencounteredtrees(1,2,batch,filelinelength,filelinecount)
print("The product of the trees encountered on the slopes is: "..tostring(
    firstslope*secondslope*thirdslope*fourthslope*fifthslope))
