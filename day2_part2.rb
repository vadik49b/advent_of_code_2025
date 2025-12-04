id_ranges = File.read('day2_input.txt').strip.split(',')

invalid_ids_sum = 0

id_ranges.each do |id_range|
  first_id, last_id = id_range.split('-').map(&:to_i)

  (first_id..last_id).map do |id|
    is_invalid = (1..id.to_s.length / 2).any? do |i|
      id.to_s.match?(/^(#{id.to_s[0, i]}){2,}$/)
    end

    invalid_ids_sum += id if is_invalid
  end
end

puts "Invalid ids sum: #{invalid_ids_sum}"


# Extra trick: double the string, remove first and last character, check if original string is still there.
#
# The trick works because when you shift the doubled string by removing the first and last character,
# you're essentially "sliding" the original string across itself.
#
# If it has any repeating period, it will overlap with itself at some point in that shifted middle section.
#
# Let me show you with examples of different pattern lengths:
#
# **Pattern length 1** (single character repeating):
# - `s = "aaaa"` → `s+s = "aaaaaaaa"` → `[1:-1] = "aaaaaa"` → `"aaaa"` in `"aaaaaa"`? ✓
#
# **Pattern length 2** (pair repeating):
# - `s = "abab"` → `s+s = "abababab"` → `[1:-1] = "bababa"` → `"abab"` in `"bababa"`? ✓
#
# **Pattern length 3** (triplet repeating):
# - `s = "abcabc"` → `s+s = "abcabcabcabc"` → `[1:-1] = "bcabcabcab"` → `"abcabc"` in `"bcabcabcab"`? ✓
#
# **Pattern length 4** (quartet repeating):
# - `s = "abcdabcd"` → `s+s = "abcdabcdabcdabcd"` → `[1:-1] = "bcdabcdabcdabc"` → `"abcdabcd"` in `"bcdabcdabcdabc"`? ✓
#
# **Non-repeating** (no pattern):
# - `s = "abcdef"` → `s+s = "abcdefabcdef"` → `[1:-1] = "bcdefabcde"` → `"abcdef"` in `"bcdefabcde"`? ✗
