


function createArray(arrayType)

    if arrayType == "positive"
        # Creating an empty 2D matrix with +1s
        x = rand([1, 1], rows, columns)
        #println(x)
    elseif arrayType == "negative"
        # Creating an empty 2D matrix with +1s
        x = rand([-1, -1], rows, columns)
        #println(x)
    else
        # Creating an empty 2D matrix with +1s
        x = rand([1, -1], rows, columns)
        #println(x)
    end
    return x
end
