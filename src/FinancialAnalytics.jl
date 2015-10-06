using Distributions, Dates, TimeSeries

module FinancialAnalytics

using Distributions, Dates, TimeSeries

export annualized_return, equity,
       greet, swilk, shapiro, ∑matrix

###### include ##################

include("returns.jl")
include("fortran.jl")
include("matrix.jl")

end
