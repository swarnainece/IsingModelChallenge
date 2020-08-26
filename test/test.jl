
include("F:\\Julia\\Project\\src\\createArray.jl")
include("F:\\Julia\\Project\\src\\generateData.jl")
include("F:\\Julia\\Project\\src\\IterateEnergyArray.jl")
include("F:\\Julia\\Project\\src\\Normalization.jl")

global Temp = 2.5   # 1, 2.5, 5
#global k = 1.380649 * 10^(-23)
MonteCarloSweeps = 1
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
fig = plt.figure()

#fig, ax = plt.subplots()

global rows = 10
global columns = 10
Energy = 0

imageArray = []
global arrayNormalized = []
global arrayTotalMagnetization = []
global EnergyArray = fill(0, rows, columns)

Time = np.linspace(0, MonteCarloSweeps, MonteCarloSweeps)

x = createArray(arrayType)
println(x)
Juno.@enter generateData(x, MonteCarloSweeps, plt)

#println(arrayTotalMagnetization)

#Normalization(arrayTotalMagnetization)
#println(arrayNormalized)

"""
plt.plot(Time, arrayNormalized)
plt.xlabel("Time")
plt.ylabel("Magnetization")
plt.title("Magnetization vs Time")
plt.legend()
plt.show()  """
