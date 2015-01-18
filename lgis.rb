require './rosalind'

# Longest Increasing Subsequence
# http://rosalind.info/problems/lgis/

# Longest increasing subsequence - Wikipedia, the free encyclopedia
# http://en.wikipedia.org/wiki/Longest_increasing_subsequence

# X = [0, 8, 4, 12, 2, 10, 6, 14, 1, 9, 5, 13, 3, 11, 7, 15]
# N = X.size

input = <<-EOF
16
0 8 4 12 2 10 6 14 1 9 5 13 3 11 7 15
EOF

# input = <<-EOF
# 5
# 5 1 4 2 3
# EOF

@debug = true

n = input.lines[0].chomp.to_i
x = input.lines[1].chomp.split.map(&:to_i)

def lis(n, x)
  p = Array.new(n)
  m = Array.new(n + 1)

  longest = 0
  0.upto(n-1) do |i|
    pu "\n\n=========== i=#{i} ==========="
    pu "x[i] : #{x.map.with_index{|o, j| i == j ? o.to_s : o}}"
    pu "  ----- each begin -----"
    pu "p: #{p}"
    pu "m: #{m}"
    pu "longest: #{longest}"

    lo = 1
    hi = longest

    pu "[lo, hi] = #{[lo, hi]}"

    # Binary search for the largest positive j ≤ L
    # such that X[M[j]] < X[i]
    pu "\n    --- while start ---" if flag = lo <= hi
    while lo <= hi
      mid = ((lo + hi) / 2.0).ceil
      pu "mid: #{mid}"
      pu "m[mid]: #{m[mid]}"
      pu "x[m[mid]]: #{x[m[mid]]}"
      pu "x[i]: #{x[i]}"
      if x[m[mid]] < x[i]
        # pu "lo = mid(= #{mid}) + 1"
        lo = mid + 1
      else
        # pu "hi = mid(= #{mid}) - 1"
        hi = mid - 1
      end
    end
    pu "    --- while end ---\n\n" if flag

    pu "[lo, hi] = #{[lo, hi]}"

    # After searching, lo is 1 greater than the
    # length of the longest prefix of X[i]
    newL = lo

    # The predecessor of X[i] is the last index of
    # the subsequence of length newL-1
    p[i] = m[newL-1] # mにはindexが入ってる.
    m[newL] = i # mは二つの情報を保持する. いまチェックしたindex(i)が入る

    longest = newL if newL > longest

    pu "  ----- each end -----"
    pu "p: #{p}"
    pu "m: #{m}"
    pu "longest: #{longest}"
  end

  s = Array.new(longest)
  k = m[longest] # kの最初だけmから取る. あとの確定版indexはpに移ってるのでloop中で更新していく
  (longest - 1).downto(0) do |i|
    s[i] = x[k]
    k = p[k]
  end

  return s.join(' ')
end

puts lis(n, x)


def lds(n, x)
  p = Array.new(n)
  m = Array.new(n + 1)

  longest = 0
  0.upto(n-1) do |i|
    lo = 1
    hi = longest

    # Binary search for the largest positive j ≤ L
    # such that X[M[j]] < X[i]
    while lo <= hi
      mid = ((lo + hi) / 2.0).ceil
      if x[m[mid]] > x[i]
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
    p[i] = m[newL-1] # mにはindexが入ってる.
    m[newL] = i # mは二つの情報を保持する. いまチェックしたindex(i)が入る

    longest = newL if newL > longest
  end

  s = Array.new(longest)
  k = m[longest] # kの最初だけmから取る. あとの確定版indexはpに移ってるのでloop中で更新していく
  (longest - 1).downto(0) do |i|
    s[i] = x[k]
    k = p[k]
  end

  return s.join(' ')
end

puts lds(n, x)
