# Machine Learning 1 - Week 05
# Topic: t-test
# Original source: ml_5-2.R

pd <- read.csv("/Users/igyeongmun/Desktop/programming/R/student-mat.csv")

age_one <- pd$age
absences_one <- pd$absences

t_test_result <- t.test(age_one, absences_one, alternative = "two.sided")
t_test_result <- t.test(age_one, absences_one, alternative = "less")
t_test_result <- t.test(age_one, absences_one, alternative = "greater")
