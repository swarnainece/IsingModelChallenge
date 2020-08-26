
function Equlibration_Body(x, temperature, path)

        for iCount = 1:MonteCarloSweeps

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

            mean_x = Statistics.mean(x)           # average spin alignment per sweep
            push!(arrayMeanMagnetizationVsTime, mean_x)

            """
            if (iCount == 10000) || (iCount == 100000) || (iCount == 1000000)

                plt.imshow(x)
                plt.xlabel("Monte Carlo Step = " * string(iCount))
                Directory = path * "pic" * string(iCount) * ".png"
                #Directory = Directory * "pic" * string(iCount) * ".png"
                #println(Directory)
                plt.savefig(Directory)
            end """
        end
end
