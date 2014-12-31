require './rosalind'

# Completing a Tree
# http://rosalind.info/problems/tree/

input = <<-EOF
10
1 2
2 8
4 10
5 9
6 10
7 9
EOF

# 与えられるグラフはcycleが含まれないと問題文にあるし,
# minimum本数を考えるだけなのでcycleの回避は気にする必要ない

# # しばらく悩んだ考慮漏れを再現する最小ケース
# minimal_missing_case = <<-EOF
# 4
# 1 2
# 3 4
# 2 4
# EOF
# input = minimal_missing_case

input = data
n = input.lines[0].chomp.to_i
edges = input.lines.drop(1).map{|line| line.chomp.split.map(&:to_i) }

puts "edges.count: #{edges.count}"

sets = []; used = []
edges.each.with_index do |edge, self_index|

  used = used.concat(edge).uniq

  index0 = sets.index{|set| set.include?(edge[0]) }
  index1 = sets.index{|set| set.include?(edge[1]) }

  # puts "===== edge: #{edge} ====="
  # puts "sets[index0]: #{sets[index0]}" if index0
  # puts "sets[index1]: #{sets[index1]}" if index1

  if index0.nil? && index1.nil?
    # どちらにもない場合は新規登録
    sets << edge
  elsif index0 && index1
    # 既存のset2個を繋ぐedgeの場合, 片方にmerge
    # puts "sets.count: #{sets.count}"
    sets[index0] = sets[index0] + sets[index1]
    sets.delete_at(index1)
    # puts "sets.count: #{sets.count}"
  elsif index0 && index1.nil?
    sets[index0] = sets[index0] + edge
  elsif index0.nil? && index1
    sets[index1] = sets[index1] + edge
  end
end

unused = (1..n).to_a - used

# 確認用にdot形式に吐き出す
# puts "graph sample {"
# edges.each do |edge|
#   puts "#{edge[0]} -- #{edge[1]};"
# end
# puts "}"

puts "sets.count:   #{sets.count}"
puts "unused.count: #{unused.count}"
puts unused.count + sets.count - 1
