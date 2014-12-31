require './rosalind'

# Counting Subsets
# http://rosalind.info/problems/sset/

n = 834
# 1..nの整数それぞれの場所にビット立てると考えれば2^nが組み合わせ数に等しい
p 2 ** n % 1_000_000
