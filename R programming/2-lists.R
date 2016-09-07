# matrices
# bind matrices diagonally
bind_diag <- function(m1, m2, fill) {
  m3 <- matrix(fill, 
               nrow = nrow(m1) + nrow(m2), 
               ncol = ncol(m1) + ncol(m2))
  m3[1:nrow(m1), 1:ncol(m1)] <- m1
  m3[nrow(m1) + 1:nrow(m2), ncol(m1) + 1:ncol(m2)] <- m2
  m3
}

m1 <- matrix(1:12, nrow = 3)
m2 <- matrix(10:15, ncol = 3)
bind_diag(m1, m2, fill = NA)
bind_diag(m2, m1, fill = 0)

# lists
# get the longest element
get_longest <- function(l) {
  len <- sapply(l, length)
  list(number = which.max(len), element = l[[which.max(len)]])
}

# generate list with random length and contents
gen_list <- function(n_elements, max_len, seed = 111) {
  set.seed(seed)
  len <- sample(1:max_len, n_elements)
  lapply(1:n_elements, function(i) rnorm(len[i]))
}

l1 <- gen_list(4, 10)
l1
gl1 <- get_longest(l1)
gl1$number
l2 <- gen_list(4, 10, 777)
l2
get_longest(l2)