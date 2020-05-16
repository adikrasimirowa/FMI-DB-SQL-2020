-----------ФУНКЦИИ-------
--СКАЛАРНИ ФУНКЦИИ---
--ЗА ОБРАБОТКА НА НИЗОВЕ:
---LOWER,UPPER,LENGTH,SUBSTR,REPLACE,TRIM, CONCAT
-------------------
---ЗА ОБРАБОТКА НА ЧИСЛА:
---ROUND, DECIMAL
-------------------
--ЗА ОБРАБОТКА НА ДАТИ:
--CURREBT_DATE, YEAR
------------------
--ОБЩИ ФУНКЦИИ:
--COALESCE(expr1,expr2,...)


SET SCHEMA DB2INST1;
-- Зад 1. Да се напише заявка, която извежда име на служител (
-- firstnme, lastname - в една колона, конкатенирани), рождена дата и дата на наемане, за тези служители които са наети в същата седмица,
-- в която са имали и рожден ден. Пример: Рожденна дата на служител: 06.11.1998, дата на наемане на служител: 08.11.2018.
-- Рождения ден на служителя е във вторник, дата на наемане - четвъртък.
SELECT FIRSTNME || ' '|| LASTNAME AS ENAME,BIRTHDATE, HIREDATE,
       DATE(YEAR(HIREDATE) || '-'||  MONTH(BIRTHDATE) || '-' || DAY (BIRTHDATE)) AS BHDATE
FROM EMPLOYEE
WHERE WEEK(HIREDATE) = WEEK_ISO(DATE(YEAR(HIREDATE) || '-'||  MONTH(BIRTHDATE) || '-' || DAY (BIRTHDATE)) );
-- Зад 2. Напишете заявка, която извежда имената и рождените дати на тези служители, за които е изпълнено, че са родени във високосна
-- година и едновременно с това са и една и съща зодия по китайския календар. Да се счита, че всички родени с 12 години разлика са една и съща зодия по китайския календар.
SELECT E1.FIRSTNME || ' '|| E1.LASTNAME AS E1_NAME, E1.BIRTHDATE AS E1_BDATE,
       E2.FIRSTNME || ' '|| E2.LASTNAME AS E2_NAME, E2.BIRTHDATE AS E1_BDATE
FROM EMPLOYEE E1, EMPLOYEE E2
WHERE  E1.EMPNO < E2.EMPNO
AND (MOD(YEAR(E1.BIRTHDATE),4)=0 AND MOD(YEAR(E1.BIRTHDATE),100)!=0) OR MOD(YEAR(E1.BIRTHDATE),400) = 0
AND (MOD(YEAR(E2.BIRTHDATE),4)=0 AND MOD(YEAR(E2.BIRTHDATE),100)!=0) OR MOD(YEAR(E2.BIRTHDATE),400) = 0
AND MOD(YEAR(E1.BIRTHDATE),12) = MOD(YEAR(E2.BIRTHDATE),12);

-- Зад 3. Напишете заявка, която извежда рождената дата и
-- имената на тези служители родени на една и съща дата.
-- Изведете имената на служителите по шаблона (E1_LASTNAME, E2_LASTNAME).
-- Повтарящите се двойки от вида (E2_LASTNAME, E1_LASTNAME) да не се извеждат в резултата.
SELECT  ' ('|| E1.LASTNAME || ','|| E2.LASTNAME || ')' AS PAIRS
FROM EMPLOYEE E1, EMPLOYEE E2
WHERE  E1.EMPNO < E2.EMPNO
    AND
MONTH(E1.BIRTHDATE) = MONTH(E2.BIRTHDATE)
AND DAY(E1.BIRTHDATE) = DAY(E2.BIRTHDATE)
ORDER  BY PAIRS;

-- Зад 4. Да се напише заявка, която извежда номер на административен отдел, име на административен отдел, номера и имена на подчинените му отдели и броя на работещите служители за всеки един от подчинените му отдели, за всички административни отдел без отдел с номер E01. Ако в отделите няма нито един работещ служител да се изведе 0.
--
--
-- Зад 5. Да се напише заявка, която намира имената на служителя с най-висока заплата.

