/*Quantitat de registres de la taula de vols:*/

SELECT COUNT(*) FROM my_database.flights;

/*Retard promig de sortida i arribada segons l’aeroport origen*/

SELECT Origin, AVG(ArrDelay), AVG(DepDelay) FROM my_database.flights GROUP BY Origin ORDER BY Origin desc;

/*Retard promig d’arribada dels vols, per mesos i segons l’aeroport origen.*/

SELECT Origin, Year, Month,  
if (AVG(ArrDelay)>=1, 'RETRASO','')
FROM my_database.flights  WHERE ArrDelay >=1
GROUP BY Origin, Year, Month ORDER BY Origin, Year, Month;

/*Les companyies amb més vols cancelats. A més, han d’estar ordenades de forma
que les companyies amb més cancelacions apareguin les primeres.*/

SELECT City, Year, Month, if (AVG(ArrDelay)>=1,'RETRASO','')
FROM my_database.flights INNER JOIN my_database.airports on my_database.flights.Origin =
my_database.airports.iata WHERE ArrDelay >=1
GROUP BY city, Year, Month ORDER BY city, Year, Month;

/*L’identificador dels 10 avions que més distància han recorregut fent vols.*/

Select sum(distance) AS distance, TailNum FROM my_database.flights where TailNum != 'NA'
group by TailNum order by distance desc limit 10;

/*Companyies amb el seu retard promig només d’aquelles les quals els seus vols
arriben al seu destí amb un retràs promig major de 10 minuts.*/

SELECT Description, AVG(ArrDelay)
FROM my_database.flights LEFT JOIN my_database.carriers on my_database.flights.UniqueCarrier =
my_database.carriers.Code WHERE ArrDelay > 10
GROUP BY Description ORDER BY AVG(ArrDelay);