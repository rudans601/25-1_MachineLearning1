# 3주차 기술통계와 CSV

## 이번 주 핵심

이 주차에서는 데이터를 요약해서 이해하는 기술통계량을 다뤘습니다. 평균, 사분위수, 범위, 분산, 표준편차 같은 값을 직접 계산해 보면서 데이터의 중심과 퍼짐을 숫자로 읽는 방법을 익혔습니다.

## 코드 설명

`ml_3-1.R`에서는 범위, 사분위수, IQR, 분산, 표준편차를 계산하고 `data.frame`을 만든 뒤 `csv` 파일로 저장하고 다시 불러오는 흐름까지 연습했습니다. `ml_3-2.R`에서는 다른 예제 데이터를 이용해 평균, 중앙값, 사분위수 계산을 반복해 보면서 기술통계 개념을 더 익혔습니다.

## 원본 R 파일

- [`R/ml_3-1.R`](../../R/ml_3-1.R)
- [`R/ml_3-2.R`](../../R/ml_3-2.R)

## `ml_3-1.R`

이 파일은 기초 통계량 계산과 CSV 저장/불러오기 흐름을 함께 담고 있습니다.

```r
data <- c(10,15,20,25,30,15,20,25,25,10)
range_value <- max(data) - min(data)
df <- data.frame(values = c(5,7,10,12,14,18,20,22,25,27,30))
Q1 <- quantile(data,0.25)
Q3 <- quantile(data,0.75)
iqr_value <- Q3 - Q1
Q0 <- quantile(data,0)
Q4 <- quantile(data,1)

data <- c(10,15,20,25,30,15,20,25,25,10)
mean_data <- mean(data)
squared_diff <- (data - mean_data)^2
variance <- sum(squared_diff) / length(data)
std_dev <- sqrt(variance)


city <- c("Seoul", "Busan", "Daegu", "Seoul", "Busan", "Daegu", "Ulsan")
pm25 <- c(18,21,21,17,8,11,25)

df <- data.frame(city = city, pm25 = pm25)
write.csv(df, "/Users/igyeongmun/Desktop/programming/R/test.csv",row.names = TRUE)

data <- read.csv("/Users/igyeongmun/Desktop/programming/R/test.csv")
```

## `ml_3-2.R`

이 파일은 새로운 벡터 데이터를 기준으로 평균, 표준편차, 중앙값, 사분위수를 다시 계산한 연습 코드입니다.

```r
#1

d <- c(100,200,300,400,200,200,100,400,250,230,70,80,90)
dMean <- mean(d)
dSd <- sd(d)
dMid <- median(d)
dQ1 <- quantile(d,0.25)
dQ3 <- quantile(d,0.75)


#2
#data <- read.csv("/Users/igyeongmun/Desktop/programming/R/Score.txt")
#write.csv(data, "/Users/igyeongmun/Desktop/programming/R/Score.csv")
```
