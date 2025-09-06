-- 3 ) Write a query to list products that were never sold.3. Write a query to list products that were never sold.

SELECT UrunAdi
FROM Urun
WHERE UrunID NOT IN (SELECT DISTINCT UrunID FROM Satis);
