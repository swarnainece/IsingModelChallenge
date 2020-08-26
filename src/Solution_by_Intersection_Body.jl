
function Solution_by_Intersection(value)

    initialTemp = 0
    FinalTemp   = 0

    if value == "T<Tc"

        initialTemp = 0
        FinalTemp   = 4
        IntersectionFunction(initialTemp, FinalTemp)

    elseif value == "T>Tc"

        initialTemp = 4
        FinalTemp   = 8
        IntersectionFunction(initialTemp, FinalTemp)

    else

        println("Error: Enter correct value of either ::-->  \"T>Tc\" or \"T<Tc\"   ")

    end
end



function IntersectionFunction(initialTemp, FinalTemp)

    for iCount = 1:length(s_values)

        temperature = initialTemp  #Set the Initial Temp
        arrayOutput_tanh = []

        while temperature <= FinalTemp

            Output_tanh = tanh(z*s_values[iCount]/temperature)  # z = 4 represents nearest neighbour
            push!(arrayOutput_tanh, Output_tanh)
            temperature += 0.1
        end

        mean_tanh = Statistics.mean(arrayOutput_tanh)  #<s> = tanh()
        push!(array_tanh, mean_tanh )
    end
end



function Finding_ThermalAVG_S()

    for iCount = 1:(length(arraySum))

        push!(arrayThermalAvg,  arraySum[iCount]/(rows*columns) )
    end
end



function tanh_of_S()

    for iCount = 1:(length(arrayThermalAvg))

        output = tanh((z*arrayThermalAvg[iCount])/arrayTemp[iCount])
        push!(array_tanh, output)
    end
end
