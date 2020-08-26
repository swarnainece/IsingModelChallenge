
root_Directory = pwd()

include(root_Directory * "\\Project\\src\\createArray.jl")
include(root_Directory * "\\Project\\src\\MagnetizationVsTemp.jl")

global imageArray = []
arrayType = "positive" # positive, negative, both
#global plt
#ENV["PYTHON"] = "C:\\Users\\swarn\\Anaconda3\\python.exe"
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
temperature = 1 # initialize temperature
global FinalTemp = 5
MonteCarloSweeps = 1000

global arrayNormalized = []
global arrayTemp = []
global arrayMeanEnergy = []
global arrayMeanMagnetizationVsTemp = []
global arrayMeanMagnetization = []
global imageArrayMatrixOriginal = []

global EnergyArray = fill(0, rows, columns)
x = createArray(arrayType)
AnimationArray = MagnetizationVsTemp(x, plt, temperature)

TemperatureAxis = np.linspace(1, 5, length(arrayMeanMagnetizationVsTemp))
plt.plot(TemperatureAxis, arrayMeanMagnetizationVsTemp ,".")
plt.xlabel("Temperature")
plt.ylabel("Magnetization")
plt.xlim(0, 5)
plt.ylim(-0.1, 1.1)
plt.title("Magnetization vs Temperature")
plt.show()
