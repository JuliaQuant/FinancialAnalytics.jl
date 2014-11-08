# R's PerformanceAnalytics results vary slightly because that package assigns a return of 0.00 for the first
# day while TimeSeries removes the first day from calculation because it considers the first day 
# consumed by calculation. The end result is testing in R uses 500 dates versus 499 dates in this package.

using MarketData

r = percentchange(cl)

facts("keyword checking is correct") do

  context("simple returns selected") do
      @fact foo(r) => -0.8392600357038683
  end

  context("log returns selected") do
      @fact foo(percentchange(cl,method="log"), log_transform=true) => -0.8392600357038683
  end

  context("simple prices selected") do
      @fact foo(cl, prices=true) => -0.8392600357038683
  end

  context("log prices selected") do
      @fact foo(basecall(cl,log), prices=true, log_transform=true) => -0.8392600357038683
  end
end

facts("ratio algorithms are correct") do

  context("burke_ratio") do
      @pending burke_ratio(r) => -0.4743222 # R's PerformanceAnalytics result
  end

  context("calmar_ratio") do
      @pending calmar_ratio(r) => -0.6208448 # R's PerformanceAnalytics result
  end

  context("d_ratio") do
      @pending d_ratio(r) => 1.207051 # R's PerformanceAnalytics result
  end

  context("kelly_ratio") do
      @pending kelly_ratio(r) => -0.3141632 # R's PerformanceAnalytics result
  end

  context("martin_ratio") do
      @pending martin_ratio(r) => -0.4974161 # R's PerformanceAnalytics result
  end

  context("omega_sharpe_ratio") do
      @pending omega_sharpe_ratio(r) => -0.0929731 # R's PerformanceAnalytics result
  end

  context("pain_ratio") do
      @pending pain_ratio(r) => -0.563304 # R's PerformanceAnalytics result
  end

  context("prospect_ratio") do
      @pending prospect_ratio(r, mar=0) => -0.5786125 # R's PerformanceAnalytics result
  end

  context("sharpe_ratio") do
      @pending sharpe_ratio(r, method=std) => -0.032477709 # R's PerformanceAnalytics result
      @pending sharpe_ratio(r, method=var) => -0.018203728 # R's PerformanceAnalytics result
      @pending sharpe_ratio(r, method=es) => -0.005944104  # R's PerformanceAnalytics result
  end

  context("skewness_kurtosis_ratio") do
      @pending skewness_kurtosis_ratio(r) => -0.09644818 # R's PerformanceAnalytics result
  end

  context("sortino_ratio") do
      @pending sortino_ratio(r) => -0.04005694 # R's PerformanceAnalytics result
  end

  context("upside_potential_ratio") do
      @pending upside_potential_ratio(r) =>  0.6002809 # R's PerformanceAnalytics result
  end
end

facts("index algorithms are correct") do

  context("hurst_index") do
      @pending hurst_indes(r) => 0.4087577 # R's PerformanceAnalytics result
  end

  context("pain_index") do
      @pending pain_index(r) => 0.9951365 # R's PerformanceAnalytics result
  end

  context("smoothing_index") do
      @pending smoothing_index(r) => 0.9825384 # R's PerformanceAnalytics result
  end

  context("ulcer_index") do
      @pending ulcer_index(r) => 1.126953 # R's PerformanceAnalytics result
  end
end

facts("other algorithms are correct") do

  context("annualized_return") do
      @fact annualized_return(r, method="arithmetic") =>  -0.4238347274496489 # R's PerformanceAnalytics result -0.4230444
      @fact annualized_return(r, method="geometric")  =>  -0.5612879122675767 # R's PerformanceAnalytics result -0.5605644
  end

  context("downside_deviation") do
      @pending downside_deviation(r) => 0.04190903 # R's PerformanceAnalytics result
  end

  context("downside_frequency") do
      @pending downside_frequency(r) => 0.508 # R's PerformanceAnalytics result
  end

  context("expected_shortfall") do
      @pending expected_shortfall(r) => -0.2824223 # R's PerformanceAnalytics result
  end

  context("max_drawdown") do
      @pending max_drawdown(r) => 0.9029059 # R's PerformanceAnalytics result
  end

  context("mean_absolute_deviation") do
      @pending mean_absolute_deviation(r) => 0.03441915 # R's PerformanceAnalytics result
  end

  context("omega") do
      @pending omega(r) => 0.9070269 # R's PerformanceAnalytics result
  end

  context("semi_deviation") do
      @pending semi_deviation(r) => 0.04119674 # R's PerformanceAnalytics result
  end

  context("upside_frequency") do
      @pending upside_frequency(r) => 0.464 # R's PerformanceAnalytics result
  end

  context("upside_risk") do
      @pending upside_risk(r) => 0.03021397 # R's PerformanceAnalytics result
  end

  context("value_at_risk") do
      @pending value_at_risk(r) => -0.09221999 # R's PerformanceAnalytics result
  end

  context("volatility_skewness") do
      @pending volatility_skewness(r) => 0.5197569 # R's PerformanceAnalytics result
  end
end
