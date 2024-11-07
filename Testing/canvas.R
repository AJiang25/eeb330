data(iris)

iris[1, ]
iris[, 1]
iris$length.width <- iris[, "Sepal.Length"] * iris$Sepal.Width
head(iris)

iris[iris$Species == "setosa", ]

iris[iris$Sepal.Width > 4, ]

# The following are all equivalent
iris[, 5]
iris[, "Species"]
iris$Species
iris[[5]]

colnames(iris)

x = 90

if (x >= 90) {
    print(x)
}
else {
   print("x is less than 90")
}

## vectorized if
x <- 1:10
x %% 2
ifelse(x %% 2 == 0, "even", "odd")

# structure of a useful loop
n <- 10
results <-  numeric(n)
            list(n)
            character(n)
for (i in 1:n) {
    results[i] <- work_function(vector[i])
}

# example
grade <- function(x) {
  if (x > 90) {
    "A"
  } else if (x > 80) {
    "B"
  } else if (x > 70) {
    "C"
  } else {
    "F"
  }
}
grade(74); grade(98)

n <- 5
grades <- floor(runif(n, 70, 100))
grades

letter_grades = character(n)
for(g in 1:n) {
    letter_grades[g] <- grade(grades[g])
}
letter_grades

# for loop correct pattern
for (i in seq_along(means)) {
  out[[i]] <- rnorm(10, means[[i]])
}
