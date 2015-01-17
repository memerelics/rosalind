require './rosalind'

# Longest Increasing Subsequence
# http://rosalind.info/problems/lgis/
# http://en.wikipedia.org/wiki/Longest_increasing_subsequence

# X = [0, 8, 4, 12, 2, 10, 6, 14, 1, 9, 5, 13, 3, 11, 7, 15]
# N = X.size

input = <<-EOF
5
5 1 4 2 3
EOF

n = input.lines[0].chomp.to_i
x = input.lines[1].chomp.split.map(&:to_i)
p = Array.new(n)
m = Array.new(n + 1)

l = 0
0.upto(n-1) do |i|
  lo = 1
  hi = l
  # 最初はlo=1, hi=0なのでwhileに入らない
  # Binary search for the largest positive j ≤ L
  # such that X[M[j]] < X[i]
  while lo <= hi
    mid = ((lo + hi) / 2.0).ceil
    if x[m[mid]] && x[m[mid]] < x[i]
      lo = mid + 1
    else
      hi = mid - 1
    end
  end

  # After searching, lo is 1 greater than the
  # length of the longest prefix of X[i]
  newL = lo

  # The predecessor of X[i] is the last index of
  # the subsequence of length newL-1
  p[i] = m[newL-1]
  m[newL] = i

  l = newL if newL > l
end

s = Array.new(l)
k = m[l]
(l-1).downto(0) do |i|
  s[i] = x[k]
  k = p[k]
end

puts s.join(' ')
