# 9주차 카이제곱 독립성 검정

## 이번 주 핵심

8주차가 하나의 범주형 변수의 분포를 보는 적합도 검정이었다면, 9주차는 두 범주형 변수 사이에 관련성이 있는지 확인하는 독립성 검정이 핵심이었습니다. 단순히 `p-value`만 보는 데서 끝나지 않고, 사후검정과 잔차 해석까지 이어지는 흐름을 처음 제대로 다뤘다는 점이 중요했습니다.

## 코드 설명

`ml_9-1.R`에서는 좋아하는 색과 아이스크림 맛, 성별과 음식 선호, 성별과 집안일처럼 범주형 변수 조합을 여러 번 연습했습니다. `ml_9-2.R`에서는 문제 풀이 형식으로 적합도 검정과 독립성 검정을 다시 적용했고, 어떤 범주에서 차이가 크게 나타났는지 잔차와 사후검정으로 확인하는 연습까지 이어졌습니다.

## 원본 R 파일

- [`R/ml_9-1.R`](../../R/ml_9-1.R)
- [`R/ml_9-2.R`](../../R/ml_9-2.R)

## `ml_9-1.R`

이 파일은 독립성 검정과 Bonferroni 사후검정, 잔차 시각화까지 포함한 주차 핵심 코드입니다.

```r
#카이제곱 통계량 : 적합도 검증(범주형 변수가 3개 이상일때)

# 자유도 구하기 : (행 - 1)(열 - 1)
# 적합도 검정후 사후검증
# 두 변수가 서로 독립일때 사용한다 (독립성검정)

#데이터 1 : 좋아하는 색깔과 선호하는 아이스크림 맛의 관련성
# 귀무가설 : 좋아하는 색깔과 선호하는 아이스크림 맛은 서로 관련성이 없다(독립이다)
# 대립가설 : 좋아하는 색깔과 선호하는 아이스크림 맛은 서로 관련성이 있다(독립이 아니다)
observed <- matrix(c(25, 15, 20, 30, 35, 25, 15, 20, 15), nrow = 3, byrow = TRUE)
rownames(observed) <- c("Red", "Blue", "Green")
colnames(observed) <- c("Chocolate", "Vanilla", "Strawberry")
# 적합도 검증 : 자유도는 범주형 변수가 3개 이상일땐 자동으로 계산해줘서 p를 지정할 필요 없다)
chi_squared <- chisq.test(observed)
print(chi_squared)
#p-value가 0.05보다 크므로 귀무가설 채택, 좋아하는 색과 선호하는 아이스크림 맛은 서로 독립이다

# 데이터 2: 성별과 좋아하는 음식의 관련성
# 귀무가설 : 성별과 좋아하는 음식은 서로 관련성이 없다
# 대립가설 : 성별과 좋아하는 음식은 서로 관련성이 있다
data <- data.frame(Gender = c("Male", "Female", "Male", "Male", "Female","Female", "Male", "Male", "Female", "Female"), Food = c("국밥", "마라탕", "국밥","피자", "피자", "국밥", "국밥", "마라탕", "피자", "피자"))
cross_tab <- table(data$Gender, data$Food)
cross_tab
chi_square_test_result <- chisq.test(cross_tab)
print(chi_square_test_result)
# p-value가 0.05보다 크므로 귀무가설 채택, 성별과 좋아하는 음식은 서로 관련성이 없다

# 데이터 3 : 성별과 좋아하는 음식의 관련성
# 귀무가설 : 성별과 좋아하는 음식은 서로 관련성이 없다
# 대립가설 : 성별과 좋아하는 음식은 서로 관련성이 있다
d<- read.csv("/Users/igyeongmun/Desktop/programming/ml_class/카이제곱데이터/gender_food.csv")

cross_tab <- table(d$Gender, d$Food)
cross_tab
chi_square_test_result <- chisq.test(cross_tab)
print(chi_square_test_result)
#p-value가 0.05보다 작으므로 대립가설 채택, 성별과 좋아하는 음식은 서로 관련성이 있다
#사후검정 : 개별 연관성을 검증

library(chisq.posthoc.test)
# Bonferroni 방법을 사용하는 이유는 범주가 많을수록 유의한 결과가 나올 확률이 높아져서 엄격한 기준 적용
results <- chisq.posthoc.test(cross_tab, method = "bonferroni")
results
#남자 : 국밥(유의함,많이선호), 마라탕(유의하지않음), 피자(유의함,적게 선호)
#여자 : 국밥(유의함,적게선호), 마라탕(유의하지않음), 피자(유의함,많이 선호)
# 6으로 나누면 너무 세세해서 0.05/3 해서 유의수준을 정한다

# 데이터4 : 집안일에 대해서 판단하기
# 귀무가설 : 성별과 집안일은 서로 관련성이 없다
# 대립가설 : 성별과 집안일은 서로 관련성이 있다
data<- read.csv("/Users/igyeongmun/Desktop/programming/ml_class/카이제곱데이터/housetasks.csv", row.names = 1)
chi_square_test_result <- chisq.test(data)

print(chi_square_test_result)
# p-value가 0.05보다 작으므로 대립가설 채택, 성별과 집안일은 서로 관련성이 있다
#사후검정
results <- chisq.posthoc.test(data, method = "bonferroni")
results

#p-value 0.05 이하일때  Residuals 해석 

#시각화
library(corrplot)
corrplot(chi_square_test_result$residuals, is.cor = FALSE)


# 내가 받은 코드로 하기 
data<- read.csv("/Users/igyeongmun/Desktop/programming/ml_class/1/healthcare_dataset.csv")
cross_tab <- table(data$Gender, data$Blood.Type)
# 카이제곱 분석
chi_square_test_result <- chisq.test(cross_tab)
print(chi_square_test_result)

#사후검증
results <- chisq.posthoc.test(cross_tab, method = "bonferroni")
results

#pvalue가 크면 서로 관련성이 없다, pvalue가 기준치보다 작으면 (0.05보다) 관련성이 있다
#사후검정은 관련성이 있을 때 어떤 관련성이 있는지 판단할려고
#사후검정후 pvalue가 기준치보다 다 크므로 결국 사후검정 결과는 혈액형과 성별은 관련이 없다
```

