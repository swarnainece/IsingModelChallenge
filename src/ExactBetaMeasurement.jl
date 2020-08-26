#include("F:\\Julia\\Project\\script\\beta.jl")
global increment = 0.09   # we give an increment to optimize Tc
Temp = 5.05

global arrayTrialCriticalTemp = []
global arrayCriticalTempTrial = []

function MagnetizationVsTemp(x, plt, temperature, funcToCall)

    criticalTemp = 0
    arrayBetaReturn = []
    while temperature <= Temp
        #println(temperature)
        arrayMeanMagnetization1 = []

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
            #mean_x_Energy = Statistics.mean(EnergyArray)
            #push!(arrayMeanEnergy, mean_x_Energy)
            push!(arrayMeanMagnetization1, mean_x)
        end

          #println(length(arrayMeanMagnetization1))
          meanMagnetizationVSTemp = Statistics.mean(arrayMeanMagnetization1)
          push!(arrayMeanMagnetizationVsTemp, meanMagnetizationVSTemp)
          push!(arrayTemp, temperature)

          if meanMagnetizationVSTemp <= 0

              if criticalTemp == 0

                  criticalTemp = temperature
                  println("Critical Temp" ,criticalTemp)

                  if funcToCall == "betaCalculation"

                      betaCalculation()   # Calling  betaCalculation function

                  elseif funcToCall == "TrialbetaCalculation"

                      arrayBetaReturn = TrialbetaCalculation()   # Calling  TrialbetaCalculation function
                  else

                      TrialCriticalTemp()  # Calling  TrialCriticalTemp function
                  end

                  break

              end
          end

        #println(temperature)
        temperature += increment # trade off with MonteCaroSweeps
    end

    return arrayBetaReturn
end

function betaCalculation()

    iCount = 1
    println("Entered betaCalculation")
    #println(arrayTemp[length(arrayTemp)-1])

    while iCount < (length(arrayTemp))

        beta = log10(arrayMeanMagnetizationVsTemp[iCount]) / log10(arrayTemp[length(arrayTemp)] - arrayTemp[iCount])
        push!(arrayBetaValue, beta)  # fetch all the possible values of beta
        iCount += 1
    end

end



function TrialbetaCalculation()

    arrayBeta = [0.005, 0.02, 0.03, 0.04, 0.05, 0.06, 0.07, 0.085, 0.125] # beta trail values

    ibetaCount = 1
    iMagCount  = 1
    println("Entered TrialbetaCalculation")
    println(arrayMeanMagnetizationVsTemp)
    println("Length:", length(arrayMeanMagnetizationVsTemp) )
    while ibetaCount <= length(arrayBeta)
        iMagCount  = 1
        arrayBetaEachIteration = []
        index = 1/arrayBeta[ibetaCount]
        while iMagCount <= length(arrayMeanMagnetizationVsTemp) - 1

            magVal =  arrayMeanMagnetizationVsTemp[iMagCount]
            valueFirstMethod  = (magVal)^(index)  #arrayBetaValue[ibetaCount]

            push!(arrayBetaEachIteration, valueFirstMethod)
            #println(valueFirstMethod)
            iMagCount += 1
        end
        push!(firstBetaTrial, arrayBetaEachIteration)
        ibetaCount += 1
    end

    arrayBeatValues = arrayBeta
end


function TrialCriticalTemp()

    #println(arrayTemp)
    #println("last element:" , arrayTemp[length(arrayTemp) ])

    iCount = length(arrayTemp)
    #println("iCount", iCount)
    #println("arrayTemp[length(iCount)]:", arrayTemp[length(arrayTemp)])

    while arrayTemp[iCount] >= 1.5

        criticalTemp = arrayTemp[iCount]
        println("Trial Critical Temp:" , criticalTemp)

        TrialCriticalTempCalculation(criticalTemp, iCount)
        iCount =  iCount -1
    end
end


function TrialCriticalTempCalculation(TrialCriticalTemp, iCount) # iCount means max index to be considered.

    println("Entered function TrialCriticalTempCalculation")
    println("TrialCriticalTemp, iCount",  TrialCriticalTemp , ","  , iCount )
    println("Arraytemp",  arrayTemp )

    iCountlocal = 1
    arrayLocalLogTempDiff = []
    arrayLocalLogMagnetism = []

    push!(arrayCriticalTemp, arrayTemp[iCount])

    while iCountlocal < (iCount)

        logM = log10(arrayMeanMagnetizationVsTemp[iCountlocal])
        logTc_T = log10(arrayTemp[iCount]-arrayTemp[iCountlocal]) # arrayTemp[iCount] is trial critcal temp

        push!(arrayLocalLogMagnetism , logM) #log(M)
        push!(arrayLocalLogTempDiff , logTc_T) #log(Tc - T)
        #beta = logM / logTc_T
        #push!(arrayBetaValue , beta)
        iCountlocal += 1
    end

    push!(logOf_M , arrayLocalLogMagnetism)
    push!(logOf_TcMinusT , arrayLocalLogTempDiff)
end
