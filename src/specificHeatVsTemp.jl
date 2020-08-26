include("F:\\Julia\\Project\\src\\IterateEnergyArray.jl")

function SpecificHeatVsTemp(x, plt, temperature)

    while temperature <= 5

    arrayHeatCapacity_spin = []

        for iCount = 1:MonteCarloSweeps

            EnergyArraySquared = []

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


                    x[row, col] = valueCell  # update the lattice site
                    #Every spin has an interaction energy of "-J" with each of four nearest neighbours, fig:- 8.8

                    EnergyPerSpin = -(Energy/4)
                    EnergyArray[row, col] = EnergyPerSpin  # Record the energy per spin values
                    push!(EnergyArraySquared, EnergyPerSpin*EnergyPerSpin )
                    #println(EnergyArray)
                end
            end

            mean_x_Energy = Statistics.mean(EnergyArray)   #mean of energy
            EnergySquared_mean = Statistics.mean(EnergyArraySquared) # mean of energy squared

            energyDifferenceSquared = EnergySquared_mean - (mean_x_Energy*mean_x_Energy)
            HeatCapacityPerSpin =  energyDifferenceSquared/(temperature*temperature)   # C = delE^2/kBT^2
            push!(arrayHeatCapacity_spin, HeatCapacityPerSpin)
        end


          SpecificHeatPerSpin = Statistics.mean(arrayHeatCapacity_spin)
          #println(length(arrayHeatCapacity_spin))
          SpecificHeatPerSpin = SpecificHeatPerSpin*8.5
          push!(arraySpecificHeatVsTemp, SpecificHeatPerSpin)
        temperature += 0.1
    end
end
