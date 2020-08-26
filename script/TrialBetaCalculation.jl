
include("F:\\Julia\\Project\\src\\createArray.jl")
include("F:\\Julia\\Project\\src\\generateData.jl")
include("F:\\Julia\\Project\\src\\IterateEnergyArray.jl")
include("F:\\Julia\\Project\\src\\Normalization.jl")
include("F:\\Julia\\Project\\src\\ExactBetaMeasurement.jl")


#MonteCarloSweeps = 1
global imageArray = []
arrayType = "positive" # positive, negative, both
#global plt
#ENV["PYTHON"] = "C:\\Users\\swarn\\Anaconda3\\python.exe"
ENV["MPLBACKEND"]="tkagg"

using Pkg
#Pkg.add("DataFrames")
#Pkg.add("ImageMagick")
#Pkg.add("Statistics")
using PyCall
using PyPlot
using Random
using Statistics

pygui(true)
plt = pyimport("matplotlib.pyplot")
animation = pyimport("matplotlib.animation")
np = pyimport("numpy")
#plt.ion()
#fig = plt.figure()
global rows = 10
global columns = 10
Energy = 0
temperature = 0.1 # initialize temperature
MonteCarloSweeps = 1000

imageArray = []
global arrayNormalized = []
global arrayTemp = []
global arrayMeanEnergy = []
global arrayMeanMagnetizationVsTemp = []
global arrayLog_Temp_Difference = []
global arrayBetaValue = []
global firstBetaTrial = []
global arrayBeatValues = []


global EnergyArray = fill(0, rows, columns)

x = createArray(arrayType)
arrayBeatValues = MagnetizationVsTemp(x, plt, temperature, "TrialbetaCalculation")

deleteat!(arrayTemp, length(arrayTemp)) # Delete the last lement of the array
println("arrayTemp Lenght:", length(arrayTemp))

println(" Length of firstBetaTrial:", length(firstBetaTrial))

for i in 1:length(firstBetaTrial)

    println(firstBetaTrial[i])
end


function  GraphPlot()

    iCount = 1
    title = ""
    while iCount <= length(firstBetaTrial)

            plt.figure()
            TemperatureAxis = np.linspace(1, 3, length(firstBetaTrial[iCount]))


            title = "beta=" * string(arrayBeatValues[iCount])
            m , b = np.polyfit(arrayTemp, firstBetaTrial[iCount], 1 )
            x = arrayTemp
            y = (m*x).+b   #y = mx + c
            plt.plot(arrayTemp, firstBetaTrial[iCount] ,".", color = "green")
            plt.plot(x, y)
            plt.title(title)
            plt.xlabel("Temp")
            plt.xlim(0, 3)
            plt.ylabel("\$ M^{1/β} \$")
            #ax[i,j].set(xlabel= "Temp" , ylabel= "\$ M^{1/β} \$")
            iCount += 1
        end

    plt.show()
end

function  GraphPlot1()

    iCount = 1
    title = ""
    while iCount <= length(firstBetaTrial)

            plt.figure()
            title = "beta=" * string(arrayBeatValues[iCount])
            coefficients = np.polyfit(arrayTemp, firstBetaTrial[iCount], 2 )
            poly = np.poly1d(coefficients)
            y_new = poly(arrayTemp)
            plt.plot(arrayTemp, firstBetaTrial[iCount] ,".", color = "green")
            plt.plot(arrayTemp, y_new)
            plt.title(title)
            plt.xlabel("Temp")
            plt.xlim(0, 3)
            plt.ylim(-0.2, 1.2)
            plt.ylabel("\$ M^{1/β} \$")
            #ax[i,j].set(xlabel= "Temp" , ylabel= "\$ M^{1/β} \$")
            iCount += 1
        end

    plt.show()
end



GraphPlot()
#GraphPlot1()
#println(arrayBeatValues)
