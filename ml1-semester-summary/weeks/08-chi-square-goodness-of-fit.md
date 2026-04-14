# 8주차 카이제곱 적합도 검정

## 이번 주 핵심

이 주차에서는 범주형 데이터가 기대한 분포와 얼마나 다른지 검정하는 카이제곱 적합도 검정을 배웠습니다. 관측된 빈도가 단순한 우연의 차이인지, 아니면 통계적으로 의미 있는 차이인지 판단하는 방법을 익힌 주차였습니다.

## 코드 설명

첫 번째 예제는 사탕 색 분포를 이용해 기대값과 실제 관측값을 비교하고, 표준화 잔차를 통해 어떤 색에서 차이가 크게 났는지 확인하는 코드입니다. 두 번째 예제는 혈액형 분포 데이터에 같은 방식을 적용한 것으로, 실제 데이터에서도 적합도 검정을 어떻게 사용하는지 볼 수 있습니다.

## 원본 R 파일

- [`R/ml_8-1.R`](../../R/ml_8-1.R)

## 코드

```r
#카이제곱 통계량 : 적합도 검정
#데이터1 : 사탕 색상 분포
candy_data <- data.frame(
  Color = c("Red", "Blue", "Green"), Observed = c(30, 50, 20))
total_candies <- sum(candy_data$Observed)
expected <- rep(total_candies/3, 3)
# 카이제곱 검정 : 관찰값과 기대값이 얼마나 다른지 통계적으로 검증
test_result <- chisq.test(candy_data$Observed, p = expected / sum(expected))
# x-squared : 카이제곱 통계량(클수록 차이가 큼) df : 자유도, p-value : 유의 확률
print(test_result)

# (표준화) 잔차 계산 : 각 색깔별로 관찰값이 기대값에서 얼마나 벗어났는지 측정
#귀무가설 : 하나의 주머니에 세가지 맛의 사탕의 분포는 차이가 없다(일정하다)
#대립가설 : 하나의 주머니에 세가지 맛의 사탕의 분포는 차이가 있다(일정하지 않다)
# p-value < 0.05 : 귀무가설 기각/ p-value >= 0.05 : 귀무가설 채택
std_residuals <- (candy_data$Observed - expected) / sqrt(expected)

#p-value가 0.05보다 작으니 차이가 있다(하나라도 차이가있으면 차이가 있다)
# 각 셀의 p-value 계산 ( 사후검정)

#표준화 잔차를 제곱함
chi_square_values <- std_residuals^2
# 각 색깔별  p-value를 계산함
p_values <- 1 - pchisq(chi_square_values, df = 2) #df = 자유도

#계산한걸 원래 데이터에 새로운 열로 추가
candy_data$Residuals <- std_residuals
candy_data$Chi_square <- chi_square_values
candy_data$p_value <- p_values
print(candy_data)
# 귀무가설이 차이가 있다
# 레드, 그린은 p-value가 0.05보다 커서 유의하지 않음(기댓값과 유의한 차이 없음)
# 블루는 p-value가 0.05보다 작아서 유의함(기댓값보다 유의하게 많음)

#데이터2 : 혈액형 분포도 
data <- read.csv("/Users/igyeongmun/Desktop/programming/ml_class/1/healthcare_dataset.csv")
observed <- table(data$Blood.Type)
expected <- rep(sum(observed) / length(observed), length(observed))
test_result <- chisq.test(x = observed, p = expected / sum(expected))
# 5. 결과 출력
print(test_result)
# p-value가 0.05보다 커서 귀무가설 채택, 이 집단은 분포의 차이가 없다
```
