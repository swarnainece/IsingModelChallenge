
include("F:\\Julia\\Project\\src\\createArray.jl")
include("F:\\Julia\\Project\\src\\FreeEnergySpinSystem_Body.jl")


#MonteCarloSweeps = 1
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
using Calculus

pygui(true)
plt = pyimport("matplotlib.pyplot")
animation = pyimport("matplotlib.animation")
np = pyimport("numpy")
#plt.ion()
#fig = plt.figure()
global rows = 10
global columns = 10
Energy = 0

Temp = 7
global z = 4 #Nearest Neighbour
global increment = 0.05

#global EnergyArray = fill(0, rows, columns)

global arrayTemp = []
global arrayMeanEnergy = []
global array_tanh = []

global s_values = np.linspace(-1, 1, 30)

array_tanh = FreeEnergySpinSystem(Temp)  # Enter 0.1 , 0.2.....0.5...1, 2, 3, 4, 5

plt.axhline(0, color="black")
plt.axvline(0, color="black")
plot(s_values, array_tanh, "-.", label= "T=Tc") #color="tab:green")
plt.legend()
