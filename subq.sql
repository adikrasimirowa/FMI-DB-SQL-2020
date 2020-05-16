---ПОДЗАЯВКИ - ЗАЯВКА В ЗАЯВКАТА/ЧАСТ ОТ ДРУГА ЗАЯВКА---
---ВРЩАТ КАТО РЕЗУЛТАТ:
---КОНСТАНТА
--СПИСЪК ОТ СТОЙНОСТИ
--РЕЛАЦИЯ

-- КОРЕЛАТИВНАИТЕ ЗЯВКИ СА БАВНИ И Е ХУБАВО ДА СЕ ИЗБЯГВАТ
--АГРЕГАТНИ ФУНКЦИИ - MIN,MAX,ALL,COUNT,SUM,AVG,STDDEV, VARIANCE - ИГНОРИРАТ NULL СТОЙНОСТИ


----------ЗАДАЧА-------

--  Напишете заявка, която извежда имената на актрисите, които са също и
-- продуценти с нетна стойност по-голяма от 10 милиона.
SELECT *FROM  MOVIESTAR
WHERE NAME IN  (SELECT NAME
                FROM MOVIEEXEC
                WHERE NETWORTH >100000000);

-- Напишете заявка, която извежда имената на тези актьори (мъже и жени), които
-- не са продуценти.
SELECT *FROM  MOVIESTAR
WHERE NAME NOT IN  (SELECT NAME
                FROM MOVIEEXEC );

-- Напишете заявка, която извежда имената на всички филми с дължина по-голяма
-- от дължината на филма ‘Gone With the Wind’
SELECT *
FROM MOVIE
WHERE LENGTH > ALL (SELECT LENGTH
                    FROM MOVIE
                    WHERE  TITLE = 'Gone With the Wind');  --AKO E "ANY" ВРЪЩА СПИСЪК ОТ ТРИ СТОЙНОСТИ
--  Напишете заявка, която извежда имената на продуцентите и имената на
-- продукциите за които стойността им е по-голяма от продукциите на продуценти
-- ‘Merv Griffin’
SELECT ME.NAME,M.TITLE,ME.NETWORTH
FROM MOVIEEXEC ME, MOVIE M
WHERE ME.CERT# = M.PRODUCERC#
AND  ME.NETWORTH > (SELECT  NETWORTH FROM MOVIEEXEC WHERE NAME = 'Merv Griffin');
--  Напишете заявка, която извежда името на филмите с най-голяма дължина по
-- студио

 SELECT STUDIONAME,TITLE,LENGTH
 FROM MOVIE M
WHERE  LENGTH = (SELECT MAX(LENGTH)
                FROM MOVIE
                WHERE  STUDIONAME = M.STUDIONAME);


---ИЗВЕЖДА ФИЛМА С НАЙ-ДЪЛГА ПРОДЪЛЖИТЕЛНОСТ
SELECT S.NAME,M.TITLE
FROM STUDIO S, MOVIE M
WHERE S.NAME = M.STUDIONAME
AND M.LENGTH = (SELECT MAX(LENGTH)
FROM MOVIE);

SET SCHEMA  DB2SHIPS;

-- Напишете заявка, която извежда страните, чиито кораби са с най-голям брой
-- оръжия. - ПОДХОД ЗА НАМИРАНЕ  НА МАКС
SELECT DISTINCT COUNTRY,NUMGUNS
FROM CLASSES
WHERE NUMGUNS = (
        SELECT  MAX(NUMGUNS) FROM CLASSES
    );

-- Напишете заявка, която извежда класовете, за които поне един от корабите им е
-- потънал в битка.

SELECT DISTINCT M.CLASS, O.RESULT
FROM  SHIPS M, OUTCOMES O
WHERE  M.NAME = O.SHIP
AND O.RESULT = 'sunk';

-- С ПОДЗАЯВКА
SELECT  DISTINCT CLASS
FROM  SHIPS
WHERE  NAME IN (SELECT  SHIP
    FROM OUTCOMES
    WHERE  RESULT ='sunk');

-- Напишете заявка, която извежда имената на корабите с 16 инчови оръдия (bore).
SELECT  NAME
FROM SHIPS
WHERE  CLASS IN ( SELECT  CLASS FROM CLASSES WHERE  BORE=16);

-- Напишете заявка, която извежда имената на битките, в които са участвали
-- кораби от клас ‘Kongo’.

SELECT  BATTLE
FROM  OUTCOMES
 WHERE  SHIP IN  (SELECT NAME
                FROM  SHIPS
                WHERE  CLASS = 'Kongo ');
-- Напишете заявка, която извежда иманата на корабите,
-- чиито брой оръдия е найголям в сравнение с корабите със същия калибър оръдия (bore).

SELECT DISTINCT  S.NAME,C.BORE
FROM CLASSES C, SHIPS S
WHERE S.CLASS = C.CLASS
 AND
      BORE = (
        SELECT  MAX(BORE) FROM CLASSES
    );