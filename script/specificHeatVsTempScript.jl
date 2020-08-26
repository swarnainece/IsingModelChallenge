
include("F:\\Julia\\Project\\src\\createArray.jl")
#include("F:\\Julia\\Project\\src\\generateData.jl")
include("F:\\Julia\\Project\\src\\specificHeatVsTemp.jl")


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
global rows = 100
global columns = 100
Energy = 0
temperature = 1 # initialize temperature
MonteCarloSweeps = 100

imageArray = []

global EnergyArray = fill(0, rows, columns)
global arraySpecificHeatVsTemp = []

x = createArray(arrayType)
SpecificHeatVsTemp(x, plt, temperature)
#println(arraySpecificHeatVsTemp)


TemperatureAxis = np.linspace(1, 5, length(arraySpecificHeatVsTemp))
plt.plot(TemperatureAxis, arraySpecificHeatVsTemp ,"o", color="green")
plt.xlabel("Temperature")
plt.ylabel("Specific Heat per Spin")
plt.xlim(0, 5)
plt.ylim(0, 1.6)
plt.title("Specific Heat per Spin vs Temperature")
plt.show()
