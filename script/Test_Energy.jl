root_Directory = pwd()

include(root_Directory * "\\Project\\src\\createArray.jl")
include(root_Directory * "\\Project\\src\\Body1.jl")

#include("F:\\Julia\\Project\\src\\createArray.jl")
#include("F:\\Julia\\Project\\src\\MagnetizationVsTemp.jl")

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
global FinalTemp = 3
MonteCarloSweeps = 1000

global arrayNormalized = []
global arrayTemp = []
global arrayMeanEnergy = []
global arrayMeanMagnetizationVsTemp = []
global arrayMeanMagnetization = []
global imageArrayMatrixOriginal = []

global EnergyArray = fill(0, rows, columns)
x = createArray(arrayType)
TestEnergyArray(x, plt, temperature)
