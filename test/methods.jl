using MarketData

r = percentchange(cl)

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

  context("sortino_ratio") do
      @pending sortino_ratio(r) => -0.04005694 # R's PerformanceAnalytics result
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
