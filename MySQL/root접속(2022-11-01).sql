-- 여기는 root 화면
use world;
SELECT * FROM country ORDER BY name;

-- name 칼럼에 저장된 문자열을 정확히 검색할때
SELECT * FROM country WHERE name = 'South korea';

-- 중간문자열, like 연산자 검색
-- %문자열 : 문자열로 끝나는 모든 데이터
SELECT * FROM country WHERE name LIKE '%korea';

-- 문자열% : 문자열로 시작하는 모든 데이터
SELECT * FROM country WHERE name LIKE 'kor%';

-- %문자열% : 문자열을 포함하고 있는 모든 데이터
SELECT * FROM country WHERE name LIKE '%korea%'
ORDER BY code;

SELECT * FROM country WHERE name LIKE CONCAT ('%','korea','%')
ORDER BY code;