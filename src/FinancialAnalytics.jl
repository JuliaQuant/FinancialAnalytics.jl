using TimeSeries

module FinancialAnalytics

using TimeSeries

export foo, bar,
       annualized_return,
       analyze,
       tradestats, rets,
       greet, swilk, shapiro, ∑matrix

include("methods.jl")
include("const.jl")
include("helpers.jl")

end
