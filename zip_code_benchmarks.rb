class ZipCodeBenchmarks
  def initialize(zip_code_plans, silver_plans)
    @zip_code_plans = zip_code_plans
    @silver_plans = silver_plans
    @zip_code_benchmarks = {}
  end

  def to_hash
    @zip_code_plans.each do |zip, plans|
      all_plans = all_zip_code_rates(plans)
      benchmark = calculate_second_lowest(all_plans)
      @zip_code_benchmarks[zip] = benchmark
    end
    @zip_code_benchmarks
  end

  def all_zip_code_rates(rate_collection)
    all_rates = []
    rate_collection.each do |rate_area|
      all_rates << @silver_plans[rate_area]
    end 
    all_rates.flatten
  end

  def calculate_second_lowest(plans)
    if plans.length >= 2
      plans.sort[1]  
    end
  end
end
