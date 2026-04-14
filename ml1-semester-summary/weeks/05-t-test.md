# 5주차 t-test

## 이번 주 핵심

이 주차부터는 단순 계산을 넘어서 가설검정을 실제로 적용하기 시작했습니다. 특히 두 집단의 평균 차이가 우연인지, 아니면 통계적으로 의미 있는 차이인지 판단하는 `t-test`의 기본 구조를 익혔습니다.

## 코드 설명

아래 코드는 같은 데이터에 대해 양측검정, 단측검정(`less`, `greater`)을 각각 적용해 보는 연습입니다. 귀무가설과 대립가설을 어떻게 세우느냐에 따라 해석이 달라진다는 점을 확인할 수 있고, `p-value`를 기준으로 어떤 가설을 채택하거나 기각하는지 연습하는 데 의미가 있습니다.

## 원본 R 파일

- [`R/ml_5-2.R`](../../R/ml_5-2.R)

## 코드

```r
#표본집단이 모집단을 표현할수 있을때 기댓값

#중,고등학생의 나이와 결석일수
pd <- read.csv("/Users/igyeongmun/Desktop/programming/R/student-mat.csv")

age_one <- pd$age
absences_one <- pd$absences

#집단 a의 평균과 집단 b의 평균의 차이가 존재한다 : 존재한다
t_test_result <- t.test(age_one, absences_one, alternative = "two.sided")
#집단 a의 평균이 집단 b보다 작다 : p value가 1이라 성립하지 않음 
t_test_result <- t.test(age_one, absences_one, alternative = "less")
#집단 a의 평균이 집단 b보다 크다 : p value가 0.05보다 작으니까 크게 차이가 존재한다
t_test_result <- t.test(age_one, absences_one, alternative = "greater")
```
