# Machine Learning 1 - Week 08
# Topic: Chi-square Goodness-of-Fit Test
# Original source: ml_8-1.R

candy_data <- data.frame(
  Color = c("Red", "Blue", "Green"),
  Observed = c(30, 50, 20)
)

total_candies <- sum(candy_data$Observed)
expected <- rep(total_candies / 3, 3)
test_result <- chisq.test(candy_data$Observed, p = expected / sum(expected))
print(test_result)

std_residuals <- (candy_data$Observed - expected) / sqrt(expected)
chi_square_values <- std_residuals^2
p_values <- 1 - pchisq(chi_square_values, df = 2)

candy_data$Residuals <- std_residuals
candy_data$Chi_square <- chi_square_values
candy_data$p_value <- p_values
print(candy_data)

data <- read.csv("/Users/igyeongmun/Desktop/programming/ml_class/1/healthcare_dataset.csv")
observed <- table(data$Blood.Type)
expected <- rep(sum(observed) / length(observed), length(observed))
test_result <- chisq.test(x = observed, p = expected / sum(expected))
print(test_result)
