abstract type AbstractS4HiPPOModel end

"""
    mutable struct MySisoLegSHippoModel <: AbstractS4HiPPOModel

A mutable struct that represents a single-input, single-output (SISO) linear time-invariant (LTI) system
that used the Leg-S parameterization. An instance of `MySisoLegSHippoModel` is configuired and constructed using
a corresponding `build` method.

### Fields
- `Â::Array{Float64,2}`: Discretized state matrix of the system `Â ∈ ℝ^(n x n)` where `n` is the number of hidden states
- `B̂::Array{Float64,1}`: Discretized input matrix of the system `B̂ ∈ ℝ^n x 1`
- `Ĉ::Array{Float64,1}`: Discretized output matrix of the system `Ĉ ∈ ℝ^1 x n`
- `D̂::Array{Float64,1}`: Discretized feedforward matrix of the system `D̂ ∈ ℝ^1 x 1`
- `n::Int`: Number of hidden states in the system
- `Xₒ::Array{Float64,1}`: Initial conditions of the system
"""
mutable struct MySISOLegSHiPPOModel <: AbstractS4HiPPOModel

    # data -
    Â::Array{Float64,2} # Discretized state transition matrix 
    B̂::Array{Float64,1} # Discretized input matrix
    Ĉ::Array{Float64,1} # Discretized output matrix
    D̂::Array{Float64,1} # Discretized feedforward matrix
    n::Int # Number of hidden states
    Xₒ::Array{Float64,1} # Initial conditions

    # constructor -
    MySISOLegSHiPPOModel() = new();
end