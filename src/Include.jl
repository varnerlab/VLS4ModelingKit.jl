# setup my paths -
const _PATH_TO_SRC = dirname(pathof(@__MODULE__));

# load external dependencies -
using Distributions
using Statistics
using LinearAlgebra
using DataFrames
using JLD2
using CSV
using Optim
using Test

# load my codes -
include(joinpath(_PATH_TO_SRC, "Types.jl"));
include(joinpath(_PATH_TO_SRC, "Factory.jl"));
include(joinpath(_PATH_TO_SRC, "Hippo.jl"));