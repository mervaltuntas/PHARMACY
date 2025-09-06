--  1 ) Write a query that returns, per year and per product, the total sales amount (Fiyat * Adet) and total quantity

SELECT YEAR(S.SatisTarihi) AS Yil, 
       U.UrunID, 
       SUM(S.Adet) AS ToplamAdet, 
       SUM(S.Adet * U.Fiyat) AS ToplamTutar
FROM Satis S
JOIN Urun U ON S.UrunID = U.UrunID
GROUP BY YEAR(S.SatisTarihi), U.UrunID;
