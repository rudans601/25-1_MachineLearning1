# 4주차 데이터 시각화

## 이번 주 핵심

이 주차에서는 데이터를 숫자로만 보지 않고 그래프로 해석하는 연습을 했습니다. 어떤 그래프가 어떤 상황에 적합한지 직접 그려 보면서, 추세 확인, 집단 비교, 분포 파악 같은 시각화 목적을 구분하는 감각을 익혔습니다.

## 코드 설명

아래 코드는 선그래프, 산점도, 박스플롯, 막대그래프, 히스토그램, 밀도곡선까지 한 번에 연습한 내용입니다. 시간에 따른 변화는 선그래프로, 두 변수의 관계는 산점도로, 집단 분포 비교는 박스플롯으로, 빈도와 분포 형태는 히스토그램으로 표현하는 흐름을 확인할 수 있습니다.

## 원본 R 파일

- [`R/ml_4-1.R`](../../R/ml_4-1.R)

## 코드

```r
# 그래프
time <- seq(1,24)
temperature <- c(22, 21, 20, 19, 18, 18, 19, 20, 22, 24, 26, 28, 29, 28, 27, 25, 24, 23, 22, 22, 21, 21, 20, 19)
data <- data.frame(time = time, temp = temperature)
ggplot(data, aes(x=time, y=temp)) + geom_line() + labs(title="시간에 따른 온도 변화") + xlab("시간") + ylab("온도")

df <- data.frame( x = c(1, 2, 3, 4, 5), y = c(6, 8, 5, 9, 7))
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
  xlab("X") +
  ylab("Y")


# 박스 플롯
df <- data.frame(
  group = c(rep("Group 1", 60), rep("Group 2", 60)),
  values = c(rnorm(60, mean = 0, sd = 1), rnorm(60, mean = 2, sd = 1)))

ggplot(df, aes(x = group, y = values)) +
  geom_boxplot(fill = c("lightblue","lightgreen"), outlier.color = "red") +
  labs(title = "Boxplot Example") + xlab("Group") + ylab("Values")

# 박플롯 수정본
df <- data.frame(values = c(5, 7, 10, 12, 14, 18, 20, 22, 25, 27, 30))
ggplot(df, aes(x = values)) +
  geom_boxplot( fill = "steelblue", color = "white") +
  labs(title = "Histogram of Values") +
  xlab("Values") +
  ylab("Frequency")

# 막대 그래프
city <- c("Seoul", "Busan", "Daegu", "Seoul", "Busan", "Daegu", "Ulsan")
pm25 <- c(18, 21, 21, 17, 8, 11, 25)

df <- data.frame(city = city, pm25 = pm25)

ggplot(df, aes(x = city, y = pm25, fill = city)) +
  geom_bar(stat = "identity") +
  labs(title = "지역별 초미세먼지 농도") +
  xlab("City") +
  ylab("농도")

# 막대그래프 2번째
city <- c("Seoul", "Busan", "Daegu", "Seoul", "Busan", "Daegu", "Ulsan")
vari <- c("오전", "오후","오전","오후","오전","오후","오후")
pm25 <- c(18, 21, 21, 17, 8, 11, 25)
df <- data.frame(city = city, pm25 = pm25, vari=vari)

ggplot(df, aes(x = city, y = pm25, fill = vari)) +
  geom_bar(stat = "identity") +
  labs(title = "지역별 초미세먼지 농도") +
  xlab("City") +
  ylab("농도")

# 히스토그램
df <- data.frame(values = c(5, 7, 10, 12, 14, 18, 20, 22, 25, 27, 30))

ggplot(df, aes(x = values)) +
  geom_histogram(aes(y = ..density..), binwidth = 5, fill = "steelblue", color = "white") +
  labs(title = "Histogram") +
  xlab("Values") +
  ylab("Density")

#히스토그램에 밀도곡선 추가
df <- data.frame(values = c(5, 7, 10, 12, 14, 18, 10, 22, 25, 27, 30))
ggplot(df, aes(x = values)) +
  geom_histogram(aes(y = ..density..), binwidth = 5, fill = "steelblue", color = "white") +
  geom_density(alpha = 0.3, fill = "red") + # 밀도 곡선 추가
  labs(title = "Histogram with Density Plot") +
  xlab("Values") +
  ylab("Density")

# 파이차트는 이해만 하고 넘어가기
# 히트맵도 이해만 하고 넘어가기

# 기초통계 예제1
z<- (157 - 160) / sqrt(49/10)

z<- (20 - 15) / sqrt(100/25)
```
