include("F:\\Julia\\Project\\src\\createArray.jl")
include("F:\\Julia\\Project\\src\\GenerateImageSet.jl")
include("F:\\Julia\\Project\\src\\IterateEnergyArray.jl")

arrayType = "both" # positive, negative, both
#global plt
#ENV["PYTHON"] = "C:\\Users\\swarn\\Anaconda3\\python.exe"
ENV["MPLBACKEND"]="tkagg"

path = "C:\\Users\\swarn\\Desktop\\Apply Academic\\SetOfImages\\"

using Pkg
using PyCall
using PyPlot
using Random
using Statistics

pygui(true)
plt = pyimport("matplotlib.pyplot")
animation = pyimport("matplotlib.animation")
np = pyimport("numpy")

fig = plt.figure()

global rows = 100
global columns = 100
Energy = 0

temperature = 5 # initialize temperature
global FinalTemp = 1

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
AnimationArray = GenerateImageSet(x, plt, temperature, path) #calling generateData.jl

"""
function savePictures()

    iCount = 1
    while iCount <= length(imageArrayMatrixOriginal)

        fig = plt.figure()
        plt.imshow(imageArrayMatrixOriginal[iCount])
        plt.show()
        path = "C:\\Users\\swarn\\Desktop\\Apply Academic\\SetOfImages\\pic" * string(iCount) * ".png"
        plt.savefig(path)
        iCount += 1

    end
end    """
