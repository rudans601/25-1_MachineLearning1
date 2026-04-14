# 10주차 카이제곱 응용과 F-test

## 이번 주 핵심

이 주차는 앞에서 배운 카이제곱 검정을 실제 데이터에 다시 적용해 보고, 동시에 분산 비교라는 새로운 주제로 넘어가는 연결 구간이었습니다. 특히 평균 비교 전에 분산이 비슷한지 확인해야 한다는 흐름을 이해하는 데 중요한 주차였습니다.

## 코드 설명

`ml_10-1.R`에서는 스마트폰 사용 목적과 수면 만족도의 관련성을 카이제곱 검정으로 분석하고, 이어서 두 집단의 분산 차이를 `F-test`로 확인하는 코드를 작성했습니다. `ml_10-2.R`에서는 초콜릿 제조사의 코코아 함량 데이터를 이용해 실제 분산 비교를 연습했고, 양측검정과 단측검정 해석 차이도 함께 확인했습니다.

## 원본 R 파일

- [`R/ml_10-1.R`](../../R/ml_10-1.R)
- [`R/ml_10-2.R`](../../R/ml_10-2.R)

## `ml_10-1.R`

이 파일은 범주형 변수의 관련성 분석과 분산 동질성 검정을 한 주 안에서 함께 다룬 코드입니다.

```r
#1
data <- read.csv("/Users/igyeongmun/Desktop/programming/ml_class/1/Smartphone/smartphone_sleep1.csv")
cross_tab <- table(data$스마트폰사용목적, data$수면만족도)
chi_square_test_result <- chisq.test(cross_tab)
print(chi_square_test_result)

#p-value가 0.05보다 크면 

#2 
data <- read.csv("/Users/igyeongmun/Desktop/programming/ml_class/1/Smartphone/smartphone_sleep2.csv")
cross_tab <- table(data$스마트폰사용목적, data$수면만족도)
chi_square_test_result <- chisq.test(cross_tab)
print(chi_square_test_result)

#p-value가 0.05보다 작으므로 사후검정 실시 귀무가설 기각, 대립가설 채택
results <- chisq.posthoc.test(cross_tab, method = "bonferroni")
results

#p-value가 0.05보다 큰게 
#p-value가 작고 잔차가 큰걸로 판단하기
# 완전 관련이 없는 변수를 제거 하고 관련 있는 변수들만 가지고 분석
# 연속형 변수 어떡함?

#------ F-test ---------- 두 집단의 분산 차이 검정 하는 방법
# 데이터 1 : a,b집단
set_a <- c(10.1, 10.2, 10.3, 10.0, 10.1, 10.2, 10.3, 10.0, 10.1, 10.2)
set_b <- c(9.8, 10.5, 10.2, 9.7, 10.4, 10.3, 9.6, 10.6, 9.9, 10.7) 


# 귀무 가설 : 두 집단은 분산의 차이가 존재하지 않는다
# 대립 가설 : 두 집단은 분산의 차이가 존재한다

#F-test: 분산 동질성 검정(양측)
result <- var.test(set_a,set_b)
print(result)
# p-value가 0.05보다 작아서 귀무가설 기각, 대립가설 채택

#F-test: 분산 동질성 검정(단측) : 귀무가설 기각시 a집단은 b집단보다 분산이 작다
var.test(set_a,set_b,alternative= "less")
#p-value가 0.05보다 작아서 a집단은 b집단보다 분산이 작다

#F-test: 분산 동질성 검정(단측) : 귀무가설 기각시 a집단은 b집단보다 분산이 크다
var.test(set_a,set_b, alternative="greater")

# 데이터 2
df = read.csv("/Users/igyeongmun/Desktop/programming/ml_class/1/ANOVA/Machine_set.csv")
set_a <- subset(df, machine == "A")$value
set_b <- subset(df, machine == "B")$value

# F-test: 분산 동질성 검정 (양측)
result <- var.test(set_a, set_b)
print(result)

# F-test: 분산 동질성 검정 (단측) : 귀무가설 기각 시 a집단은 b집단보다 분산이 작다.
var.test(set_a, set_b, alternative = "less")
# p-value가 0.05보다 크므로 이건 아님

# F-test: 분산 동질성 검정 (단측) : 귀무가설 기각 시 a집단은 b집단보다 분산이 크다.
var.test(set_a, set_b, alternative = "greater")
# p-value가 0.05보다 작으므로 이거임
# 실제로는 이렇게 사용 잘 안한다


# 집단이 세개 이상인데 각각 분산 차이를 알아야할때 f-test를 쓴다면
# 하나의 기준값을 정하고 비교대상을 비교 a가 기준이면 비교대상은 b와 c
set_a <- c(10.2, 10.3, 10.1, 10.0, 10.3, 10.2, 10.1, 10.2, 10.1, 10.3) #기준이 되는 분산 값
set_b <- c(10.1, 10.0, 10.2, 10.3, 10.0, 10.1, 10.2, 10.1, 10.2, 10.1)
set_c <- c(10.2, 10.3, 10.3, 10.3, 10.4, 10.3, 10.2, 10.4, 10.3, 10.4)

#a를 기준으로 잡고 b를 비교했을 때
var.test(set_b, set_a, alternative = "less")
# 0.05보다 커서 각각 분산이 차이가 없다 귀무가설 채택

#a를 기준으로 잡고 c를 비교했을 때
var.test(set_c, set_a, alternative = "less")
# 0.05보다 커서 각각 분산이 차이가 없다 귀무가설 채택

# 집단끼리 한번에 분산 비교 할려고 anova 테스트 함
```

## `ml_10-2.R`

이 파일은 초콜릿 제조사 데이터를 이용해 분산 비교를 다시 적용한 응용 코드입니다.

```r
data <- read.csv("/Users/igyeongmun/Desktop/programming/ml_class/1/chocolate_bars.csv")

set_a <- subset(data, manufacturer == "A. Morin")$cocoa_percent
set_b <- subset(data, manufacturer == "Acalli")$cocoa_percent

#F-test: 분산 동질성 검정(양측)
# 귀무가설 : A. Morin공장에서 나오는 초콜릿의 코코아 함량과 Acalli공장에서 코코아 함량의 분산은 각각 차이가 없다
# 대립가설 : A. Morin공장에서 나오는 초콜릿의 코코아 함량과 Acalli공장에서 코코아 함량의 분산은 각각 차이가 있다 

result <- var.test(set_a,set_b)
print(result)
# p-value가 0.05보다 커서 귀무가설 채택, 두 집단의 분산이 차이가 없다.

#만약 p-value가 작다면 단측 검정 실행, 이 경우는 단측검정 할 필요 없음
#F-test: 분산 동질성 검정(단측) : 귀무가설 기각시 a집단은 b집단보다 분산이 작다
#var.test(set_a,set_b,alternative= "less")
#p-value가 0.05보다 크다 

#F-test: 분산 동질성 검정(단측) : 귀무가설  기각시 a집단은 b집단보다 분산이 크다
#var.test(set_a,set_b, alternative="greater")
#p-value가 0.05보다 작다. a집단은 b집단보다 분산이 크다


# 코드 암기 x 내가 작성한 코드만(R파일) 가지고 오기(주석 없어야함)
# 시험은 응용되게 나올 예정
# 14주차까지 내용
```
