require './rosalind'

input = '21 7'
input = data
n = input.split[0].to_i
k = input.split[1].to_i

MODULO = 1_000_000

def fact(n)
  return 1 if n == 1
  n * fact(n - 1)
end

def partial_permutation(n, k)
  fact(n) / fact(k)
end

# これで解けるが実際にpermutationを出そうとすると遅い
# p (1..n).to_a.permutation(k).count % MODULO

p (fact(n) / fact(n - k)) % MODULO
