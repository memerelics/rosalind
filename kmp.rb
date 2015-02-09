require './rosalind'

# Speeding Up Motif Finding
# http://rosalind.info/problems/kmp/

# Knuth–Morris–Pratt algorithm - Wikipedia, the free encyclopedia
# http://en.wikipedia.org/wiki/Knuth%E2%80%93Morris%E2%80%93Pratt_algorithm
# http://www.inf.fh-flensburg.de/lang/algorithmen/pattern/kmpen.htm

# https://github.com/kanwei/algorithms/blob/master/lib/algorithms/search.rb

input = <<-EOF
>Rosalind_87
CAGCATGGTATCACAGCAGAG
EOF

# dna = Fasta.load(input)[0].string
dna = Fasta.load(data)[0].string
# pu dna
# goal = %w(0 0 0 1 2 0 0 0 0 0 0 1 2 1 2 3 4 5 3 0 0).map(&:to_i)

# 自分自身の部分一致情報を保持したマッチテーブル.
# まずこれを作る必要がある (そして本問においてはこの作成のみが課題)
table = [-1, 0] # 初期2項は固定で突っ込む

pos = 2
j = 0

while pos <= dna.length do
  # pu "#{pos}/#{dna.length}" if pos % 1000 == 0
  # pu '-------------------------------------'
  # pu "dna[pos - 1(#{pos - 1})]: #{dna[pos - 1]} vs dna[j(#{j})]: #{dna[j]}"
  # pu "#{dna[pos - 1] == dna[j]}"
  if dna[pos - 1] == dna[j]
    table[pos] = j + 1
    pos += 1
    j = j + 1
  elsif j > 0
      j = table[j]
  else
    table[pos] = 0
    pos += 1
  end
  # pu "table: #{table}"
end

puts table.drop(1).join(' ')
