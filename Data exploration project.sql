SELECT *
FROM layoffs_staging2;


SELECT max(total_laid_off), max(percentage_laid_off)
FROM layoffs_staging2;

SELECT *
FROM layoffs_staging2
WHERE percentage_laid_off = 1
ORDER BY funds_raised_millions DESC;


SELECT company, sum(total_laid_off)
FROM layoffs_staging2
GROUP BY company
ORDER BY 2 DESC;


SELECT min(`date`), max(`date`)
FROM layoffs_staging2;

SELECT industry, sum(total_laid_off)
FROM layoffs_staging2
GROUP BY industry
ORDER BY 2 DESC;

SELECT country, sum(total_laid_off)
FROM layoffs_staging2
GROUP BY country
ORDER BY 2 DESC;

SELECT year(`date`), sum(total_laid_off)
FROM layoffs_staging2
GROUP BY year(`date`)
ORDER BY 1 DESC;

SELECT stage, sum(total_laid_off)
FROM layoffs_staging2
GROUP BY stage
ORDER BY 2 DESC;

SELECT *
FROM layoffs_staging2;

SELECT substring(`date`,1,7) AS `MONTH`, SUM(total_laid_off)
FROM layoffs_staging2
WHERE  substring(`date`,1,7) IS NOT NULL
GROUP BY `MONTH`
ORDER BY 1 ASC
;

WITH Rolling_Total AS
(
SELECT substring(`date`,1,7) AS `MONTH`, SUM(total_laid_off) AS total_off
FROM layoffs_staging2
WHERE  substring(`date`,1,7) IS NOT NULL
GROUP BY `MONTH`
ORDER BY 1 ASC
)
SELECT `MONTH`, total_off, 
SUM(total_off) OVER(ORDER BY `MONTH`) AS rolling_total
FROM Rolling_Total;



SELECT company, sum(total_laid_off)
FROM layoffs_staging2
GROUP BY company
ORDER BY 2 DESC;


SELECT company, year(`date`), sum(total_laid_off)
FROM layoffs_staging2
GROUP BY company, year(`date`)
ORDER BY 3 DESC;



WITH Company_Year (company, years, total_laid_off) AS
(
SELECT company, year(`date`), sum(total_laid_off)
FROM layoffs_staging2
GROUP BY company, year(`date`)
), Company_Year_Rank AS
(SELECT *, DENSE_RANK() OVER(PARTITION BY years ORDER BY total_laid_off DESC) AS Ranking
FROM Company_Year
WHERE years IS NOT NULL
)
Select *
FROM Company_Year_Rank
WHERE Ranking <=5;








