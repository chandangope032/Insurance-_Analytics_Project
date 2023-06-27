create database	Project;
use project;


select * from brokerage;
select * from opportunity;
select * from invoice;
select * from Meeting;
select * from `individual budgets`;
select * from fees;



 SET SQL_SAFE_UPDATES = 0;
UPDATE brokerage
SET `Account Executive` = 
    CASE `Account Executive`
        WHEN 'Vinay' THEN 'Anil Tailor'
        WHEN 'Abhinav Shivam' THEN 'Ankita Shah'
        WHEN 'Mark' THEN 'Divya Dhingra'
        WHEN 'Manish Sharma' THEN 'Neel Jain'
        WHEN 'Animesh Rawat' THEN 'Nishant Sharma'
        WHEN 'Shivani Sharma' THEN 'Ritesh Sharma'
        WHEN 'Ketan Jain' THEN 'Shloka Shelat'
        WHEN 'Juli' THEN 'Shobhit Agarwal'
        WHEN 'Raju Kumar' THEN 'Vaibhav K Thaker'
        WHEN 'Vididt Saha' THEN 'Vidit Shah'
        WHEN 'Kumar Jha' THEN 'Vidit Shah'
        WHEN 'Gilbert' THEN 'Vidit Shah'
    END;
    
    
    UPDATE opportunity
SET `Account Executive` = 
    CASE `Account Executive`
    WHEN 'Animesh Rawat' THEN 'Nishant Sharma'
	WHEN 'Shivani Sharma' THEN 'Ritesh Sharma'
    WHEN 'Mark' THEN 'Divya Dhingra'
  END;
  
  
  
  UPDATE invoice
SET `Account Executive` = 
    CASE `Account Executive`
    WHEN 'Gautam Murkunde' THEN 'Vidit Shah'
    ELSE `Account Executive`
     END;
     
     
UPDATE meeting
SET `Account Executive` = 
    CASE `Account Executive`
        WHEN 'Abhinav Shivam' THEN 'Ankita Shah'
        WHEN 'Vinay' THEN 'Anil Tailor'
        WHEN 'Animesh Rawat' THEN 'Nishant Sharma'
        WHEN 'Ketan Jain' THEN 'Shloka Shelat'
        WHEN 'Juli' THEN 'Shobhit Agarwal'
        WHEN 'Shivani Sharma' THEN 'Ritesh Sharma'
        WHEN 'Manish Sharma' THEN 'Neel Jain'
        WHEN 'Raju Kumar' THEN 'Vaibhav K Thaker'
        WHEN 'Mark' THEN 'Divya Dhingra'
        ELSE `Account Executive`
    END;
    
    

create table Place_Achivement as
select   b.`Account Executive`,b.income_class,b.amount from brokerage b
left join fees f
on (b.income_class = f.income_class and b.`Account Executive` = f.`Account Executive` and b.amount = f.amount);

select sum(amount) from  Place_Achivement; 

select * from Place_Achivement;







CREATE TABLE Place_Achievement AS
SELECT b.`Account Executive`, b.income_class, b.amount 
FROM brokerage b
LEFT JOIN fees f
ON b.income_class = f.income_class 
AND b.`Account Executive` = f.`Account Executive` 
AND b.amount = f.amount
UNION
SELECT f.`Account Executive`, f.income_class, f.amount
FROM fees f
LEFT JOIN brokerage b
ON f.income_class = b.income_class 
AND f.`Account Executive` = b.`Account Executive` 
AND f.amount = b.amount
WHERE b.`Account Executive`;


select * From Place_Achievement;



/*---- Views------*/


/*NO OF MEETINGS BY ACCOUNT EXECUTIVE */

select * from no_of_meetings_by_executive;

CREATE VIEW no_of_meetings_by_executive AS
SELECT `Account Executive`, COUNT(*) as Meetings_Count
FROM meeting
GROUP BY `Account Executive`;


/*NO OF INVOICE BY ACCOUNT EXECUTIVE */ 

select * from no_of_invoice_by_executive;

CREATE VIEW no_of_invoice_by_executive AS
SELECT `Account Executive`, COUNT(*) as `Invoice Count`
FROM invoice
GROUP BY `Account Executive`;


/*OPPORTUNITY BY REVENUE TOP-4*/ 

select * from opportunities_by_revenue_top_4;

CREATE VIEW opportunities_by_revenue_top_4 AS
SELECT opportunity_name,revenue_amount
FROM opportunity
ORDER BY revenue_amount DESC
LIMIT 4;


/*STAGE FUNNEL BY REVENUE */

select * from stage_funnel_by_revenue;

CREATE VIEW stage_funnel_by_revenue AS
SELECT 
    stage,
    SUM(revenue_amount) AS total_revenue,
    COUNT(*) AS total_opportunities
FROM 
    opportunity
GROUP BY 
    stage;


/*OPEN OPPORTUNITY TOP -4 */

select * from open_opportunities_top_4;

CREATE VIEW open_opportunities_top_4 AS
SELECT 
    opportunity_name,
    revenue_amount,
    CASE 
        WHEN stage = 'Negotiate' THEN 'Closed'
        ELSE 'Open'
    END AS status
FROM 
    opportunity
WHERE 
    stage != 'Closed'
ORDER BY 
    revenue_amount DESC
LIMIT 4;



/*OPPORTUNITY PRODUCT DISTRIBUTION */

select * from opportunity_product_distribution;

CREATE VIEW opportunity_product_distribution AS
SELECT product_group, COUNT(DISTINCT opportunity_name) AS total_opportunities
FROM opportunity
GROUP BY product_group;








    