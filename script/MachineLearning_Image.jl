
include("F:\\Julia\\Project\\src\\createArray.jl")
include("F:\\Julia\\Project\\src\\GenerateImageSet.jl")
include("F:\\Julia\\Project\\src\\MachineLearning_Body.jl")

arrayType = "positive" # positive, negative, both
#global plt
#ENV["PYTHON"] = "C:\\Users\\swarn\\Anaconda3\\python.exe"
ENV["MPLBACKEND"]="tkagg"

path = "C:\\Users\\swarn\\Desktop\\Apply Academic\\ImagesForML\\"

using Pkg
using PyCall
using PyPlot
using Random
using Statistics

pygui(true)
plt = pyimport("matplotlib.pyplot")
animation = pyimport("matplotlib.animation")
np = pyimport("numpy")

fig, ax = plt.subplots()

global rows = 100
global columns = 100
Energy = 0

temperature = 1.3 # initialize temperature
global FinalTemp = 5

MonteCarloSweeps = 100

global imageArray = []
global arrayNormalized = []
global arrayTemp = []
global arrayMeanEnergy = []
global arrayMeanMagnetizationVsTemp = []
global arrayMeanMagnetization = []
global imageArrayMatrixOriginal = []

global EnergyArray = fill(0, rows, columns)

x = createArray(arrayType)
MachineLearningBody(x, plt, ax, temperature, path) #calling generateData.jl
