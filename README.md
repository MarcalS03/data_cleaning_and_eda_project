# SQL Data Cleaning Project

This project contains SQL scripts used to clean and process a dataset of global layoffs for companies between March 2020 and March 2023. The scripts are designed to ensure the dataset is accurate, standardized, and ready for analysis.

## Steps Performed
- **Remove Duplicates**: Identifies and removes duplicate records based on key fields such as company name, location, industry, and layoffs data to ensure each record is unique and avoids redundancy.
  
- **Standardize the Data**: Cleans and standardizes the data by trimming whitespace, correcting inconsistent country names, and consolidating industry categories (e.g., normalizing variations of 'Crypto'). The `date` column is converted from string format to a `DATE` type for easier time-based analysis.
  
- **Handle Null or Blank Values**: Addresses missing data by populating null fields where possible, such as filling missing industry values based on the company name. Any rows lacking critical information (e.g., both `total_laid_off` and `percentage_laid_off`) are removed to maintain dataset integrity.

- **Remove Unnecessary Columns**: Drops columns used for intermediate steps, such as the `row_num` column, to keep the dataset clean and focused on the relevant data needed for further analysis.
