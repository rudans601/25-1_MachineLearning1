# 12주차 상관분석

## 이번 주 핵심

이 주차에서는 두 변수 사이의 관계를 숫자로 표현하는 상관분석을 배웠습니다. 단순히 값이 같이 커지거나 작아지는지 보는 것을 넘어서, 연속형 데이터에는 `Pearson`, 순위형 또는 비모수적 상황에는 `Spearman`을 사용하는 기준을 익히는 것이 핵심이었습니다.

## 코드 설명

아래 코드는 키와 몸무게처럼 연속형 데이터에 `Pearson` 상관분석을 적용하고, 자가평가와 교사평가처럼 순서 개념이 강한 데이터에는 `Spearman` 분석을 적용한 예시입니다. 후반부에서는 여러 독립변수와 집중력 점수 사이 관계를 함께 확인하면서, 어떤 변수만 유의한 상관을 갖는지도 살펴보고 있습니다.

## 원본 R 파일

- [`R/ml_12-2.R`](../../R/ml_12-2.R)

## 코드

```r
# 두연속형 변수의 상관관계를 분석할때

# 이건공분산을 판단할때 사용함 두 변수사이의 관계
# 키와 몸무게 데이터 생성
heights <- c(160, 162, 155, 180, 170, 175, 165, 171, 177, 172)
weights <- c(55, 60, 53, 72, 70, 73, 62, 64, 69, 65)
library(psych)
# 피어슨상관계수 도출 및 p-value
result_pearson=corr.test(heights, weights, method="pearson")
result_pearson$p #p-value
result_pearson$r #상관관계 계수

# 귀무가설 기각이라 키와 몸무게는 상관관계가 존재한다(강한 양의 상관관계)

s_eval <- c(3,4,2,5,1,4,3,2,5,3) #독립변수

e_eval <- c(2,5,2,4,1,4,3,2,5,3) #종속변수

result_pearson = corr.test(s_eval,e_eval,method="spearman")

result_pearson$p
result_pearson$r

#p-value가 0.05보다 작음
# 학생의 자가평가와 선생님의 평가가 강한 양의 상관관계를 띔

data <- read.csv("/Users/igyeongmun/Desktop/programming/ml_class/1/spearman/pearson.csv", stringsAsFactors = TRUE)
data2 <- read.csv("/Users/igyeongmun/Desktop/programming/ml_class/1/spearman/spearman.csv", stringsAsFactors = TRUE)


indep_vars <- data[, c("수면시간", "휴대폰사용시간", "카페인섭취량", "운동시간")]
target_var <- data[, "집중력점수", drop = FALSE] #drop = FALSE(데이터프레임 유지)

result_pearson = corr.test(indep_vars,target_var,method="spearman")
result_pearson$p
result_pearson$r

# 운동시간만 p-value가 0.05보다 작아서 운동시간과 집중력점수는 양의 상관관계를 가진다

#data2도 똑같이하기
indep_vars2 <- data2[, c("스트레스수준", "자기효능감수준", "학교만족도", "가족지원수준","소속감수준")]
target_var2 <- data2[, "집중력등급", drop = FALSE] #drop = FALSE(데이터프레임 유지)

result_pearson2 = corr.test(indep_vars2,target_var2,method="spearman")
result_pearson2$p
result_pearson2$r
```
