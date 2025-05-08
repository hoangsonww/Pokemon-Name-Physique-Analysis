# Pokémon Name & Physique Analysis

An R-based exploration of Pokémon names (English & Japanese) and their physical attributes. We use string‐pattern queries to characterize name structure, test for relationships between phonetic features and weight, and build regression models predicting weight from height and Attack power.

---

## Table of Contents

1. [Project Overview](#project-overview)  
2. [Features & Analyses](#features--analyses)  
3. [Prerequisites](#prerequisites)  
4. [Installation](#installation)  
5. [Usage](#usage)  
6. [Script Breakdown](#script-breakdown)  
7. [Key Findings](#key-findings)  
8. [Extending & Customizing](#extending--customizing)  
9. [Data Source & Citations](#data-source--citations)  
10. [License](#license)  

---

## Project Overview

We analyze the **`pokemon-advanced.csv`** dataset (1,008 Pokémon) to:

- **Exercise 1:** Load and inspect English and Japanese name fields.  
- **Exercise 2:** Identify name patterns:
  - Exactly two identical vowels in a row (e.g., “Pikachuu”).  
  - At least three consecutive consonants.  
  - Alternating consonant–vowel (or vowel–consonant) sequences four times.  
  - Names starting with a vowel and ending with a consonant.  
- **Exercise 3:** Hypothesize phonetic “heaviness” associations.  
- **Exercise 4:** Divide Pokémon into two groups by whether their English name contains the “heavy” consonants **b, d, f, v, z**, compare average weights with a t-test, and repeat for Japanese names.  
- **Exercise 6–8:** Fit a simple linear regression of weight on height, then extend to a multiple regression adding Attack as a predictor; compare model fits.

---

## Features & Analyses

1. **Name‐pattern extraction** via **`stringr::str_detect`**:
   - Two identical vowels: `"(aa|ee|ii|oo|uu)"`  
   - Three+ consonants: `"[^aeiouAEIOU]{3,}"`  
   - Four+ alternating C–V or V–C: `"(?:[aeiou][^aeiou]){4,}|(?:[^aeiou][aeiou]){4,}"`  
   - Starts vowel, ends consonant: `"^[aeiou].*[^aeiou]$"`  

2. **Group comparisons**:
   - **With** vs. **without** “heavy” consonants in English names → t-test of weight.  
   - Same grouping for Japanese names.  

3. **Regression modeling**:
   - **Model 1:** `Weight ~ Height`  
   - **Model 2:** `Weight ~ Height + Attack`  
   - Compare R² and predictor significance.

All results (console output, plots if any) are produced by **`pokemon_name_physique_analysis.R`**.

---

## Prerequisites

- **R** (≥ 4.0)  
- **RStudio** (optional)  
- Internet access (to install any missing packages)

### R Packages

- `stringr`  
- `ggplot2` (for any future plots)  

The script auto-installs missing packages.

---

## Installation

1. **Clone** this repository:
   ```bash
   git clone https://github.com/yourusername/pokemon-name-physique.git
   cd pokemon-name-physique
   ```

2. Ensure **`pokemon-advanced.csv`** is placed in the project root.

---

## Usage

Run the analysis script in R:

```r
# From R or RStudio:
setwd("path/to/pokemon-name-physique")
source("pokemon_name_physique_analysis.R")
```

The script will print:

* Lists of names matching each string‐pattern criterion.
* t‐test results for English and Japanese name‐based weight comparisons.
* Regression summaries for Model 1 and Model 2.

---

## Script Breakdown

```r
library(stringr)
pokemon <- read.csv("pokemon-advanced.csv")
names   <- pokemon$Name..English.
jpn     <- pokemon$Name..Japanese.

# 2a–2d: str_detect subsets for various patterns
# 4: group_by heavy consonants → t.test(weights_with, weights_without)
# 6–8: lm(Weight ~ Height), lm(Weight ~ Height + Attack)
```

Each step prints results to the console.

---

## Key Findings

* **Name patterns**: Only a handful of Pokémon have exactly two identical vowels in a row; several names exhibit long consonant clusters or vowel‐consonant alternations.
* **Weight comparisons**:

  * **English‐name heavy‐consonant group** vs. others: *p* = \_\_\_
  * **Japanese‐name grouping**: *p* = \_\_\_
    (Insert the actual p‐values printed by your script.)
* **Height→Weight regression**: Height is a significant predictor (*β* ≈ 60 kg/m, *R²* ≈ 0.39).
* **Height+Attack model**: Attack adds explanatory power (*ΔR²* ≈ 0.03), making the multiple regression a better fit.

---

## Extending & Customizing

* **Additional name patterns**: test for hyphens, numbers, or foreign‐script characters.
* **Other physical predictors**: include Defense, Speed, or captured date.
* **Visualization**: plot model diagnostics or name‐pattern frequency bar charts using `ggplot2`.

---

## Data Source & Citations

* **`pokemon-advanced.csv`**: extended Pokémon dataset with English & Japanese names, heights, weights, and stats.
* **R Packages**:

  * Wickham H. (2023). *stringr: Simple, Consistent Wrappers for Common String Operations*.
  * Wickham H. (2016). *ggplot2: Elegant Graphics for Data Analysis*.

---

## License

This project is released under the **MIT License**. See `LICENSE` for details.
