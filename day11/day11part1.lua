function open(filename, lineoperation)
    io.input(io.open(filename))
    for line in io.lines() do lineoperation(line) end
    io.close()
end
function toarray(line)
    output = {}
    for character in str:gmatch"." do table.insert(output, character) end
end

input = {}
open("input", function(line) table.insert(input, toarray(line)) end)
table.sort(input)


function getstateafter(state)
    nextstate = {}
    for lineindex, line in state do
        
    end
end
