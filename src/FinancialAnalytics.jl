using Distributions, Dates, TimeSeries

module FinancialAnalytics

using Distributions, Dates, TimeSeries

export annualized_return, equity,
       greet, swilk, shapiro, ∑matrix

include("returns.jl")
include("methods.jl")

end
