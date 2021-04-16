class ZipCodePlans
  def initialize(zip_code_rate_areas)
    @zip_code_rate_areas = zip_code_rate_areas
    @zip_code_plans = {}
  end

  def to_hash
    @zip_code_rate_areas.each do |zip_code_rate_area|
      # add any rate areas we see to our hash
      zip_code = zip_code_rate_area["zipcode"]
      rate_area = zip_code_rate_area["rate_area"]

      unless @zip_code_plans[zip_code]
        @zip_code_plans[zip_code] = []
      end

      @zip_code_plans[zip_code] << rate_area
    end
    @zip_code_plans
  end
end
