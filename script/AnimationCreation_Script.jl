root_Directory = pwd()


include(root_Directory * "\\IsingModelChallenge\\src\\createArray.jl")
include(root_Directory * "\\IsingModelChallenge\\src\\IterateEnergyArray.jl")
include(root_Directory * "\\IsingModelChallenge\\src\\Normalization.jl")
include(root_Directory * "\\IsingModelChallenge\\src\\Animation_Creation_Body.jl")


arrayType = "negative" # positive, negative, both

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

path = "C:\\Users\\swarn\\Desktop\\Apply Academic\\Metropolis\\im.gif"

fig, ax = plt.subplots()

global rows = 100
global columns = 100
Energy = 0

temperature = 0 # initialize temperature
global FinalTemp = 5

MonteCarloSweeps = 100

imageArray = []
global arrayNormalized = []
global arrayTemp = []
global arrayMeanEnergy = []
global arrayMeanMagnetizationVsTemp = []
global arrayMeanMagnetization = []
global imageArrayMatrixOriginal = []

global EnergyArray = fill(0, rows, columns)

x = createArray(arrayType)
AnimationArray = MagnetizationVsTemp(x, plt, temperature, ax) #calling generateData.jl

#println("Length of Animation Array:--->", length(AnimationArray) )
#println("Length of imageArrayMatrixOriginal::-->", length(imageArrayMatrixOriginal)
#println(arrayMeanMagnetizationVsTemp)

ani = animation.ArtistAnimation(fig, AnimationArray, interval=100, blit=true, repeat_delay=1000)
ani.save(path)  #Location to save
plt.show()
