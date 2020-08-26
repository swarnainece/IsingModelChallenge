
root_Directory = pwd()

include(root_Directory * "\\Project\\src\\createArray.jl")
include(root_Directory * "\\Project\\src\\MagnetizationVsTime_Body.jl")

#Set Temperature
Temp = 1.5  # 1.5, 2.25, 4.0

MonteCarloSweeps = 1000
global imageArray = []
arrayType = "positive" # positive, negative, both

ENV["MPLBACKEND"]="tkagg"

using Pkg
using PyCall
using PyPlot
using Random
using Statistics

pygui(true)
plt = pyimport("matplotlib.pyplot")
animation = pyimport("matplotlib.animation")
np = pyimport("numpy")


global rows = 10
global columns = 10
Energy = 0

imageArray = []
global arrayNormalized = []
global arrayMeanEnergy = []
global arrayMeanMagnetizationVsTime = []

global EnergyArray = fill(0, rows, columns)
x = createArray(arrayType)

Time = np.linspace(0, MonteCarloSweeps, MonteCarloSweeps)
#Function Calling
MagnetizationVsTime_Body(x, Temp)

#print(arrayMeanMagnetizationVsTime)
plt.plot(Time, arrayMeanMagnetizationVsTime)
plt.xlabel("Time")
plt.ylabel("Magnetization")
plt.xlim(0, MonteCarloSweeps)
plt.ylim(-1.2, 1.2)
plt.title("Magnetization vs Time")
#plt.legend()
plt.show()
