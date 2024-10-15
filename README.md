# SQL Data Cleaning and Exploratory Data Analysis (EDA) Project

This project showcases the full workflow of data processing and exploratory data analysis using SQL. The dataset contains information about global company layoffs between March 2020 and March 2023. The project focuses on cleaning the raw data and then performing exploratory data analysis to uncover insights.

## Project Structure

- `data/raw/`: Contains the raw dataset.
  - `raw_data_layoffs.csv`: The raw, unprocessed data related to layoffs.
  
- `data/cleaned/`: Contains the cleaned dataset after running the data cleaning script.
  - `cleaned_data_layoffs.csv`: The cleaned data after processing.
  
- `sql/`: Contains SQL scripts for cleaning and analyzing the data.
  - `DataCleaning.sql`: SQL script for cleaning the raw data, including removing duplicates, handling null values, standardizing data, and formatting.
  - `EDA.sql`: SQL script for performing exploratory data analysis (EDA) on the cleaned data, providing insights on layoffs by industry, location, and time period.

- `README.md`: This file, which explains the purpose and structure of the project.

## Steps Performed

### 1. Data Cleaning (`DataCleaning.sql`)
The `DataCleaning.sql` script performs several essential cleaning tasks to prepare the raw data for analysis:
- **Remove Duplicates**: Identifies and removes duplicate records based on key fields such as company, location, industry, and layoffs data.
- **Standardize Data**: Trims excess whitespace, standardizes industry categories (e.g., consolidating variations of 'Crypto'), corrects inconsistent country names, and converts date fields to a standard `DATE` format.
- **Handle Null or Blank Values**: Fills in missing data by cross-referencing existing records (e.g., filling missing industry fields based on the company name). It also removes rows with critical missing values, such as those without total layoffs or percentage laid off.
- **Final Cleaned Dataset**: The output of this script is a cleaned version of the raw data, stored in the `cleaned_data_layoffs.csv` file.

### 2. Exploratory Data Analysis (`EDA.sql`)
The `EDA.sql` script explores the cleaned data to extract valuable insights:
- **Industry Trends**: Identifies which industries experienced the most layoffs and at what stages (e.g., startups, mid-sized companies).
- **Geographical Distribution**: Analyzes layoffs by location and country to determine where the most significant layoffs occurred.
- **Time Analysis**: Looks at trends over time, showing how layoffs varied from March 2020 to March 2023.
- **Layoff Impact**: Calculates the total number of layoffs and the percentage of workforce laid off by company or industry, providing insights into the severity of layoffs across different sectors.

## How to Run the Project

1. **Run Data Cleaning**:
   - Execute the `DataCleaning.sql` script in your SQL environment to clean the raw data (`raw_data_layoffs.csv`).
   - The result will be a cleaned dataset, which you can store as `cleaned_data_layoffs.csv` for further analysis.

2. **Run EDA**:
   - After cleaning the data, execute the `EDA.sql` script to perform exploratory data analysis.
   - The analysis includes aggregations, calculations, and insights derived from the cleaned data.

## Data

- **Raw Data**: The raw data (`raw_data_layoffs.csv`) can be found in the `data/raw/` directory.
- **Cleaned Data**: After running the cleaning script, you can store the cleaned data in the `data/cleaned/` directory for quick access.

## Technologies Used

- **SQL**: MySQL (or any compatible database system) to clean and analyze the data.

## Outcome

This project demonstrates an end-to-end workflow, from raw data to cleaned, structured data, followed by exploratory data analysis. The insights derived from the EDA offer valuable understanding of global layoffs during a critical period (March 2020 to March 2023). The SQL scripts provided allow for reproducibility of both the data cleaning and analysis processes.
