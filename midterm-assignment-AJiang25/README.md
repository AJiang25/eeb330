[![Review Assignment Due Date](https://classroom.github.com/assets/deadline-readme-button-24ddc0f5d75046c5622901739e7c5dd533143b0c8e959d652212380cedb1ea36.svg)](https://classroom.github.com/a/LDOTNo85)
[![Open in Visual Studio Code](https://classroom.github.com/assets/open-in-vscode-718a45dd9cf7e7f842a935f5ebbe5719a5e09af4491e668f4dbf3b35d5cca122.svg)](https://classroom.github.com/online_ide?assignment_repo_id=12167473&assignment_repo_type=AssignmentRepo)
**Problem Description: Analysis of Contaminant Impact on Ecological Diversity**

**Objective:**  
The primary aim of this project is to analyze the relationship between contaminants in different locations and the impact they have on the diversity of ecological communities over time.

**Background:**  
Ecological communities are sensitive to external factors such as contaminants, which can affect species abundance and overall diversity. A proper understanding of the relationship between contaminants and biodiversity is crucial for implementing conservation efforts and for understanding the health of an ecosystem.

**Data Provided:**  

1. **Contaminant Data:** 
    * Multiple CSV (Comma Separated Values) files containing contaminant measurements from various locations and dates. 
    * Each file will include:
        * `Date` of the measurement
        * `Location` ('Lake', 'River')
        * Contaminants 
          * 'Mercury' and 'Lead', ppm
  
2. **Ecological Community Data:**
    * Single CSV containing species observations for various locations and dates.
    * Each file will include:
        * `Month` of the observation
        * `Location`
        * Species counts for 10 species

**Tasks:**

1. **Data Parsing and Aggregation:**
    * Read the contaminant and ecological community data from the CSV files.
    * Parse the data, ensuring that any inconsistencies, missing values, or anomalies are handled.
    * Aggregate data so that it can be efficiently analyzed. This might involve merging data by date and location, calculating averages, or creating summarized tables.

2. **Calculation of Diversity Indexes:**
    * For each ecological community data set, calculate a diversity index (e.g., Shannon index, Simpson’s diversity index) over time.
    * Visualize the diversity indexes on a timeline for each location.

3. **Relate Contaminant Data to Diversity Indexes:**
    * Analyze the relationship between contaminant levels and the diversity indexes. 
    * Look for correlations, trends, or patterns that might suggest that certain contaminants have significant impacts on ecological diversity.


**Guide:**

> **Remember to commit liberally!** We want to see your work in reaching the solution to the assignment. A good annotated commit history and clear pull request is part of the grade.

> While we do not require you to use R Markdown for this assignment, we strongly recommend it. It will make your code easier to read and understand, and it will make it easier for you to communicate your results. If you do use R Markdown, please include the `.Rmd` file in your submission. If you choose to use R alone, please comment your code liberally.

1. Start by creating a function to read and organize the contaminants data. your function should receive as an argument the a path to a directory containing the contamination data. It should then read these files (the `dir()` function can help to find the correct files) and merge them into a single data.frame. The function should return a data.frame with the following columns: `Date`, `Mercury`, `Lead`, and `Location`.
2. With all the contaminants data in a single data.frame, **summarize** this data set by calculating the average concentration per month (That is, the average in 2010-01, 2010-02, ...) for each of the two contaminants.
3. Load the species count data into R, wrangle it however you see fit, there are several possibilities. You may use the data in the format it is in or modify it using the tidy data principles.
4. Next, modify the `Simpson()` and `Shannon()` diversity index functions we built in class to handle the data in the format you created in the previous step. Calculate the diversity index for each observation of the two communities.
5. Finally, join the two datasets (diversity measures and average contaminants) into a single data.frame.  (Hint: use one of the join functions)
6. Using this combined data set make plots, measure correlations, and look for patterns. For example: How do the contaminants behave in both locations? How does diversity change across time and locations? Are the two related? (Hint: see the first precept for a simple scatter plot code, and see the `cor()` function)
7. Write a single paragraph that summarizes your conclusions.

**Bonus credit:** Create a function called `Diversity()` that takes a function for calculating a diversity index (`Shannon()`, `Simpson()`, ...) as an argument. Use it to simplify your code.
