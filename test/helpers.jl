include(Pkg.dir("FinancialAnalytics/src/helpers.jl"))
using MarketData

r = percentchange(cl)

facts("keyword checking is correct") do

  context("simple returns selected") do
      @fact sum(keyword_check(r,false,false).values) => -0.8392600357038683
  end

  context("lsum(og returns selected") do
      @fact sum(keyword_check(percentchange(cl,method="log"),false,true).values) => -0.8392600357038683
  end

  context("ssum(imple prices selected") do
      @fact sum(keyword_check(cl,true,false).values) => -0.8392600357038683
  end

  context("lsum(og prices selected") do
      @fact sum(keyword_check(basecall(cl,log),true,true).values) => -0.8392600357038683
  end
end
