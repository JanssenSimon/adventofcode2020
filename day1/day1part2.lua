--iterator which returns string's characters from right to left
function rev_str_iter(input)
    local i = input:len() + 1
    return function ()
        i = i - 1
        if i > 0 then return input:sub(i,i) end
    end
end


--get input file
io.input(io.open("input"))

--set input values as indices of table
pseudoTree = {}
for line in io.lines() do 
    previousparent = pseudoTree
    for char in rev_str_iter(line) do
        if not previousparent[tonumber(char)] then 
            previousparent[tonumber(char)] = {} end
        previousparent = previousparent[tonumber(char)]
    end
end

io.close()


--find the first triple that sums to 2020
--find addends
