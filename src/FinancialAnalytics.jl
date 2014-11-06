using TimeSeries

module FinancialAnalytics

using TimeSeries

export foo, bar,
       analyze,
       tradestats, rets,
       greet, swilk, shapiro, ∑matrix

include("methods.jl")
include("const.jl")
include("fortran.jl")
include("matrix.jl")

end
