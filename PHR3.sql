-- 2 )For each year, identify the product with the highest sales amount.

SELECT 
    YEAR(Satis.SatisTarihi) AS Yil,
    Urun.UrunAdi,
    SUM(Satis.Adet * Urun.Fiyat) AS ToplamTutar
FROM Satis
JOIN Urun ON Satis.UrunID = Urun.UrunID
WHERE Satis.SatisTarihi IS NOT NULL
GROUP BY YEAR(Satis.SatisTarihi), Urun.UrunAdi
HAVING SUM(Satis.Adet * Urun.Fiyat) = 
(
    SELECT MAX(UrunToplam.Toplam)
    FROM 
    (
        SELECT SUM(S2.Adet * U2.Fiyat) AS Toplam
        FROM Satis S2
        JOIN Urun U2 ON S2.UrunID = U2.UrunID
        WHERE YEAR(S2.SatisTarihi) = YEAR(Satis.SatisTarihi)
        GROUP BY U2.UrunAdi
    ) AS UrunToplam
);
