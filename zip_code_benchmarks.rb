class ZipCodeBenchmarks
  def initialize(zip_code_rate_areas:, silver_plans:)
    @zip_code_rate_areas = zip_code_rate_areas
    @silver_plans = silver_plans
    @zip_code_benchmarks = {}
  end

  def to_h
    @zip_code_rate_areas.each do |zip, rate_area|
      silver_plans = @silver_plans[rate_area]
      if silver_plans
        benchmark = calculate_second_lowest(silver_plans)
        @zip_code_benchmarks[zip] = benchmark
      end
    end
    @zip_code_benchmarks
  end

  def calculate_second_lowest(plans)
    if plans.length >= 2
      plans.sort[1]
    end
  end
end
