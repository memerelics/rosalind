# 死なないバージョンのウサギFibonacci
# http://rosalind.info/problems/fib/

def rabbits(n, k)
  if n <= 2
    1
  else
    # 2ヶ月前の大人が成長してk対の仔ウサギを産む
    rabbits(n-1, k) + (rabbits(n-2, k) * k)
  end
end

# p open("/Users/hash/Downloads/rosalind_fib.txt").read
# # => 33 3
p (1..33).map{|i| rabbits(i, 3) }

