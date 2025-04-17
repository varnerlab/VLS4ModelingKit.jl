"""
    function build(modeltype::Type{MySISOLegSHiPPOModel}, data::NamedTuple) -> MySISOLegSHiPPOModel

This `build` method constructs an instance of the [`MySisoLegSHippoModel`](@ref) type using the data in a [NamedTuple](https://docs.julialang.org/en/v1/base/base/#Core.NamedTuple).
This implementation uses the bilinear method to discretize the model, where the `A` and `B` matrices are computed
using the [Leg-S parameterization](https://arxiv.org/abs/2008.07669).

### Arguments
- `modeltype::Type{MySisoLegSHippoModel}`: The type of model to build.
- `data::NamedTuple`: The data to use to build the model. 

The `data::NamedTuple` must contain the following `keys`:
- `number_of_hidden_states::Int64`: The number of hidden states in the model.
- `Δt::Float64`: The time step size used to discretize the model (constant).
- `uₒ::Array{Float64,1}`: The initial input to the model.
- `C::Array{Float64,1}`: The output matrix of the model.
"""
function build(modeltype::Type{MySISOLegSHiPPOModel}, data::NamedTuple)::MySISOLegSHiPPOModel

    # initialize -
    model = modeltype(); # build an empty model

    # get data -
    number_of_hidden_states = data.number_of_hidden_states;
    Δt = data.Δt; # time step size
    uₒ = data.uₒ; # initial input
    C = data.C; # output matrix

    # A matrix -
    A = zeros(number_of_hidden_states,number_of_hidden_states);
    for i ∈ 1:number_of_hidden_states
        for k ∈ 1:number_of_hidden_states
        
            a = -sqrt((2*i+1))*sqrt((2*k+1));
            b = nothing;
            if (i > k)
                b = 1;
            elseif (i == k)
                b = (i+1)/(2*i+1); # not sure - why do I have this?
            else
                b = 0
            end
            A[i,k] = a*b;
        end
    end

    # B matrix -
    B = zeros(number_of_hidden_states);
    for i ∈ 1:number_of_hidden_states
        B[i] = (2*i+1) |> sqrt
    end

    # discretize the arrays using the Bilinear method -
    Ā = inv((I - (Δt/2)*A))*(I + (Δt/2)*A);
    B̄ = inv((I - (Δt/2)*A))*(Δt)*B;
    C̄ = C; # initialize a random C matrix (user can update this later)
    D̄ = zeros(number_of_hidden_states); # initialize a zero D matrix (user can update this later)

    # set the values -
    model.Ā = Ā;
    model.B̄ = B̄;
    model.C̄ = C̄;
    model.D̄ = D̄;
    model.n = number_of_hidden_states;
    model.uₒ = uₒ; # set the initial input to the first element of the array

    # return -
    return model;
end