USE PHARMACY 

-- Question 1: Performance & Scalability Analysis in Hospital Data

----Scenario:
--A table below has been used for 5 years in a Hospital Information Management System (HBYS). Each day, about
--25,000 rows are inserted.
--Recently, queries on this table have become slower and users have reported difficulty accessing past records.

--CREATE TABLE HastaIslemLog (
-- Id INT IDENTITY(1,1) PRIMARY KEY,
-- HastaId INT,
-- IslemTarihi DATETIME,
-- IslemKodu NVARCHAR(20),
-- Aciklama NVARCHAR(500)
--);

--Question:
--1. What could be the reasons for the performance degradation?
--2. What improvements would you suggest for better sustainability?
--3. Do you think using the table in this way for 5 years was the correct approach? Why or why not?
----Note: Open-ended. Focus on reasoning, not just query writing.




--Answers:

-- 1 : Reasons for performance degradation;

-- a) Too much data entry.
-- b) Trying to collect all the data in one table.
-- c) Trying to search for historical records from a table where records are still being entered.(I need to archive old records.)
-- d) Since the index is not used, the system scans all the data in the table for the relevant data.
-- CREATE NONCLUSTERED INDEX IN_HastaIslemLog
-- ON HastaIslemLog (HastaId, IslemTarihi)
-- INCLUDE (IslemKodu, Aciklama);  -->  Nonclustered index only holds the key columns and if we need to search for data from a different column,
--                                      it will first scan the indexes and then return to the table and scan, which causes a slowdown in performance.
--                                      If we use INCLUDE, it will add the additional columns to the index and will not return to the table.



-- 2 : Improvement Recommendations For Sustainability ;

-- a) First, the archiving needs to be done.The existing active table is reduced and the existing archive table is enlarged.
-- b) Adding a clustered index to the most used column

-- 3 : Is it correct to use the table in this way for 5 years?
-- No it isn't. Loading millions of data into a table will cause it to slow down and become dysfunctional. 
-- And after a while, various problems occur and data corruption and crashes occur.


--Question 2: Index Strategy & Query Optimization Thinking

--Scenario:

--The following query is frequently used by end users:

--SELECT *
--FROM HastaKayit
--WHERE LOWER(AdSoyad) LIKE '%ahmet%' AND YEAR(KayitTarihi) = 2024

--Question:
--1. What performance problems might arise from this query?
--2. How would you optimize this query and/or the table structure?
--3. Are there any improvements that could be made on the application side?
-- Note: Expect analysis and optimization suggestions.


--Answers:

-- 1: Performance Problems

-- Since Select * is used, there is a performance slowdown due to unnecessary column reading.
-- If a function is applied to the column, the index is disabled and this causes a performance slowdown.
-- If we only write the year in the date section, it will scan the entire year, but if we write a range, we will reach the result faster.

-- 2:Optimization

--  SELECT Id, HastaId, AdSoyad, KayitTarihi
--  FROM HastaKayit
--  WHERE AdSoyad LIKE 'ahmet%'   
--  AND KayitTarihi >= '2024-01-01'
--  AND KayitTarihi < '2024-12-30';

-- 3:Development

--CREATE NONCLUSTERED INDEX InKayitTarihi
--ON HastaKayit (KayitTarihi);
--CREATE NONCLUSTERED INDEX InAdSoyad
--ON HastaKayit (AdSoyad);

