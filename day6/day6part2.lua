--get input file
io.input(io.open("input"))

--set input in an array
cdforms = {}
index = 1
for line in io.lines() do
    if not cdforms[index] then cdforms[index] = {} cdforms[index].grpnum = 1 
    else cdforms[index].grpnum = cdforms[index].grpnum + 1 end
    for q in line:gmatch"." do if not cdforms[index][q] then 
    cdforms[index][q] = 1 else cdforms[index][q] = cdforms[index][q] + 1 end end
    if line == "" then cdforms[index].grpnum = cdforms[index].grpnum - 1
    index = index + 1 end
end

io.close()


--count number of questions
sum = 0
for index, cdform in ipairs(cdforms) do
    for question, num in pairs(cdform) do
        if question ~= 'grpnum' and num == cdform.grpnum then sum = sum + 1 end
    end
end
print("Sum of group yes questions is "..sum)
