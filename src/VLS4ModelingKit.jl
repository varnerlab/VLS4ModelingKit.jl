module VLS4ModelingKit

    # include -
    include("Include.jl")

    # export abstract and concrete types 
    export AbstractS4HiPPOModel
    export MySISOLegSHiPPOModel

    # export methods
    export build, solve, learn, predict



end # module VLS4ModelingKit
