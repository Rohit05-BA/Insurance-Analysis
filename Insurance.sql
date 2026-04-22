CREATE DATABASE insurance;
use insurance;
#1 Target FY (Total Target)
SELECT 
  SUM(`New Budget` + `Cross sell budget` + `Renewal Budget`) AS target_fy
FROM individual budgets;

#2. Placed Achievement
SELECT 
  SUM(premium_amount) AS placed_achievement
FROM opportunity
WHERE stage = 'Closed Won';

#3. Invoiced Achievement 
SELECT 
  SUM(Amount) AS invoiced_achievement
FROM invoice;

#4 Percentage of Achievement
SELECT 
  (SUM(a.Amount) /
   SUM(b.`New Budget` + b.`Cross sell bugdet` + b.`Renewal Budget`)) * 100
   AS achievement_percentage
FROM invoice a
CROSS JOIN budgets b;

#5 Number of Meetings
SELECT 
  COUNT(*) AS no_of_meetings
FROM meeting;

#6 Open Opportunities
SELECT 
  COUNT(*) AS open_opportunity
FROM opportunity
WHERE stage IN ('Qualify Opportunity', 'Propose Solution', 'Negotiate');

#7 Closed won
SELECT 
  COUNT(*) AS closed_won
FROM opportunity
WHERE stage = 'Closed Won';

#8 Number of Invoices by Account Executive
SELECT 
  `Account Executive`,
  COUNT(invoice_number) AS no_of_invoices
FROM invoice
GROUP BY `Account Executive`;

#9 Yearly Meetings
SELECT 
  YEAR(meeting_date) AS Year,
  COUNT(*) AS Yearly_meetings
FROM meeting
GROUP BY YEAR(meeting_date);

#10 Cross Sell – Target, Achieved, New
SELECT
  SUM(b.`Cross sell bugdet`) AS target,
  SUM(o.revenue_amount) AS achieved,
  COUNT(o.opportunity_id) AS new
FROM budgets b
LEFT JOIN opportunity o
  ON b.`Account Exe ID` = o.`Account Exe Id`
WHERE o.product_group = 'Cross Sell'; 

#11 New Business – Target, Achieved, New
SELECT
  SUM(b.`New Budget`) AS target,
  SUM(o.revenue_amount) AS achieved,
  COUNT(o.opportunity_id) AS new
FROM budgets b
LEFT JOIN opportunity o
  ON b.`Account Exe ID` = o.`Account Exe Id`
WHERE o.product_group = 'New';

#12 Renewal – Target, Achieved, New
SELECT
  SUM(b.`Renewal Budget`) AS target,
  SUM(o.revenue_amount) AS achieved,
  COUNT(o.opportunity_id) AS new
FROM budgets b
LEFT JOIN opportunity o
  ON b.`Account Exe ID` = o.`Account Exe Id`
WHERE o.product_group = 'Renewal';

#13 Stage Funnel by Revenue
SELECT stage,
  SUM(revenue_amount) AS revenue
FROM opportunity
GROUP BY stage
ORDER BY revenue DESC;

#14 Number of Meetings by Account Executive
SELECT 
  `Account Executive`,
  COUNT(*) AS meeting_count
FROM meeting
GROUP BY `Account Executive`;

#15 Top Open Opportunities
SELECT opportunity_name,
  revenue_amount
FROM opportunity
WHERE stage <> 'Closed Won'
ORDER BY revenue_amount DESC
LIMIT 10;

