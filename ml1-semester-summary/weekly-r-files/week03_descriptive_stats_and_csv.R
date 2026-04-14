# Machine Learning 1 - Week 03
# Topic: Descriptive Statistics and CSV I/O
# Original sources: ml_3-1.R, ml_3-2.R

# ---- Source: ml_3-1.R ----
data <- c(10, 15, 20, 25, 30, 15, 20, 25, 25, 10)
range_value <- max(data) - min(data)
df <- data.frame(values = c(5, 7, 10, 12, 14, 18, 20, 22, 25, 27, 30))
Q1 <- quantile(data, 0.25)
Q3 <- quantile(data, 0.75)
iqr_value <- Q3 - Q1
Q0 <- quantile(data, 0)
Q4 <- quantile(data, 1)

data <- c(10, 15, 20, 25, 30, 15, 20, 25, 25, 10)
mean_data <- mean(data)
squared_diff <- (data - mean_data)^2
variance <- sum(squared_diff) / length(data)
std_dev <- sqrt(variance)

city <- c("Seoul", "Busan", "Daegu", "Seoul", "Busan", "Daegu", "Ulsan")
pm25 <- c(18, 21, 21, 17, 8, 11, 25)

df <- data.frame(city = city, pm25 = pm25)
write.csv(df, "/Users/igyeongmun/Desktop/programming/R/test.csv", row.names = TRUE)

data <- read.csv("/Users/igyeongmun/Desktop/programming/R/test.csv")

# ---- Source: ml_3-2.R ----
d <- c(100, 200, 300, 400, 200, 200, 100, 400, 250, 230, 70, 80, 90)
dMean <- mean(d)
dSd <- sd(d)
dMid <- median(d)
dQ1 <- quantile(d, 0.25)
dQ3 <- quantile(d, 0.75)

# data <- read.csv("/Users/igyeongmun/Desktop/programming/R/Score.txt")
# write.csv(data, "/Users/igyeongmun/Desktop/programming/R/Score.csv")
