require 'csv'
require_relative 'zip_code_rate_areas'
require_relative 'silver_plans'
require_relative 'zip_code_benchmarks'

input_args = ARGV

input_zip_file = input_args[0] || 'zips.csv'
input_plan_file = input_args[1] || 'plans.csv'

zip_code_csv = CSV.read(input_zip_file, headers: true)
plan_csv = CSV.read(input_plan_file, headers: true)

# { '12345': ['1', '4', '8'], ... }
zip_code_rate_areas = ZipCodeRateAreas.new(zip_code_csv: zip_code_csv).to_h

# { '1': [250, 900, 300], ... }
silver_plans = SilverPlans.new(plans: plan_csv).to_h

# { '12345': 250, '45678': nil, '43091': 500, ... }
benchmark_plans = ZipCodeBenchmarks.new(zip_code_rate_areas: zip_code_rate_areas, silver_plans: silver_plans).to_h

# now generate export with original csv list and benchmark hash
csv_output = CSV.generate do |csv|
  csv << ["zipcode", "rate"]
  zip_code_csv.each do |zip_code_entry|
    zip_code = zip_code_entry[0]
    csv << [zip_code, benchmark_plans[zip_code]]
  end
end

puts csv_output
