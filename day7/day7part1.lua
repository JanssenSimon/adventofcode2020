--get input file
io.input(io.open("input"))

--set input in an array
cdforms = {}
index = 1
for line in io.lines() do
    if not cdforms[index] then cdforms[index] = {} cdforms[index].sum = 0 end
    for q in line:gmatch"." do 
        if not cdforms[index][q] then cdforms[index][q] = true
        cdforms[index].sum = cdforms[index].sum + 1 end end
    if line == "" then index = index + 1 end
end

io.close()


--count number of questions
sum = 0
for index, cdform in ipairs(cdforms) do
    sum = sum + cdform.sum
end
print("Sum of group yes questions is "..sum)
