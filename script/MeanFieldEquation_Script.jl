
include("F:\\Julia\\Project\\src\\createArray.jl")
include("F:\\Julia\\Project\\src\\MeanFieldEquationBody.jl")

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
temperature = 1 # initialize temperature
global FinalTemp = 5
MonteCarloSweeps = 1000
global z = 4 #Nearest Neighbour

global EnergyArray = fill(0, rows, columns)


global arrayCriticalTemp = []
global arrayTemp = []
global arrayMeanEnergy = []
global arrayMeanMagnetizationVsTemp = []
global arrayMeanMagnetization = []
global imageArrayMatrixOriginal = []
global arraySum = []
global arrayThermalAvg = []
global array_tanh = []


global arrayLowTemp_S = []
global arrayHighTemp_S = []

global arrayLowTemp_tanh  = []
global arrayHighTemp_tanh = []




x = createArray(arrayType)

#Calling MeanFieldEquationBody function
MeanFieldEquationBody(x, plt, temperature)

println(arrayMeanMagnetizationVsTemp)
println("Array Sum")
#println(arraySum)

#Calling Finding_ThermalAVG_S function
Finding_ThermalAVG_S() #<s>

#Calling tanh_of_S function
tanh_of_S()   #tanh

#Calling Low_High_Temperature_Segregate function
Low_High_Temperature_Segregate()

println(arrayLowTemp_S)
println(arrayHighTemp_S)
println(arrayLowTemp_tanh)
println(arrayHighTemp_tanh)


#println(arrayThermalAvg)
#println(length(arrayThermalAvg))
#println(length(arrayTemp))
#println(length(array_tanh))
#println(array_tanh)

plt.plot(TemperatureAxis, arrayMeanMagnetizationVsTemp ,".")
plt.xlabel("Temperature")
plt.ylabel("Magnetization")
plt.xlim(0, 8)
plt.ylim(-0.1, 1.1)
plt.title("Magnetization vs Temperature")
plt.legend()
plt.show()

"""
#Test Code
plt.plot(arrayHighTemp_S, arrayHighTemp_S ,"-.", color="tab:blue")
plt.plot(arrayHighTemp_S, arrayHighTemp_tanh ,"-.", color="tab:orange")
#plt.xlabel("Temperature")
#plt.xlim(0, 10)
#plt.ylabel("Magnetization")
plt.show() """
