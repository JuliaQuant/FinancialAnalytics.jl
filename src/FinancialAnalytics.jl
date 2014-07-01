module FinancialAnalytics

using FinancialBlotter, Reexport
@reexport using FinancialSeries

export greet, swilk, shapiro, ∑matrix

###### include ##################

include("fortran.jl")
include("matrix.jl")

end
