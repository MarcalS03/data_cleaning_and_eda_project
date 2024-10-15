-- STEPS
-- 1. Remove Duplicates
-- 2. Standardize the Data
-- 3. Null Values or Blank Values
-- 4. Remove Any Unnecessary Columns


-- Creating a staging table to work on so we do not alter the raw data
CREATE TABLE layoffs_staging
LIKE layoffs_raw;


-- Copying the raw data into the staging table
INSERT INTO layoffs_staging
SELECT *
FROM layoffs_raw;


WITH duplicate_cte AS
(
-- Adds +1 for every entry so if there is a duplicate it will add it on to the original entry i.e row_num = 2
SELECT *,
ROW_NUMBER() OVER(
PARTITION BY company, location, industry, total_laid_off,
percentage_laid_off, `date`, stage, country, funds_raised_millions) AS row_num
FROM layoffs_staging
)
-- Selects all data where the row_num was above 1 i.e there was at least one duplicate detected
SELECT *
FROM duplicate_cte
WHERE row_num > 1;


-- Checking if the duplicates are really there
SELECT *
FROM layoffs_staging
WHERE company = 'Casper';


-- Creating cleaned_data table with additional column 'row_num'
CREATE TABLE cleaned_data
LIKE layoffs_staging;

-- Inserting data with row numbers to detect duplicates
INSERT INTO cleaned_data
SELECT *,
ROW_NUMBER() OVER(
PARTITION BY company, location, industry, total_laid_off,
percentage_laid_off, `date`, stage, country, funds_raised_millions) AS row_num
FROM layoffs_staging;


-- Deleting duplicates (rows where row_num > 1)
DELETE
FROM cleaned_data
WHERE row_num > 1;

-- Verifying the data after duplicates have been removed
SELECT *
FROM cleaned_data;


-- Standardizing data

-- Trimming spaces from the 'company' column
SELECT company, TRIM(company)
FROM cleaned_data;

-- Update the 'company' column to remove leading/trailing spaces
UPDATE cleaned_data
SET company = TRIM(company);

-- Standardizing the 'industry' column to set all entries starting with 'Crypto' to 'Crypto'
SELECT *
FROM cleaned_data
WHERE industry LIKE 'Crypto%';

UPDATE cleaned_data
SET industry = 'Crypto'
WHERE industry LIKE 'Crypto%';

-- Checking distinct values in 'location'
SELECT DISTINCT(location)
FROM cleaned_data
ORDER BY 1;

-- Checking distinct values in 'country'
SELECT DISTINCT(country)
FROM cleaned_data
ORDER BY 1;

-- Correcting 'country' values that contain trailing periods
SELECT *
FROM cleaned_data
WHERE country = 'United States.';

-- Removing trailing periods from 'country'
SELECT DISTINCT(country), TRIM(TRAILING '.' FROM country)
FROM cleaned_data
ORDER BY 1;

-- Update country field to remove trailing periods
UPDATE cleaned_data
SET country = TRIM(TRAILING '.' FROM country)
WHERE country LIKE 'United States%';


-- Converting 'date' from string to DATE format
SELECT `date`, 
STR_TO_DATE(`date`, '%m/%d/%Y')
FROM cleaned_data;

-- Updating the 'date' field with the correct format and ensuring only valid dates are updated
UPDATE cleaned_data
SET `date` = STR_TO_DATE(`date`, '%m/%d/%Y')
WHERE STR_TO_DATE(`date`, '%m/%d/%Y') IS NOT NULL;

-- Checking that 'date' conversion worked
SELECT `date`
FROM cleaned_data;

-- Modifying 'date' column to ensure it's in DATE format
ALTER TABLE cleaned_data
MODIFY COLUMN `date` DATE;


-- Dealing with nulls

-- Checking for rows where both 'total_laid_off' and 'percentage_laid_off' are NULL
SELECT *
FROM cleaned_data
WHERE total_laid_off IS NULL
AND percentage_laid_off IS NULL;

-- Checking for rows where 'industry' is NULL or blank
SELECT *
FROM cleaned_data
WHERE industry IS NULL
OR industry = '';

-- Populating NULL values in 'industry' using data from the same company
SELECT *
FROM cleaned_data
WHERE company = 'Airbnb';

-- Setting 'industry' to NULL where it's blank
UPDATE cleaned_data
SET industry = NULL
WHERE TRIM(industry) = '';  -- Fixing to handle blank or whitespace-only industries

-- Cross-referencing industry values for NULL entries based on company
SELECT t1.industry, t2.industry
FROM cleaned_data t1
JOIN cleaned_data t2
    ON t1.company = t2.company
WHERE t1.industry IS NULL
AND t2.industry IS NOT NULL;

-- Update industry where it's NULL based on matching company entries
UPDATE cleaned_data t1
JOIN cleaned_data t2
    ON t1.company = t2.company
SET t1.industry = t2.industry
WHERE t1.industry IS NULL
AND t2.industry IS NOT NULL;

-- Checking for any remaining NULL industries
SELECT *
FROM cleaned_data
WHERE industry IS NULL;


-- Deleting rows where both 'total_laid_off' and 'percentage_laid_off' are NULL
SELECT *
FROM cleaned_data
WHERE total_laid_off IS NULL
AND percentage_laid_off IS NULL;

DELETE
FROM cleaned_data
WHERE total_laid_off IS NULL
AND percentage_laid_off IS NULL;

-- Removing the 'row_num' column after processing duplicates
ALTER TABLE cleaned_data
DROP COLUMN row_num;

-- Final check of the table
SELECT 
    *
FROM
    cleaned_data;