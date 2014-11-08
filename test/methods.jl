# R's PerformanceAnalytics has implemented many of these algorithms
# and the results from that package are used to cross-check the 
# correctness of the methods in FinancialAnalytics.

using MarketData

Ra  = percentchange(cl)
Rb = percentchange(BA["Close"][1:501])
Rc = percentchange(CAT["Close"][1:501])

facts("keyword checking is correct") do

  context("simple returns selected") do
      @fact foo(Ra) => -0.8392600357038683
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

  context("adjusted_sharpe_ratio") do
      @pending adjusted_sharpe_ratio(Ra) => -0.4875318 # R's PerformanceAnalytics result
  end

  context("appraisal_ratio") do
      @pending appraisal_ratio(Ra, Rb) => -0.6827613 # R's PerformanceAnalytics result
  end

  context("bernardo_ledoit_ratio") do
      @pending bernardo_ledoit_ratio(Ra) => 0.9070269 # R's PerformanceAnalytics result
  end

  context("calmar_ratio") do
      @pending calmar_ratio(Ra) => -0.6216461 # R's PerformanceAnalytics result
  end

  context("d_ratio") do
      @pending d_ratio(Ra) => 1.207051 # R's PerformanceAnalytics result
  end

  context("kelly_ratio") do
      @pending kelly_ratio(Ra) => -0.3141626 # R's PerformanceAnalytics result
  end

  context("martin_ratio") do
      @pending martin_ratio(Ra) => -0.4975598 # R's PerformanceAnalytics result
  end

  context("omega_sharpe_ratio") do
      @pending omega_sharpe_ratio(Ra) => -0.0929731 # R's PerformanceAnalytics result
  end

  context("pain_ratio") do
      @pending pain_ratio(Ra) => -0.562903 # R's PerformanceAnalytics result
  end

  context("prospect_ratio") do
      @pending prospect_ratio(Ra, mar=0) => -0.579192 # R's PerformanceAnalytics result
  end

  context("sharpe_ratio") do
      @pending sharpe_ratio(Ra, method=std) => -0.032510205 # R's PerformanceAnalytics result
      @pending sharpe_ratio(Ra, method=var) => -0.018213539 # R's PerformanceAnalytics result
      @pending sharpe_ratio(Ra, method=es)  => -0.005940691 # R's PerformanceAnalytics result
  end

  context("skewness_kurtosis_ratio") do
      @pending skewness_kurtosis_ratio(Ra) => -0.09654119 # R's PerformanceAnalytics result
  end

  context("sortino_ratio") do
      @pending sortino_ratio(Ra) => -0.04009706 # R's PerformanceAnalytics result
  end

  context("treynor_ratio") do
      @pending treynor_ratio(Ra,Rb) => -4.671493 # R's PerformanceAnalytics result
  end

  context("upside_potential_ratio") do
      @pending upside_potential_ratio(Ra) => 0.6002809 # R's PerformanceAnalytics result
  end
end

facts("index algorithms are correct") do

  context("hurst_index") do
      @pending hurst_indes(Ra) => 0.4087282 # R's PerformanceAnalytics result
  end

  context("pain_index") do
      @pending pain_index(Ra) => 0.9971307 # R's PerformanceAnalytics result
  end

  context("smoothing_index") do
      @pending smoothing_index(Ra) => 0.9825174 # R's PerformanceAnalytics result
  end

  context("ulcer_index") do
      @pending ulcer_index(Ra) => 1.128081 # R's PerformanceAnalytics result
  end
end

facts("other algorithms are correct") do

  context("active_premium") do
      @pending active_premium(Ra,Rb) => -0.5434139 # R's PerformanceAnalytics result 
  end

  context("annualized_return") do
      @fact annualized_return(Ra, method="arithmetic") =>  -0.4238347274496489 # R's PerformanceAnalytics result -0.4238922
      @fact annualized_return(Ra, method="geometric")  =>  -0.5612879122675767 # R's PerformanceAnalytics result -0.5612879
  end

  context("downside_deviation") do
      @pending downside_deviation(Ra) => 0.041951 # R's PerformanceAnalytics result
  end

  context("downside_frequency") do
      @pending downside_frequency(Ra) => 0.509018 # R's PerformanceAnalytics result
  end

  context("expected_shortfall") do
      @pending expected_shortfall(Ra) => -0.2831509 # R's PerformanceAnalytics result
  end

  context("fama_beta") do
      @pending fama_beta(Ra,Rb) => 1.924636 # R's PerformanceAnalytics result
  end

  context("lower_partial_moment") do
      @pending lower_partial_moment(Ra,Rb) => 1.964494 # R's PerformanceAnalytics result
  end

  context("m2_sortina") do
      @pending m2_sortina(Ra,Rb) => -0.5470395 # R's PerformanceAnalytics result
  end

  context("msquared") do
      @pending msquared(Ra,Rb) => -0.2916333 # R's PerformanceAnalytics result
  end

  context("msquared_excess") do
      @pending msquared_excess(Ra,Rb) => -0.2787415 # R's PerformanceAnalytics result
  end

  context("modigliani") do
      @pending modigliani(Ra,Rb) => -0.0008739896 # R's PerformanceAnalytics result
  end

  context("max_drawdown") do
      @pending max_drawdown(Ra) => 0.9029059 # R's PerformanceAnalytics result
  end

  context("mean_absolute_deviation") do
      @pending mean_absolute_deviation(Ra) => 0.0344848 # R's PerformanceAnalytics result
  end

  context("net_selectivity") do
      @pending net_selectivity(Ra,Rb) => -0.5268869 # R's PerformanceAnalytics result
  end

  context("omega") do
      @pending omega(Ra) => 0.9070269 # R's PerformanceAnalytics result
  end

  context("selectivity") do
      @pending selectivity(Ra,Rb) => -0.5591403 # R's PerformanceAnalytics result
  end

  context("semi_deviation") do
      @pending semi_deviation(Ra) => 0.04123659 # R's PerformanceAnalytics result
  end

  context("specific_risk") do
      @pending specific_risk(Ra,Rb) => 0.8189397 # R's PerformanceAnalytics result
  end

  context("total_risk") do
      @pending total_risk(Ra,Rb) => 0.8205434 # R's PerformanceAnalytics result
  end

  context("upside_frequency") do
      @pending upside_frequency(Ra) => 0.4649299 # R's PerformanceAnalytics result
  end

  context("upside_risk") do
      @pending upside_risk(Ra) => 0.03024423 # R's PerformanceAnalytics result
  end

  context("value_at_risk") do
      @pending value_at_risk(Ra) => -0.09235503 # R's PerformanceAnalytics result
  end

  context("volatility_skewness") do
      @pending volatility_skewness(Ra) => 0.5197569 # R's PerformanceAnalytics result
  end
end
