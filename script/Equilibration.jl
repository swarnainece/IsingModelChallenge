
root_Directory = pwd()

include(root_Directory * "\\Project\\src\\createArray.jl")
include(root_Directory * "\\Project\\src\\Equlibration_Body.jl")

path = "C:\\Users\\swarn\\Desktop\\Apply Academic\\Equi\\"  # Change the path in your local machine 

#Set Temperature
Temp = 2.4  # 1.5, 2.25, 4.0
#global k = 1.380649 * 10^(-23)

MonteCarloSweeps = 10000
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


global rows = 100
global columns = 100
Energy = 0

imageArray = []
global arrayNormalized = []
global arrayMeanEnergy = []
global arrayMeanMagnetizationVsTime = []

global EnergyArray = fill(0, rows, columns)
x = createArray(arrayType)

Time = np.linspace(0, MonteCarloSweeps, MonteCarloSweeps)
#Function Calling
Equlibration_Body(x, Temp, path)

#print(arrayMeanMagnetizationVsTime)
plt.plot(Time, arrayMeanMagnetizationVsTime)
plt.xlabel("Time")
plt.ylabel("Magnetization")
plt.xlim(0, MonteCarloSweeps)
plt.ylim(-1.2, 1.2)
plt.title("Magnetization vs Time")
#plt.legend()
plt.show()
