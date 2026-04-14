# Machine Learning 1 - Week 12
# Topic: Correlation Analysis
# Original source: ml_12-2.R

heights <- c(160, 162, 155, 180, 170, 175, 165, 171, 177, 172)
weights <- c(55, 60, 53, 72, 70, 73, 62, 64, 69, 65)

library(psych)

result_pearson = corr.test(heights, weights, method = "pearson")
result_pearson$p
result_pearson$r

s_eval <- c(3, 4, 2, 5, 1, 4, 3, 2, 5, 3)
e_eval <- c(2, 5, 2, 4, 1, 4, 3, 2, 5, 3)

result_pearson = corr.test(s_eval, e_eval, method = "spearman")
result_pearson$p
result_pearson$r

data <- read.csv("/Users/igyeongmun/Desktop/programming/ml_class/1/spearman/pearson.csv", stringsAsFactors = TRUE)
data2 <- read.csv("/Users/igyeongmun/Desktop/programming/ml_class/1/spearman/spearman.csv", stringsAsFactors = TRUE)

indep_vars <- data[, c("수면시간", "휴대폰사용시간", "카페인섭취량", "운동시간")]
target_var <- data[, "집중력점수", drop = FALSE]

result_pearson = corr.test(indep_vars, target_var, method = "spearman")
result_pearson$p
result_pearson$r

indep_vars2 <- data2[, c("스트레스수준", "자기효능감수준", "학교만족도", "가족지원수준", "소속감수준")]
target_var2 <- data2[, "집중력등급", drop = FALSE]

result_pearson2 = corr.test(indep_vars2, target_var2, method = "spearman")
result_pearson2$p
result_pearson2$r
