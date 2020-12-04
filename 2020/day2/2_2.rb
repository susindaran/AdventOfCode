def is_valid_password(input)
  valids = input.filter do |line|
    policy, password = line.split(': ')

    limits, policy_char = policy.split(' ')
    left, right = limits.split('-').map(&:to_i)
    (password[left - 1] == policy_char) ^ (password[right - 1] == policy_char)
  end
  puts valids
  valids.size
end

# read input
filename = File.basename(__FILE__).split('.')[0]
file = File.open("#{filename}.input")
input = file.readlines.map(&:chomp)
puts is_valid_password(input)
