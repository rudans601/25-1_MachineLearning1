# Machine Learning 1 - Week 10
# Topic: Chi-square Applications and F-test
# Original sources: ml_10-1.R, ml_10-2.R

# ---- Source: ml_10-1.R ----
data <- read.csv("/Users/igyeongmun/Desktop/programming/ml_class/1/Smartphone/smartphone_sleep1.csv")
cross_tab <- table(data$스마트폰사용목적, data$수면만족도)
chi_square_test_result <- chisq.test(cross_tab)
print(chi_square_test_result)

data <- read.csv("/Users/igyeongmun/Desktop/programming/ml_class/1/Smartphone/smartphone_sleep2.csv")
cross_tab <- table(data$스마트폰사용목적, data$수면만족도)
chi_square_test_result <- chisq.test(cross_tab)
print(chi_square_test_result)

results <- chisq.posthoc.test(cross_tab, method = "bonferroni")
results

set_a <- c(10.1, 10.2, 10.3, 10.0, 10.1, 10.2, 10.3, 10.0, 10.1, 10.2)
set_b <- c(9.8, 10.5, 10.2, 9.7, 10.4, 10.3, 9.6, 10.6, 9.9, 10.7)

result <- var.test(set_a, set_b)
print(result)

var.test(set_a, set_b, alternative = "less")
var.test(set_a, set_b, alternative = "greater")

df = read.csv("/Users/igyeongmun/Desktop/programming/ml_class/1/ANOVA/Machine_set.csv")
set_a <- subset(df, machine == "A")$value
set_b <- subset(df, machine == "B")$value

result <- var.test(set_a, set_b)
print(result)

var.test(set_a, set_b, alternative = "less")
var.test(set_a, set_b, alternative = "greater")

set_a <- c(10.2, 10.3, 10.1, 10.0, 10.3, 10.2, 10.1, 10.2, 10.1, 10.3)
set_b <- c(10.1, 10.0, 10.2, 10.3, 10.0, 10.1, 10.2, 10.1, 10.2, 10.1)
set_c <- c(10.2, 10.3, 10.3, 10.3, 10.4, 10.3, 10.2, 10.4, 10.3, 10.4)

var.test(set_b, set_a, alternative = "less")
var.test(set_c, set_a, alternative = "less")

# ---- Source: ml_10-2.R ----
data <- read.csv("/Users/igyeongmun/Desktop/programming/ml_class/1/chocolate_bars.csv")

set_a <- subset(data, manufacturer == "A. Morin")$cocoa_percent
set_b <- subset(data, manufacturer == "Acalli")$cocoa_percent

result <- var.test(set_a, set_b)
print(result)
