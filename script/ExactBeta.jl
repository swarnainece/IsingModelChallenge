
path = pwd()

include(path*"\\IsingModelChallenge\\src\\createArray.jl")
include(path*"\\IsingModelChallenge\\src\\generateData.jl")
include(path*"\\IsingModelChallenge\\src\\IterateEnergyArray.jl")
include(path*"\\IsingModelChallenge\\src\\Normalization.jl")
include(path*"\\IsingModelChallenge\\src\\ExactBetaMeasurement.jl")


#MonteCarloSweeps = 1
global imageArray = []
global arrayTemp = []
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
global rows = 10
global columns = 10
Energy = 0
temperature = 0.1 # initialize temperature
MonteCarloSweeps = 1000

imageArray = []
global arrayNormalized = []
global arrayMeanEnergy = []
global arrayMeanMagnetizationVsTemp = []
global arrayLog_Temp_Difference = []
global arrayBetaValue = []
global arrayBetaTemp = []
global arrayTestBetaTemp = []

global EnergyArray = fill(0, rows, columns)

x = createArray(arrayType)
MagnetizationVsTemp(x, plt, temperature, "betaCalculation") # calling func betaCalculation inside MagnetizationVsTemp



#deleteat!(arrayTemp, length(arrayTemp))
#println( "Array Temp" , arrayTemp)
#println( "Length Array Temp" , length(arrayTemp))

deleteat!(arrayMeanMagnetizationVsTemp, length(arrayMeanMagnetizationVsTemp))
println( "Mag:" , arrayMeanMagnetizationVsTemp)
println("Length of Mag array" , length(arrayMeanMagnetizationVsTemp))

println( "beta:" , arrayBetaValue)
println("Length of beta array" , length(arrayBetaValue))


println("Mag:" , arrayMeanMagnetizationVsTemp)
println("Beta:" , arrayBetaValue)
println( "Temp:"  , arrayBetaTemp)
println("Temp1:", arrayTestBetaTemp)

plt.plot(arrayBetaTemp, arrayBetaValue)
plt.xlabel("Temperature")
plt.ylabel("Beta")
plt.xlim(0, 5)
plt.ylim(-1.5, 2)
plt.title("Beta vs Temperature")
plt.show() """
