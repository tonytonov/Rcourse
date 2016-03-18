# Random walk with absorption
simulate_walk <- function(lower = -10, upper = 10, n_max = 200, p = 1e-3) {
  current_position <- (lower + upper) / 2
  for (i in 1:n_max) {
    is_absorbed <- rbinom(1, 1, p)
    if (is_absorbed) return(list(status = "Absorbed", 
                                 position = current_position, 
                                 steps = i))
    current_position <- current_position + rnorm(1)
    if (current_position < lower) return(list(status = "Left breach", 
                                              position = current_position, 
                                              steps = i))
    if (current_position > upper) return(list(status = "Right breach", 
                                              position = current_position, 
                                              steps = i))
  }
  return(list(status = "Max steps reached", 
              position = current_position,
              steps = n_max))
}

# Simulate results
result <- replicate(1000, simulate_walk(), simplify = FALSE)
result <- data.frame(
  status = sapply(result, function(x) x$status),
  position = sapply(result, function(x) x$position),
  steps = sapply(result, function(x) x$steps)
)

# Inspect results
tapply(result$position, result$status, length)
tapply(result$steps, result$status, mean)
