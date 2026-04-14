# 11주차 ANOVA

## 이번 주 핵심

이 주차는 한 학기 내용 중 가장 핵심적인 분기점 중 하나였습니다. 두 집단 비교를 넘어 세 집단 이상 평균 차이를 검정하는 `ANOVA`를 배우면서, 독립변수가 여러 개일 때는 상호작용까지 함께 해석해야 한다는 점을 익혔습니다.

## 코드 설명

`ml_11-1.R`에서는 일원분산분석, 이원분산분석, 삼원 수준의 해석까지 이어지며 `Levene test`, `Tukey`, `Games-Howell` 사후검정이 모두 등장합니다. `ml_11-2.R`는 유튜브 조회수 데이터를 예시로 사용해, 같은 분산분석 흐름을 다른 데이터에 그대로 적용해 보는 응용 코드입니다.

## 원본 R 파일

- [`R/ml_11-1.R`](../../R/ml_11-1.R)
- [`R/ml_11-2.R`](../../R/ml_11-2.R)

## `ml_11-1.R`

이 파일은 분산분석의 전체 흐름을 가장 자세하게 담고 있는 주차 핵심 코드입니다.

```r
# ANOVA : 세개 이상의 그룹의 평균 차이를 검정하는 방법
# 귀무가설 : 세 그룹의 평균의 차이는 존재하지 않는다
# 대립가설 : 세 그룹의 평균의 차이는 존재한다
# 1. 데이터 불러오기
data <- read.csv("/Users/igyeongmun/Desktop/programming/ml_class/1/ANOVA/class_scores.csv", stringsAsFactors = TRUE)

# ANOVA : 세개 이상의 그룹의 평균 차이를 검정하는 방법
# 2. ANOVA 분석
anova_result <- aov(Score ~ Class, data = data)

# 3. 분석 결과 출력
summary(anova_result)

#p-value가 0.05보다 적어서 차이가 있음 대립가설 채택
# 어느 집단이 차이가 많이 나는지 확인할려고
# 4. 사후검증 출력
library(multcomp) #사후검정

tukey_result <- glht(anova_result, linfct = mcp(Class = "Tukey"))
summary(tukey_result)
# p-value가 0.05보다 작아야 통계적으로 유의미하고 집단간 평균 비교를 estimate로 하면 된다
#b - a 집단 estimate가 -6이라 a집단이 더 크다
#c - a 집단 estimate가 4이니 c집단이 더 크다
#c - b 집단 estimate가 10이니 c집단이 더 크다( c집단이 가장 크다)
# c > a > b 순으로 집단의 평균 크기 차이다

#  기존 카이제곱의 독립성 검정이랑 독립변수는 다르다

# ------ anova 이원분산분석 : 두개의 독립 변수가 각각 종속변수에 어떤 영향을 주는지, 상호작용하는지-----
#귀무가설과 대립가설이 2개가 생긴다
grow <- read.csv("/Users/igyeongmun/Desktop/programming/ml_class/1/ANOVA/growth.csv", stringsAsFactors = TRUE) #문자형 변수를 요소로 변환

#독립변수는 fertilizer, water이고 종속변수는 grow
# 이원분산분석(독립변수들간 상호작용X)
anova_result <- aov(growth ~ fertilizer + water, data = grow)
summary(anova_result)
# 이원분산분석(독립변수들간 상호작용) : 상호작용 먼저 고려하기
anova_result <- aov(growth ~ fertilizer * water, data = grow)
summary(anova_result)
# fertilizer:water pvalue가 0.05보다 작아서 상호작용이 존재한다, 사후검정 해야한다
# 여기서는 f테스트와 다른게 f테스트는 두개의 집단에 대해서만 등분산 검정을 하는거고 이 leveneTest는 두개 이상 집단에서 등분산 검정을 하는거다

#p-value<0.05이면 등분산이 가정되지 않고,(=분산이 유사하지 않다) (두 독립변수의 표본 개수가 달라도 됨) games-howell 검정하기, 
#p-value>0.05이면 등분산이 가정(=분산이 유사하다)되고, (두 독립변수의 표본 개수가 동일해야함)tukey 검정하기

library(car) #등분산검정
library(rstatix) #games_howell_test

#사후검정(fertilizer)
#p-value<0.05일 때 games-howell 검증사용가능(등분산이 아닐경우)
leveneTest(growth ~ fertilizer, data = grow)

# tukey쓰지 않기
#tukey_result <- glht(anova_result, linfct = mcp(fertilizer = "Tukey"))
# 그래서 games-howell 검정
games_howell_test(grow, growth ~ fertilizer)
#games-howell은 a,b이면 b-a라고 생각해야 한다 
# a,b와 a,c와 b,c의 p.adj가 0.05보다 적음 통계적으로 유의미
# estimate 비교하면 c > b > a로 나온다

#사후검정(water)
leveneTest(growth ~ water, data = grow)

#tukey 쓰지 않기
#tukey_result <- glht(anova_result, linfct = mcp(water = "Tukey"))
#p-value<0.05일 때 games-howell 검증사용가능(등분산이 아닐경우)
games_howell_test(grow, growth ~ water)
#low - high 가 -3.75 : 물이 많을수록 더 잘 자란다(grow값 커짐)

# 결론 :fertilizer가 c이고 water가 high일때 grow값이 커진다

# 독립변수가 범주형일때 주로 사용
#회기분석은 종속변수가 연속형이고 독립변수도 연속형(범주형도 가능)일때 사용하는 모델이다

# 이원분산분석(독립변수들간 상호작용)
# 사후검정(fertilizer*water)
# 교호작용을 하나의 그룹 변수로 통합
grow$group <- interaction(grow$fertilizer, grow$water) #변수 묶어서 하나의 변수로 만들어 줌
group_model <- aov(growth ~ group, data = grow)

leveneTest(growth ~ group, data = grow) #귀무가설 기각 시(p-value<0.05), games-Howell 검증사용 가능
#0.05보다 큼, tukey검정해봄

tukey_result <- glht(group_model, linfct = mcp(group = "Tukey"))
summary(tukey_result)

games_howell_test(grow, growth ~ group)


data <- read.csv("/Users/igyeongmun/Desktop/programming/ml_class/1/ANOVA/cafe.csv", stringsAsFactors = TRUE)

# 분산 분석


# 3차 상호작용 여부 확인(p)
anova_result <- aov(Satisfaction ~ CoffeeType * CafeMood * SeatLocation, data = data)
summary(anova_result)
anova_result <- aov(Satisfaction ~ CoffeeType + CafeMood + SeatLocation, data = data)
summary(anova_result)
# 3개 다 카페의 만족도에 영향을 줌
# CoffeeType는 집단간의 차이가 존재한다
# CafeMood는 집단간의 차이가 존재한다
# SeatLocation는 집단간의 차이가 존재한다,

leveneTest(Satisfaction ~ CoffeeType, data = data)
# 0.05보다 커서 등분산이고 터키 검정
tukey_result <- glht(anova_result, linfct = mcp(CoffeeType = "Tukey"))
summary(tukey_result)
# 모든 커피들이 유의하지 않음(유의한 차이 없음)

leveneTest(Satisfaction ~ CafeMood, data = data)
tukey_result <- glht(anova_result, linfct = mcp(CafeMood = "Tukey"))
summary(tukey_result)
# Quiet - Crowded 만 0.05보다 높으니 조용한 분위기가 만족도가 높음, 혼잡도는 가장 낮은 만족도

leveneTest(Satisfaction ~ SeatLocation, data = data)
tukey_result <- glht(anova_result, linfct = mcp(SeatLocation = "Tukey"))
# 여긴 gpt한테 다시 물어보기
# 자리가 가장 만족도가 높다
```

## `ml_11-2.R`

이 파일은 분산분석을 유튜브 조회수 데이터에 적용한 응용 예제입니다.

```r
# 민구코드
data<-read.csv("/Users/igyeongmun/Desktop/programming/ml_class/youtube.csv", stringsAsFactors = TRUE)
anova_result <- aov(ViewerCount ~ ContentType + ThumbnailType + UploadTime, data = data)
summary(anova_result)

# 3개 다 유튜브 조회수에 영향을 줌
# ContentType는 집단간의 차이가 존재한다
# ThumbnailType는 집단간의 차이가 존재한다
# UploadTime는 집단간의 차이가 존재한다,

# 사후검정
library(rstatix)
library(car)
leveneTest(ViewerCount ~ UploadTime, data = data)
tukey_result <- glht(anova_result, linfct = mcp(UploadTime = "Tukey"))
summary(tukey_result)

leveneTest(ViewerCount ~ ContentType, data = data)
tukey_result <- glht(anova_result, linfct = mcp(ContentType = "Tukey"))
summary(tukey_result)

leveneTest(ViewerCount ~ ThumbnailType, data = data)
games_howell_test(data,ViewerCount ~ ThumbnailType)
```
