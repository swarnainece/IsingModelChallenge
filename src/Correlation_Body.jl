function Correlation_Body(x, temperature)

    if rows == columns

        max_Distance = (rows/2)
        max_Distance = trunc(Int, max_Distance)

    else
        println("Rows should be equal to Columns")
    end

    for iCount = 1:MonteCarloSweeps

        # Call  calculate_Correlation function
        calculate_Correlation(x, max_Distance)

        x = newArray_MCsweep(x, temperature) #Change Array Based upon MC sweeps
    end

    return max_Distance
end


function calculate_Correlation(x, max_Distance)

    arrayDist_correlation = []

    for dist in 1:max_Distance

        correlationFunc1 = 0

        for row in 1:rows
            for col in 1:columns

                listOfNeighbours = handle_RowsCloumns(row, col, dist)

                firstItem  = x[listOfNeighbours[1][1] , listOfNeighbours[1][2]]
                SecondItem = x[listOfNeighbours[2][1] , listOfNeighbours[2][2]]
                ThirdItem  = x[listOfNeighbours[3][1] , listOfNeighbours[3][2]]
                FourthItem = x[listOfNeighbours[4][1] , listOfNeighbours[4][2]]

                correlationFunc = x[row, col]*(firstItem + SecondItem + ThirdItem + FourthItem)
                correlationFunc1 = correlationFunc1 + correlationFunc

            end
        end

        avgCorrelationFunc = correlationFunc1/(rows*columns)
        push!(arrayDist_correlation , avgCorrelationFunc)
    end

    push!(arrayCorrelation_MC, arrayDist_correlation)
end



function handle_RowsCloumns(row, col, dist)

    left = []
    right = []
    top = []
    bottom = []

    neighbours = []

    # Handle row boundary condition <0
    if (row-dist) <= 0

        val = (row - dist)
        val = val*(-1)
        row_1 = rows - val
    else

        row_1 = row-dist
    end

    # Handle col boundary condition <0
    if (col - dist) <= 0

        val = (col - dist)
        val = val*(-1)
        col_1 = columns - val

    else

        col_1 = col - dist
    end

    # Handle row boundary condition >0
    if (row + dist) > columns

        val = (row + dist)
        row_2 = val - rows

    else
        row_2 = row + dist
    end

    # Handle col boundary condition >0
    if (col + dist) > columns

        val = (col + dist)
        col_2 = val - columns

    else
        col_2 = col + dist
    end

    push!(left, row, col_1)
    push!(right, row, col_2)
    push!(top, row_1, col)
    push!(bottom, row_2, col)
    push!(neighbours, left, right, top, bottom)

end




function newArray_MCsweep(x, temperature)

    for row in 1:rows
        for col in 1:columns

            Energy = 0
            valueCell = x[row, col] # storing value of x[row, col]

            #println(row, "," , col)
            if (row-1) == 0
                if (col-1) == 0
                    #1,1
                    Energy = (x[row, columns]*x[row, col] + x[rows, col]*x[row, col] +  x[row, col+1]*x[row, col] + x[row+1, col]*x[row, col] )
                    #Energy = Energy * (-1)
                elseif (col+1) == columns + 1

                    # 1,5
                    Energy = (x[row, (col-1) ]*x[row, col] + x[rows, col]*x[row, col] + x[row, 1]*x[row, col] + x[row+1, col]*x[row, col] )
                    #Energy = Energy * (-1)
                else

                    # 1,2  ;   1,3   ;   1,4
                    Energy = (x[row, columns]*x[row, col] + x[rows, col]*x[row, col] + x[row, col+1]*x[row, col] + x[row+1, col]*x[row, col] )
                    #Energy = Energy * (-1)
                end

            elseif (col - 1)  == 0    &&    (row-1) != 0

                if (row+1) == rows + 1

                    # 5,1
                    Energy = (x[row, columns]*x[row, col] + x[row-1, col]*x[row, col]  + x[row, col+1]*x[row, col] + x[1, col]*x[row, col] )
                    #Energy = Energy * (-1)
                else

                    # 2,1  ;   3,1    ;    4,1
                    Energy = (x[row, columns]*x[row, col] + x[row-1, col]*x[row, col]  + x[row, col+1]*x[row, col] + x[row+1, col]*x[row, col] )
                    #Energy = Energy * (-1)

                end

            elseif (row + 1)   == rows + 1  &&    (col - 1) != 0

                if (col + 1) == columns + 1
                    # 5,5
                    Energy = (x[row, col-1]*x[row, col] + x[row-1, col]*x[row, col]  + x[row, 1]*x[row, col] + x[1, col]*x[row, col] )
                    #Energy = Energy * (-1)
                else
                    # 5,2  ; 5,3  ;   5,4
                    #println(row, "," , col)
                    Energy = (x[row, col-1]*x[row, col] + x[row-1, col]*x[row, col]  + x[row, col+1]*x[row, col] + x[1, col]*x[row, col] )
                    #Energy = Energy * (-1)
                end

            elseif (col+1)   == columns + 1    &&   (row - 1) != 0   &&   (row + 1) != rows + 1

                # 2,5 ,   3,5 , 4,5
                #println(row, "," , col)
                Energy = (x[row, col-1]*x[row, col] + x[row-1, col]*x[row, col]  + x[row, 1]*x[row, col] + x[row+1, col]*x[row, col] )
                #Energy = Energy * (-1)

            else

                #println(row, "," , col)
                Energy = (x[row, col-1]*x[row, col] + x[row-1, col]*x[row, col]  + x[row, col+1]*x[row, col] + x[row+1, col]*x[row, col] )
                #Energy = Energy * (-1)
            end

            Energy = 2*(Energy) # Scale Energy up by a factor of 2

            if Energy <= 0
                valueCell = valueCell*(-1)  # flip the spin
            else
                r = rand()
                if r <= exp(-Energy/temperature)
                    valueCell = valueCell*(-1)  # flip the spin
                end
            end

            x[row, col] = valueCell  # update the lattice sitel
            EnergyArray[row, col] = Energy  # Record the energy values
        end
    end

    return x
end



function avgOfMonteCarloSweeps(max_Distance)


    for iCountDist in 1:max_Distance

        val_Total = 0

        for iCountElements in 1:length(arrayCorrelation_MC)

            val = arrayCorrelation_MC[iCountElements][iCountDist]
            val_Total = val_Total + val
            #println(arrayCorrelation_MC[iCountElements][iCountDist])
        end

        val_Total = val_Total/length(arrayCorrelation_MC)
        push!(avgMCSweep, val_Total)
    end
end


function normalization()

    normalizedArray = []

    for iCount in avgMCSweep

        val = iCount/4
        push!(normalizedArray, val)
    end

    return normalizedArray
end
