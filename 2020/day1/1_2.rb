SUM_TOTAL = 2020
def find_sum_triplet(nums)
  map = {}
  nums.each do |num|
    map.each do |k, _|
      map[k] = false
      need = 2020 - (num + k)
      return num * k * need if map[need]

      map[k] = true
    end

    map[num] = true
  end

  0
end

# read input
filename = File.basename(__FILE__).split('.')[0]
file = File.open("#{filename}.input")
nums = file.readlines.map { |line| line.chomp.to_i }
puts find_sum_triplet(nums)
