

function IterateEnergyArray(x, EnergyArray)

    #print("\n")
    #println("Inside IterateEnergyArray:::-->")
    #print(x)
    for row in 1:rows
        for col in 1:columns

            Value_of_Energy = EnergyArray[row, col]

            if Value_of_Energy <= 0

                # flip the spin
                flagValue = x[row, col]
                if flagValue == 1
                    x[row, col] = -1
                else
                    x[row, col] = 1
                end

            else

                if Value_of_Energy > 0
                    r = rand()

                    if r <= exp(-Value_of_Energy/Temp)
                        # flip the spin
                        flagValue = x[row, col]
                        if flagValue == 1
                            x[row, col] = -1
                        else
                            x[row, col] = 1
                        end
                    else
                        #println("Leave it undisturbed")
                    end
                end
            end
        end
    end

    return x
end
