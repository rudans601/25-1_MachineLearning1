# Machine Learning 1 - Week 11
# Topic: ANOVA
# Original sources: ml_11-1.R, ml_11-2.R

# ---- Source: ml_11-1.R ----
data <- read.csv("/Users/igyeongmun/Desktop/programming/ml_class/1/ANOVA/class_scores.csv", stringsAsFactors = TRUE)

anova_result <- aov(Score ~ Class, data = data)
summary(anova_result)

library(multcomp)
tukey_result <- glht(anova_result, linfct = mcp(Class = "Tukey"))
summary(tukey_result)

grow <- read.csv("/Users/igyeongmun/Desktop/programming/ml_class/1/ANOVA/growth.csv", stringsAsFactors = TRUE)

anova_result <- aov(growth ~ fertilizer + water, data = grow)
summary(anova_result)
anova_result <- aov(growth ~ fertilizer * water, data = grow)
summary(anova_result)

library(car)
library(rstatix)

leveneTest(growth ~ fertilizer, data = grow)
games_howell_test(grow, growth ~ fertilizer)

leveneTest(growth ~ water, data = grow)
games_howell_test(grow, growth ~ water)

grow$group <- interaction(grow$fertilizer, grow$water)
group_model <- aov(growth ~ group, data = grow)

leveneTest(growth ~ group, data = grow)
tukey_result <- glht(group_model, linfct = mcp(group = "Tukey"))
summary(tukey_result)
games_howell_test(grow, growth ~ group)

data <- read.csv("/Users/igyeongmun/Desktop/programming/ml_class/1/ANOVA/cafe.csv", stringsAsFactors = TRUE)

anova_result <- aov(Satisfaction ~ CoffeeType * CafeMood * SeatLocation, data = data)
summary(anova_result)
anova_result <- aov(Satisfaction ~ CoffeeType + CafeMood + SeatLocation, data = data)
summary(anova_result)

leveneTest(Satisfaction ~ CoffeeType, data = data)
tukey_result <- glht(anova_result, linfct = mcp(CoffeeType = "Tukey"))
summary(tukey_result)

leveneTest(Satisfaction ~ CafeMood, data = data)
tukey_result <- glht(anova_result, linfct = mcp(CafeMood = "Tukey"))
summary(tukey_result)

leveneTest(Satisfaction ~ SeatLocation, data = data)
tukey_result <- glht(anova_result, linfct = mcp(SeatLocation = "Tukey"))

# ---- Source: ml_11-2.R ----
data <- read.csv("/Users/igyeongmun/Desktop/programming/ml_class/youtube.csv", stringsAsFactors = TRUE)
anova_result <- aov(ViewerCount ~ ContentType + ThumbnailType + UploadTime, data = data)
summary(anova_result)

leveneTest(ViewerCount ~ UploadTime, data = data)
tukey_result <- glht(anova_result, linfct = mcp(UploadTime = "Tukey"))
summary(tukey_result)

leveneTest(ViewerCount ~ ContentType, data = data)
tukey_result <- glht(anova_result, linfct = mcp(ContentType = "Tukey"))
summary(tukey_result)

leveneTest(ViewerCount ~ ThumbnailType, data = data)
games_howell_test(data, ViewerCount ~ ThumbnailType)
