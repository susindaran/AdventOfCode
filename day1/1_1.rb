SUM_TOTAL = 2020
def find_sum_pair(nums)
  map = {}
  nums.each do |num|
    return num * (SUM_TOTAL - num) if map[SUM_TOTAL - num]

    map[num] = true
  end

  0
end

# read input
filename = File.basename(__FILE__).split('.')[0]
file = File.open("#{filename}.input")
file_data = file.readlines.map { |line| line.chomp.to_i }
puts find_sum_pair(file_data)
