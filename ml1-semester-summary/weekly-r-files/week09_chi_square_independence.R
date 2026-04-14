# Machine Learning 1 - Week 09
# Topic: Chi-square Test of Independence
# Original sources: ml_9-1.R, ml_9-2.R

# ---- Source: ml_9-1.R ----
observed <- matrix(c(25, 15, 20, 30, 35, 25, 15, 20, 15), nrow = 3, byrow = TRUE)
rownames(observed) <- c("Red", "Blue", "Green")
colnames(observed) <- c("Chocolate", "Vanilla", "Strawberry")
chi_squared <- chisq.test(observed)
print(chi_squared)

data <- data.frame(
  Gender = c("Male", "Female", "Male", "Male", "Female", "Female", "Male", "Male", "Female", "Female"),
  Food = c("국밥", "마라탕", "국밥", "피자", "피자", "국밥", "국밥", "마라탕", "피자", "피자")
)
cross_tab <- table(data$Gender, data$Food)
cross_tab
chi_square_test_result <- chisq.test(cross_tab)
print(chi_square_test_result)

d <- read.csv("/Users/igyeongmun/Desktop/programming/ml_class/카이제곱데이터/gender_food.csv")

cross_tab <- table(d$Gender, d$Food)
cross_tab
chi_square_test_result <- chisq.test(cross_tab)
print(chi_square_test_result)

library(chisq.posthoc.test)
results <- chisq.posthoc.test(cross_tab, method = "bonferroni")
results

data <- read.csv("/Users/igyeongmun/Desktop/programming/ml_class/카이제곱데이터/housetasks.csv", row.names = 1)
chi_square_test_result <- chisq.test(data)
print(chi_square_test_result)

results <- chisq.posthoc.test(data, method = "bonferroni")
results

library(corrplot)
corrplot(chi_square_test_result$residuals, is.cor = FALSE)

data <- read.csv("/Users/igyeongmun/Desktop/programming/ml_class/1/healthcare_dataset.csv")
cross_tab <- table(data$Gender, data$Blood.Type)
chi_square_test_result <- chisq.test(cross_tab)
print(chi_square_test_result)

results <- chisq.posthoc.test(cross_tab, method = "bonferroni")
results

# ---- Source: ml_9-2.R ----
d1 <- read.csv("/Users/igyeongmun/Desktop/programming/ml_class/1/카이제곱문제/color.csv")
observed <- table(d1$색깔)

expected <- rep(sum(observed) / length(observed), length(observed))
test_result <- chisq.test(x = observed, p = expected / sum(expected))
print(test_result)

cross_tab <- table(c("빨강", "파랑", "초록", "노랑"), observed)
result <- chisq.posthoc.test(cross_tab, method = "bonferroni")
result

std_residuals <- (observed - expected) / sqrt(expected)
chi_square_values <- std_residuals^2
p_values <- 1 - pchisq(chi_square_values, df = 3)
observed$Residuals <- std_residuals
observed$Chi_square <- chi_square_values
observed$p_value <- p_values
observed

d2 <- read.csv("/Users/igyeongmun/Desktop/programming/ml_class/1/카이제곱문제/incafe.csv")
cross_tab <- table(d2$카페분위기, d2$만족도)
chi_square_test_result <- chisq.test(cross_tab)
print(chi_square_test_result)

results <- chisq.posthoc.test(cross_tab, method = "bonferroni")
results