## `ml_9-2.R`

이 파일은 문제 풀이형 데이터에 검정을 다시 적용하면서 해석 연습을 반복한 코드입니다.

```r
#1
d1 <- read.csv("/Users/igyeongmun/Desktop/programming/ml_class/1/카이제곱문제/color.csv")
observed <- table(d1$색깔)

expected <- rep(sum(observed)/ length(observed), length(observed))
test_result <- chisq.test(x = observed, p = expected / sum(expected))

print(test_result)

cross_tab <- table(c("빨강","파랑","초록","노랑"),observed)
#사후검정
result <- chisq.posthoc.test(cross_tab, method = "bonferroni")
result

std_residuals <- (observed - expected) /sqrt(expected)
#각 셀의 p-value 계산
chi_square_values <- std_residuals^2
p_values <- 1 - pchisq(chi_square_values, df= 3)
observed$Residuals <- std_residuals
observed$Chi_square <- chi_square_values
observed$p_value <- p_values
observed

# 카이제곱 통계량이 기준값보다 작으니까 귀무가설 기각 대립가설 채택 -> 4가지 색은일정(적합)하지 않다,분포가 적합하다

#2
  
d2 <- read.csv("/Users/igyeongmun/Desktop/programming/ml_class/1/카이제곱문제/incafe.csv")
cross_tab <- table(d2$카페분위기, d2$만족도)
chi_square_test_result <- chisq.test(cross_tab)
print(chi_square_test_result)
# pvalue가 기준치보다 작으면 (0.05보다) 관련성이 있다

# 사후검증
results <- chisq.posthoc.test(cross_tab, method = "bonferroni")
results
# pvalue가 0.05보다 작은 북적이는, 자연채광, 조용한 옵션은 귀무가설 채택(독립)이고 관련성이 있다(낮음과 높음사이에 명확한 차이존재)
# pvalue가 0.05보다 큰 음악이 있는 옵션은 귀무가설 기각(독립 아님)이고 관련성이 없다(낮음과 높음 사이에 명확한 차이 없음)

# 의영이 코드
data<-read.csv("C:/Users/euing/Desktop/카이제곱문제/color.csv")
observed<-table(data$색깔)
observed
expected<-rep(sum(observed)/length(observed),length(observed))
test_result<-chisq.test(x=observed,p=expected/sum(expected))
print(test_result)
#p값이 0.05보다 작음 고로 분포가 고르지않음
#빨간색,초록색이 너무 많거나 적음
std_residuals <-(observed-expected)/sqrt(expected)

chi_square_values <- std_residuals^2
p_values <- 1-pchisq(chi_square_values,df=3)#df는 자유도

data$Residuals <- std_residuals#잔차가 양수면 관측값이 기대값보다 많이 나왔다
data$Chi_square <- chi_square_values
data$p_value <- p_values

data<-read.csv("C:/Users/euing/Desktop/카이제곱문제/incafe.csv")
cross_tab<-table(data$카페분위기,data$만족도)
cross_tab
chi_square_test_result<-chisq.test(cross_tab)
print(chi_square_test_result)
#p값이 0.05보다 작기때문에 카페분위기와 만족도는 관련이있다
results <- chisq.posthoc.test(cross_tab,method = "bonferroni")
results
#북적이는,자연채광,조용한게 만족도에 영향을 준다.
```
