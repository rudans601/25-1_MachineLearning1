# Machine Learning 1 - Week 04
# Topic: Data Visualization with ggplot2
# Original source: ml_4-1.R

time <- seq(1, 24)
temperature <- c(22, 21, 20, 19, 18, 18, 19, 20, 22, 24, 26, 28, 29, 28, 27, 25, 24, 23, 22, 22, 21, 21, 20, 19)
data <- data.frame(time = time, temp = temperature)
ggplot(data, aes(x = time, y = temp)) + geom_line() + labs(title = "시간에 따른 온도 변화") + xlab("시간") + ylab("온도")

df <- data.frame(x = c(1, 2, 3, 4, 5), y = c(6, 8, 5, 9, 7))
ggplot(df, aes(x = x, y = y)) + geom_point(color = "blue", size = 3) + labs(title = "Scatter Plot") + xlab("X") + ylab("Y")

ggplot(df, aes(x = x, y = y)) +
  geom_point(color = "blue", size = 3) +
  geom_line(aes(color = "Connected Points"), size = 0.5) +
  labs(title = "Scatter Plot") +
  xlab("X") + ylab("Y")

df <- data.frame(x = c(1, 2, 3, 4, 5), y = c(6, 8, 5, 9, 7))
df2 <- data.frame(x = c(5, 6, 7, 8, 9), y = c(18, 12, 16, 77, 63))

ggplot() +
  geom_point(data = df, aes(x = x, y = y), color = "blue", size = 3) +
  geom_line(data = df, aes(x = x, y = y, color = "Connected Points"), size = 0.5) +
  geom_point(data = df2, aes(x = x, y = y), color = "blue", size = 3) +
  geom_line(data = df2, aes(x = x, y = y, color = "Connected Points 2"), size = 0.5) +
  labs(title = "Scatter Plot") +
  xlab("X") + ylab("Y")

df <- data.frame(
  group = c(rep("Group 1", 60), rep("Group 2", 60)),
  values = c(rnorm(60, mean = 0, sd = 1), rnorm(60, mean = 2, sd = 1))
)

ggplot(df, aes(x = group, y = values)) +
  geom_boxplot(fill = c("lightblue", "lightgreen"), outlier.color = "red") +
  labs(title = "Boxplot Example") + xlab("Group") + ylab("Values")

df <- data.frame(values = c(5, 7, 10, 12, 14, 18, 20, 22, 25, 27, 30))
ggplot(df, aes(x = values)) +
  geom_boxplot(fill = "steelblue", color = "white") +
  labs(title = "Histogram of Values") +
  xlab("Values") +
  ylab("Frequency")

city <- c("Seoul", "Busan", "Daegu", "Seoul", "Busan", "Daegu", "Ulsan")
pm25 <- c(18, 21, 21, 17, 8, 11, 25)

df <- data.frame(city = city, pm25 = pm25)

ggplot(df, aes(x = city, y = pm25, fill = city)) +
  geom_bar(stat = "identity") +
  labs(title = "지역별 초미세먼지 농도") +
  xlab("City") +
  ylab("농도")

city <- c("Seoul", "Busan", "Daegu", "Seoul", "Busan", "Daegu", "Ulsan")
vari <- c("오전", "오후", "오전", "오후", "오전", "오후", "오후")
pm25 <- c(18, 21, 21, 17, 8, 11, 25)
df <- data.frame(city = city, pm25 = pm25, vari = vari)

ggplot(df, aes(x = city, y = pm25, fill = vari)) +
  geom_bar(stat = "identity") +
  labs(title = "지역별 초미세먼지 농도") +
  xlab("City") +
  ylab("농도")

df <- data.frame(values = c(5, 7, 10, 12, 14, 18, 20, 22, 25, 27, 30))

ggplot(df, aes(x = values)) +
  geom_histogram(aes(y = ..density..), binwidth = 5, fill = "steelblue", color = "white") +
  labs(title = "Histogram") +
  xlab("Values") +
  ylab("Density")

df <- data.frame(values = c(5, 7, 10, 12, 14, 18, 10, 22, 25, 27, 30))
ggplot(df, aes(x = values)) +
  geom_histogram(aes(y = ..density..), binwidth = 5, fill = "steelblue", color = "white") +
  geom_density(alpha = 0.3, fill = "red") +
  labs(title = "Histogram with Density Plot") +
  xlab("Values") +
  ylab("Density")

z <- (157 - 160) / sqrt(49 / 10)
z <- (20 - 15) / sqrt(100 / 25)
