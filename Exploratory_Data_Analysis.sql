-- Exploratory Data Analysis


SELECT *
FROM layoffs_staging2;


-- To see what's the max layoffs

SELECT max(total_laid_off), max(percentage_laid_off)
FROM layoffs_staging2;


-- To see the companies who fired all of their employees in the desc order of funds raised

SELECT *
FROM layoffs_staging2
WHERE percentage_laid_off = 1
ORDER BY funds_raised_millions DESC;


-- To see  sum of total layoffs in the descending order grouped by companies. This tells us which companies had the highest layoffs.

SELECT company, sum(total_laid_off)
FROM layoffs_staging2
GROUP BY company
ORDER BY 2 DESC;


-- To see where the data begins at date and where it ends

SELECT min(`date`), max(`date`)
FROM layoffs_staging2;


-- To see  sum of total layoffs in the descending order grouped by industries. This tells us which industries had the highest layoffs.

SELECT industry, sum(total_laid_off)
FROM layoffs_staging2
GROUP BY industry
ORDER BY 2 DESC;



-- To see  sum of total layoffs in the descending order grouped by countries. This tells us which countries had the highest layoffs.

SELECT country, sum(total_laid_off)
FROM layoffs_staging2
GROUP BY country
ORDER BY 2 DESC;


-- Sum of total layoffs in the descending order of Years

SELECT strftime('%Y', `date`) , sum(total_laid_off)
FROM layoffs_staging2
GROUP BY strftime('%Y', `date`)
ORDER BY 1 DESC;



-- To see  sum of total layoffs in the descending order grouped by company's stage. This tells us which stage of the company had the highest layoffs.

SELECT stage, sum(total_laid_off)
FROM layoffs_staging2
GROUP BY stage
ORDER BY 2 DESC;

--Rolling Total of  Employees laid off by each month from start to beginning of the data
WITH Rolling_Total AS 
(
SELECT substr(`date`, 1, 4) AS Month,  sum(total_laid_off) AS total_off
FROM layoffs_staging2
WHERE Month is NOT NULL
GROUP BY Month
ORDER BY 1 ASC
)
SELECT Month, total_off,
sum(total_off) OVER(ORDER BY Month) as Rolling_Total_Off
FROM Rolling_Total;


-- To find out how much companies were laying off per year, below are the two ways.

SELECT company, substr(`date`, 1, 4) AS Year, total_laid_off
FROM layoffs_staging2
GROUP BY company, Year
ORDER BY 1;

SELECT company, substr(`date`, 1, 4) AS Year, total_laid_off,
row_number() OVER(PARTITION BY company)
FROM layoffs_staging2;


-- Now lets say we wanna rank these companies in terms of who layed off the most.Number 1 being the most.

WITH company_year(company, years, total_laid_off) AS
(
SELECT company, substr(`date`, 1, 4), sum(total_laid_off)
FROM layoffs_staging2
GROUP BY company, substr(`date`, 1, 4)
)
SELECT *, 
dense_rank() OVER(PARTITION BY years ORDER BY total_laid_off DESC) as rank_num
FROM company_year
WHERE years is NOT NULL
ORDER BY rank_num ASC;


-- Now lets say we wanna find out the top 5 companies who layed off the most employees in each year

WITH company_year(company, years, total_laid_off) AS
(
SELECT company, substr(`date`, 1, 4), sum(total_laid_off)
FROM layoffs_staging2
GROUP BY company, substr(`date`, 1, 4)
), company_year_rank AS
(
SELECT *, 
dense_rank() OVER(PARTITION BY years ORDER BY total_laid_off DESC) as rank_num
FROM company_year
WHERE years is NOT NULL
)
SELECT *
FROM company_year_rank
WHERE rank_num <= 5;