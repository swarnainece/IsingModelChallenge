include("F:\\Julia\\Project\\src\\createArray.jl")
include("F:\\Julia\\Project\\src\\IterateEnergyArray.jl")
include("F:\\Julia\\Project\\src\\Normalization.jl")
include("F:\\Julia\\Project\\src\\HotStart_Body.jl")




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

path = "C:\\Users\\swarn\\Desktop\\Apply Academic\\im.gif"

fig, ax = plt.subplots()

global rows = 100
global columns = 100
Energy = 0

temperature = 5 # initialize temperature
global FinalTemp = 1

MonteCarloSweeps = 100

imageArray = []
global arrayNormalized = []
global arrayTemp = []
global arrayMeanEnergy = []
global arrayMeanMagnetizationVsTemp = []
global arrayMeanMagnetization = []
global imageArrayMatrixOriginal = []


global EnergyArray = fill(0, rows, columns)

arrayType = "both" # positive, negative, both

x = createArray(arrayType)

#println(x)
#plt.imshow(x)    Test to dispaly the matrix color front-end

AnimationArray = MagnetizationVsTemp(x, plt, temperature, ax) #calling generateData.jl
#println("Length of Animation Array:--->", length(AnimationArray) )
#println("Length of imageArrayMatrixOriginal::-->", length(imageArrayMatrixOriginal)
#println(arrayMeanMagnetizationVsTemp)

ani = animation.ArtistAnimation(fig, AnimationArray, interval=50, blit=true, repeat_delay=1000)
ani.save(path)  #Location to save
plt.show()
