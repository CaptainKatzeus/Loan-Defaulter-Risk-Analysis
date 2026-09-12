-- Loan Default Risk Analysis
-- Dataset: Lending Club Accepted Loans (2007-2018Q4), sampled to ~60k resolved loans
-- Author: Anubhav Prakash

-- 1. Overall default rate
SELECT 
    ROUND(AVG(is_default) * 100, 2) AS default_rate_pct,
    COUNT(*) AS total_loans
FROM loans;

-- 2. Default rate by loan grade
SELECT 
    grade,
    COUNT(*) AS total_loans,
    ROUND(AVG(is_default) * 100, 2) AS default_rate_pct
FROM loans
GROUP BY grade
ORDER BY grade;

-- 3. Default rate by loan purpose
SELECT 
    purpose,
    COUNT(*) AS total_loans,
    ROUND(AVG(is_default) * 100, 2) AS default_rate_pct
FROM loans
GROUP BY purpose
ORDER BY default_rate_pct DESC;

-- 4. Default rate by income bracket
SELECT 
    CASE 
        WHEN annual_inc < 40000 THEN 'Under 40k'
        WHEN annual_inc < 70000 THEN '40k-70k'
        WHEN annual_inc < 100000 THEN '70k-100k'
        WHEN annual_inc < 150000 THEN '100k-150k'
        ELSE '150k+'
    END AS income_bracket,
    COUNT(*) AS total_loans,
    ROUND(AVG(is_default) * 100, 2) AS default_rate_pct
FROM loans
GROUP BY income_bracket
ORDER BY MIN(annual_inc);

-- 5. Default rate by employment length
SELECT 
    emp_length,
    COUNT(*) AS total_loans,
    ROUND(AVG(is_default) * 100, 2) AS default_rate_pct
FROM loans
GROUP BY emp_length
ORDER BY default_rate_pct DESC;

-- 6. Default rate by FICO score bucket
SELECT 
    CASE 
        WHEN fico_range_low < 660 THEN 'Below 660'
        WHEN fico_range_low < 700 THEN '660-700'
        WHEN fico_range_low < 740 THEN '700-740'
        WHEN fico_range_low < 780 THEN '740-780'
        ELSE '780+'
    END AS fico_bucket,
    COUNT(*) AS total_loans,
    ROUND(AVG(is_default) * 100, 2) AS default_rate_pct
FROM loans
GROUP BY fico_bucket
ORDER BY MIN(fico_range_low);
