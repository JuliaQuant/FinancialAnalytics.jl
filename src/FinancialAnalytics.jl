module FinancialAnalytics

using FinancialBlotter, Reexport
@reexport using FinancialBlotter

export greet, swilk, shapiro, ∑matrix

###### include ##################

include("fortran.jl")
include("matrix.jl")

end
