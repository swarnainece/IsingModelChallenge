

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


function Low_High_Temperature_Segregate()

    CriticalTemp_Index = 0

    for iCount = 1:(length(arrayTemp))

        if arrayTemp[iCount] == arrayCriticalTemp[1]

            CriticalTemp_Index = iCount
            break
        end
    end

    # Push <s>  Low temp and High Temp
    for iCount1 = 1:(length(arrayThermalAvg))

        if iCount1 <= CriticalTemp_Index

            push!(arrayLowTemp_S, arrayThermalAvg[iCount1])
        else

            push!(arrayHighTemp_S, arrayThermalAvg[iCount1])
        end

    end

    # Push tanh corresponding to Low & High Temp
    for iCount1 = 1:(length(array_tanh))

        if iCount1 <= CriticalTemp_Index

            push!(arrayLowTemp_tanh, array_tanh[iCount1])
        else

            push!(arrayHighTemp_tanh, array_tanh[iCount1])
        end
    end

end
