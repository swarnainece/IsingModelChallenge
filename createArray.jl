


function createArray()
    # Creating an empty 2D matrix with Zeros filled in
    x = fill(0, rows, columns)
    # Putting +1 and -1 in the matrix
    for row in 1:rows
        for col in 1:columns
            r= rand(0:1)
            r < 1 ? x[row, col] = -1 : x[row, col] = 1
            println(row, "," , col)
            println("::")
            println(x[row, col])
        end
    end

    #println(x)
    return x
end
