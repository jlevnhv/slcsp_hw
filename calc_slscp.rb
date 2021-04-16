require 'csv'
require_relative 'zip_code_plans'
require_relative 'silver_plans'
require_relative 'zip_code_benchmarks'

input_args = ARGV

input_zip_file = input_args[0] || 'zips.csv'
input_plan_file = input_args[1] || 'plans.csv'

zip_code_csv = CSV.read(input_zip_file, headers: true)
plan_csv = CSV.read(input_plan_file, headers: true)

# { '12345': ['1', '4', '8'], ... }
zip_code_plans = ZipCodePlans.new(zip_code_csv).to_hash

# { '1': [250, 900, 300], ... }
silver_plans = SilverPlans.new(plan_csv).to_hash

# { '12345': 250, '45678': nil, '43091': 500, ... }
benchmark_plans = ZipCodeBenchmarks.new(zip_code_plans, silver_plans).to_hash

csv_output = CSV.generate do |csv|
  csv << ["zipcode", "rate"]
  benchmark_plans.each do |benchmark_plan|
    csv << benchmark_plan
  end
end

puts csv_output
