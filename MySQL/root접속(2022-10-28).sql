-- 여기는 주석문
-- 여기는 root 로 접속한 화면입니다
-- SELECT : DB Server에 뭔가를 요청하는 명령 키워드
SELECT 30+40;
SELECT '대한민국만세';
-- || : Oracle 에서 문자열 연결, '대한민국' || '만세'
SELECT CONCAT('대한민국', '만세');

-- world SCHEMA 를 open 하기
-- SCHEMA = DATABASE (SW 입장, 관리자 입장, 개발자 입장)
-- DB : DBMS SW, 저장소, 학문적 의 뜻을 담고 있다
USE world; -- 1. DB 를 open 하고

-- * : 전부 ,  ? : 일부
SELECT *
FROM city; -- 2. city table 에서 데이터를 SELECT(선택)하여 보여주기

SELECT *
FROM city
-- WHERE 조건절에 조건을 부여하여
-- 필요한 데이터만 제한적으로 SELECT 하기
WHERE District = 'Noord-Holland';

SELECT *
FROM 학생테이블
WHERE 이름 = '홍길동';

SELECT *
FROM city
WHERE Name = 'Alkmaar';

SELECT *
FROM city;

-- Selection 조회
-- 데이터 개수를 축소하여 필요한 데이터 들만 보기
SELECT *
FROM city
WHERE Name = 'Herat';

-- Projection 조회
-- 데이터의 항목을 축소하여 필요한 항목(칼럼) 들만 보기
SELECT Name, Population
FROM city;

-- Selection 과 Projection 을 동시에 적용하기
SELECT District, Population
FROM city
WHERE Name = 'Herat';

-- district 칼럼에 저장된 데이터들을 한 묶음으로 묶고
-- 묶음에 포함된 데이터들의 개수를 세어서 보여주기
SELECT district, count(district)
FROM city
GROUP BY district;

-- 성적테이블에서 각 과목의 총점과 평균 계산하여 보여주기
SELECT 과목,SUM(점수),AVG(점수)
FROM 성적테이블
GROUP BY 과목;

-- 학생별 총점과 평균 계산하여 보여주기
SELECT 학번, 이름, SUM(점수),AVG(점수)
FROM 성적테이블
GROUP BY 학번, 이름;

SELECT 학번, 이름, SUM(점수),AVG(점수)
FROM 성적테이블
GROUP BY 학번, 이름
ORDER BY 학번;

/*
city table 에서 인구(Population)가 1만 이상인 도시들만
찾으시오
*/
SELECT *
FROM city
WHERE Population >=10000;

/*
city table 에서 인구가 1만 이상인 도시들을
인구가 많은 순서대로 조회하기
*/
SELECT *
FROM city
WHERE Population >=10000
ORDER BY Population DESC;

/*
city table 에서 인구가 1만 이상 5만 이하인
도시들의 인구 평균을 구하시오
*/

SELECT avg(Population)
FROM city
WHERE Population >=10000 and Population <=50000;

/*
city table 에서 인구가 1만 이상 5만 이하인
도시들의 국가별(CountryCode) 인구 평균을 구하시오

통계( count(), sum(), avg(), max(), min() ) 와 관련된 SQL은
반드시 Projection 을 수행하여 칼럼을 제한해야 한다.
Projectin 칼럼중에 통계 함수로 묶지 않은 칼럼은
반드시 GROUP BY 절에서 명시해 주어야 한다
*/

SELECT CountryCode, avg(Population)
FROM city
WHERE Population >=10000 and Population <=50000
GROUP BY CountryCode
ORDER BY CountryCode;

-- 범위를 부여하는 조건절에서
-- ~~이상 AND ~~이하 의 조건일때
SELECT CountryCode, avg(Population)
FROM city
WHERE  Population BETWEEN 10000 and 50000
GROUP BY CountryCode
ORDER BY CountryCode;

/*
city table 에서
각 국가별 인구 평균을 계산하고
인구 평균이 5만 이상인 국가만 조회

먼저 국가별 인구평균을 계산하고
계산된 인구평균이 5만 이상인 경우
avg() 함수로 계산결과에 조건을 부여하기 때문에
이러한 경우는 WHERE 가 아니고
HAVING 절을 GROUP BY 절 아래둔다
*/

SELECT CountryCode AS 국가, avg(Population) 평균인구수
FROM city
WHERE 50000 <= (SELECT AVG(Population))
GROUP BY CountryCode
ORDER BY avg(Population) asc;


SELECT CountryCode, avg(Population)
FROM city
GROUP BY CountryCode
HAVING avg(Population) >= 50000;

/*
각 국가별(그룹을 묶어서)로 가장 인구가 많은 도시는?

MAX() 함수는 각 그룹에서 최대 값을 찾는 함수이다
이 함수를 사용할때 특이한 점이
한개의 칼럼(name, 도시명)을 GROUP BY 로 묶지 않고
코드를 실행하면 인구가 가장 많은 도시의 이름을 알수 있다
*/

-- AS 이름 변경 (생략가능 다른 SW에서는 오류가 나올수 있음)
SELECT name AS 도시, CountryCode AS 국가, MAX(Population) AS 인구수
FROM city
GROUP BY CountryCode
ORDER BY MAX(Population) desc;

SELECT * FROM country;

/*
cointry table에서
각 국가별 GNP 값이 큰도시부터 리스트 조회
단, GNP 1000 이상인 국가
*/

SELECT Name, MAX(GNP)
FROM country
GROUP BY Name
HAVING MAX(GNP)>=1000
ORDER BY MAX(GNP) desc;

/*
city table 과 cointry table 을 참조하여
인구가 1만 이상 5만 이하인 도시의 국가 이름이 무엇인가 조회하기
*/

select C.code 국가, T.name 도시, T.Population 인구
from city T, country C
WHERE T.CountryCode = C.code
and T.Population BETWEEN 10000 and 50000
ORDER BY T.Population asc;

/*
DBMS (DataBase Managiment System)
1. 많은 데이터를 스토리지에 보관하관리하는 소프트웨어
2. 스토리지에 보관된 많은 데이터 중에서 원하는 조건의 데이터를 쉽게 조회할 수 있게 구성된 소프트 웨어
RDBMS (RelationShip DataBase Managiment System)
1. E(Entity) - R(Relation) 관계형 데이터베이스 시스템
2. 많은 데이터를 관리하는 데이터베이스 소프트웨어중
   모든 데이터를 "Table(테이블)" 이라는 관점으로 DB를 관리하는 시스템
3. SQL(Structed Query Lang.)명령어를 사용하여 데이터를 관리
NoSQL(Not Only SQL)
1. RDMS 의 table 구조 DB 가 아닌 Document(JSON) 구조의 DB에 데이터 저장
2. 짧은 시간에 대량(Big)의 데이터를 추가하고, 대량의 데이터를 분석 구조화 가능
*/