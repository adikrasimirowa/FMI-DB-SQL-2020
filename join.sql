SET SCHEMA DB2MOVIES;

SELECT * FROM STARSIN;

SELECT * FROM MOVIESTAR;


---ВРТЗКА МЕЖДУ ДВЕ ТАБЛИЦИ
--AS STAR_NAME СТИЛИЗИРА КАК ЩЕ ИЗГЛЕЖДА ИМАЕТО НА КОЛОНАТА
SELECT M.NAME AS STAR_NAME, M.BIRTHDATE, S.MOVIETITLE
FROM MOVIESTAR M, STARSIN S
WHERE  M.NAME = S.STARNAME
--- AND  M.BIRTHDATE > '1949-12-31'
AND YEAR(M.BIRTHDATE) >= 1950 --ВЗИМА САМО ГОДИНАТА
ORDER  BY M.NAME;

---ЗАДАЧИ---
--Напишете заявка, която извежда имената на актьорите мъже участвали в ‘Terms of Endearment’
SELECT M.NAME FROM MOVIESTAR M, STARSIN S
WHERE M.NAME = S.STARNAME
AND M.GENDER ='M'
AND  S.MOVIETITLE ='Terms of Endearment';

-- Напишете заявка, която извежда имената на актьорите участвали във филми продуцирани от ‘MGM’през 1995 г.
SELECT S.STARNAME, M.STUDIONAME, S.MOVIEYEAR FROM MOVIE M, STARSIN S
WHERE M.TITLE = S.MOVIETITLE
AND M.YEAR = S.MOVIEYEAR --- ПРЕРАВНЯВА МЕ ГИ, КАКВОТО И ДА ПИШЕМ СЛЕД ТОВА СА РАВНИ
AND M.STUDIONAME = 'MGM'
AND M.YEAR = 1995;

-- Напишете заявка, която извежда името на президента на ‘MGM’
SELECT DISTINCT ME.NAME, M.STUDIONAME --БЕЗ ПОВТОРЕНИЕ DISTICNT
FROM MOVIEEXEC ME, MOVIE M
WHERE ME.CERT# = M.PRODUCERC#
AND  M.STUDIONAME = 'MGM'
ORDER BY 1 DESC ; -- В НАМАЛЯВАЩ РЕД/ПО ПЪТВА КОЛОНА

-- Напишете заявка, която извежда имената на всички филми с дължина по-голяма от дължината на филма ‘Gone With the Wind’
SELECT  M1.TITLE, M1.YEAR, M1.LENGTH, M2.TITLE, M2.YEAR, M2.LENGTH
FROM MOVIE M1, MOVIE M2
WHERE  M2.TITLE = 'Star Trek'
AND M1.LENGTH > M2.LENGTH;

-- Напишете заявка, която извежда имената на тези продукции на стойност поголяма от продукциите на продуценти ‘Merv Griffin’

SELECT DISTINCT ME.NAME, M.TITLE, ME.NETWORTH
FROM MOVIEEXEC ME, MOVIE M, MOVIE M1, MOVIEEXEC M2
WHERE ME.CERT# = M.PRODUCERC#
AND M1.PRODUCERC# = M2.CERT#
AND  ME.NAME = 'Merv Griffin'
AND M2.NETWORTH > ME.NETWORTH;

SET SCHEMA  DB2SHIPS;

SELECT S.NAME, C.DISPLACEMENT
FROM  CLASSES C, SHIPS S
WHERE C.CLASS = S.CLASS
AND DISPLACEMENT >15000
AND S.LAUNCHED =1940;
