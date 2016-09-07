# Generate deck card
values <- c("Ace", 2:10, "Jack", "Queen", "King")
suits <- c("Clubs", "Diamonds", "Hearts", "Spades")
card_deck <- outer(values, suits, paste, sep = " of ")

# Function factory
generator <- function(set) function(n) sample(set, n, replace = T)

# Define generators
card_generator <- generator(card_deck)
coin_generator <- generator(c("Heads", "Tails"))

# Let's play!
card_generator(10)
coin_generator(5)