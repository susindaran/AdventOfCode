def is_valid_password(input)
  input.filter do |line|
    policy, password = line.split(': ')
    char_count = password.chars.each_with_object(Hash.new(0)) do |char, map|
      map[char] += 1
    end

    limits, policy_char = policy.split(' ')
    min, max = limits.split('-').map(&:to_i)
    char_count[policy_char] >= min && char_count[policy_char] <= max
  end.size
end

# read input
filename = File.basename(__FILE__).split('.')[0]
file = File.open("#{filename}.input")
input = file.readlines.map(&:chomp)
puts is_valid_password(input)
