library(stringr)

# Exercise 1:
# 1. Read the file "pokemon-advanced.csv"
pokemon <- read.csv("pokemon-advanced.csv")
head(pokemon)

# Extract English and Japanese names
names <- pokemon$Name..English.
japan_names <- pokemon$Name..Japanese.

# Exercise 2:
# 2a. Contain exactly two identical vowels in a row
subset(names, str_detect(names, "(aa|ee|ii|oo|uu)"))

# 2b. Contain at least 3 consecutive consonants
# Consonants = letters that are not a, e, i, o, u
subset(names, str_detect(names, "[^aeiouAEIOU]{3,}"))

# 2c. Consonants and vowels alternate at least 4 times
subset(names, str_detect(names, "([aeiouAEIOU][^aeiouAEIOU]){4,}|([^aeiouAEIOU][aeiouAEIOU]){4,}"))

# 2d. Start with a vowel and end with a consonant
subset(names, str_detect(names, "^[aeiouAEIOU].*[^aeiouAEIOU]$"))

# Exercise 3: 
# 3. What kind of characteristics do you think are shared?
# I think Power, heaviness, toughness. Sounds like 'b', 'd', 'g', 'v', 'z' may signal strength or heaviness.)

# 4a. split by presence of consonants b, d, f, v, z
# First group: Pokemon names that contain at least one of the letters b, d, f, v, z
group_with <- pokemon[str_detect(names, "[bdfvzBDFVZ]"), ]
# Second group: Pokemon names that do not contain any of the letters b, d, f, v, z
group_without <- pokemon[!str_detect(names, "[bdfvzBDFVZ]"), ]

# 4b. Extract weight in kg for both groups
weights_with <- group_with$Weight..kg.
weights_without <- group_without$Weight..kg.

# 4c. Perform t-test to determine if there are any statistically significant differences in 
# weight between the two groups
t_test_result_eng <- t.test(weights_with, weights_without)
t_test_result_eng

# 5. Do the same for Japanese names
group_with_jp <- pokemon[str_detect(japan_names, "[bdfvzBDFVZ]"), ]
group_without_jp <- pokemon[!str_detect(japan_names, "[bdfvzBDFVZ]"), ]

weights_with_jp <- group_with_jp$Weight..kg.
weights_without_jp <- group_without_jp$Weight..kg.

t_test_result_jp <- t.test(weights_with_jp, weights_without_jp)
t_test_result_jp

# Exercise 4: 
# 6. Simple linear regression of weight & height
model1 <- lm(Weight..kg. ~ Height..m., data = pokemon)
summary(model1)

# 7. Interpretation:
# The model shows that for every 1 meter increase in height, a Pokemon's weight 
# increases by approx 60.34 kg. The relationship is statistically significant also.

# 8. Multiple linear regression - I added attack as an additional predictor var
model2 <- lm(Weight..kg. ~ Height..m. + Attack, data = pokemon)
summary(model2)

# Compare models using R-squared
summary(model1)
summary(model2)

# Interpretation: Adding Attack as a predictor slightly improved the model, as it
# increased the R^2 from 0.39 to 0.42, so it explains more about the variance in weight.
# Attack is also a significant predictor, which also confirms this model is better at 
# predicting a pokemon’s weight.
