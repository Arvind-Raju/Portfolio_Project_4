
-- CONVERTING DATE TIME FROMAT TO DATE AND TIME FOR USABILITY

ALTER TABLE [BIXI].[dbo].[2021_donnees_ouvertes]
ADD s_date date
UPDATE [BIXI].[dbo].[2021_donnees_ouvertes]
SET s_date = CONVERT(date,start_date)

ALTER TABLE [BIXI].[dbo].[2021_donnees_ouvertes]
ADD s_time time(0)
UPDATE [BIXI].[dbo].[2021_donnees_ouvertes]
SET s_time = CONVERT(time(0),start_date)

ALTER TABLE [BIXI].[dbo].[2021_donnees_ouvertes]
ADD e_date date, e_time time(0)
UPDATE [BIXI].[dbo].[2021_donnees_ouvertes]
SET e_date = CONVERT(date,end_date), e_time = CONVERT(time(0),end_date)

---------------------------------------------------------------------------------------------------------------------------------------

-- FINDING NUMBER OF RIDES PER DAY

 SELECT DATENAME(dw, s_date) as day,s_date,  COUNT(emplacement_pk_start) as No_of_rides
    FROM [BIXI].[dbo].[2021_donnees_ouvertes]
GROUP BY s_date
ORDER BY s_date
---------------------------------------------------------------------------------------------------------------------------------------

--FINDING RELATION BETWEEN NUMBER OF RIDES AND WEATHER DATA

 SELECT   s_date,DATENAME(dw, s_date) as day, COUNT(emplacement_pk_start) as No_of_rides, max_temp, min_temp, mean_temp, total_rain_mm
 FROM [BIXI].[dbo].[2021_donnees_ouvertes] a
 JOIN [BIXI].[dbo].[en_climate_daily_QC_7025251_2021_P1D] b
 ON a.s_date= b.date
 GROUP BY a.s_date,max_temp, min_temp, mean_temp, total_rain_mm
ORDER BY a.s_date
---------------------------------------------------------------------------------------------------------------------------------------

--FINDING TOP 10 POPULAR STATIONS FOR INCOMING AND OUTGOING RIDES

SELECT top 10 name,COUNT(emplacement_pk_start) as no_of_outgoing_rides, latitude,longitude
 FROM [BIXI].[dbo].[2021_donnees_ouvertes]
 JOIN [BIXI].[dbo].[2021_stations]
 ON emplacement_pk_start = pk
 GROUP BY emplacement_pk_start, name, latitude, longitude
 ORDER BY no_of_outgoing_rides DESC 
 
 SELECT top 10 name,COUNT(emplacement_pk_end) as no_of_incoming_rides, latitude,longitude 
 FROM [BIXI].[dbo].[2021_donnees_ouvertes]
 JOIN [BIXI].[dbo].[2021_stations]
 ON emplacement_pk_end = pk
 GROUP BY emplacement_pk_end, name, latitude,longitude
 ORDER BY no_of_incoming_rides DESC
----------------------------------------------------------------------------------------------------------------------------------------

-- FINDING NUMBER OF RIDES PER TIME INTERVAL

 SELECT COUNT(*)
  FROM [BIXI].[dbo].[2021_donnees_ouvertes]
WHERE s_time between '08:00:00' AND '12:00:00'

 SELECT COUNT(*)
  FROM [BIXI].[dbo].[2021_donnees_ouvertes]
WHERE s_time between '12:00:00' AND '16:00:00'

 SELECT COUNT(*)
  FROM [BIXI].[dbo].[2021_donnees_ouvertes]
WHERE s_time between '16:00:00' AND '20:00:00'

 SELECT COUNT(*)
  FROM [BIXI].[dbo].[2021_donnees_ouvertes]
WHERE s_time between '20:00:00' AND '23:59:59'

 SELECT COUNT(*)
  FROM [BIXI].[dbo].[2021_donnees_ouvertes]
WHERE s_time between '00:00:00' AND '04:00:00'

 SELECT COUNT(*)
  FROM [BIXI].[dbo].[2021_donnees_ouvertes]
WHERE s_time between '04:00:00' AND '08:00:00'
