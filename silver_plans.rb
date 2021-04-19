class SilverPlans
  def initialize(plans:)
    @plans = plans
    @silver_plans = {}
  end

  def to_h
    @plans.each do |plan|
      metal_level = plan["metal_level"]
      rate_area = plan["rate_area"]

      unless @silver_plans[rate_area]
        @silver_plans[rate_area] = []
      end

      if metal_level == "Silver"
        # save rates as floats for sorting later
        @silver_plans[rate_area] << plan["rate"].to_f
      end
    end
    @silver_plans
  end
end
