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

N = input.lines[0].chomp.to_i
X = input.lines[1].chomp.split.map(&:to_i)
P = Array.new(N)
M = Array.new(N + 1)

L = 0
0.upto(N-1) do |i|
  lo = 1
  hi = L
  # 最初はlo=1, hi=0なのでwhileに入らない
  # Binary search for the largest positive j ≤ L
  # such that X[M[j]] < X[i]
  while lo <= hi
    mid = ((lo + hi) / 2.0).ceil
    if X[M[mid]] && X[M[mid]] < X[i]
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
  P[i] = M[newL-1]
  M[newL] = i

  L = newL if newL > L
end

S = Array.new(L)
k = M[L]
(L-1).downto(0) do |i|
  S[i] = X[k]
  k = P[k]
end

puts S.join(' ')
