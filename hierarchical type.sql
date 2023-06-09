-- ZADANIE 1		

CREATE TABLE planeta (nazwa VARCHAR (30), poziom hierarchyid)

INSERT INTO planeta VALUES
('Planeta','/'),
('Europa','/1/'),
('Ameryka poludniowa','/2/'),
('Francja','/1/1/'),
('Chorwacja','/1/2/'),
('Brazylia','/2/1/'),
('Kolumbia','/2/2/'),
('Paryz','/1/1/1/'),
('Marsylia','/1/1/2/'),
('Dubrvnik','/1/2/1/'),
('Split','/1/2/2/'),
('Sao Paulo','/2/1/1/'),
('Salvador','/2/1/2/'),
('Bogota','/2/2/1/'),
('Cali','/2/2/2/'),
('Avenue Victor-Hugo','/1/1/1/1/'),
('Avenue Saint Antoine','/1/1/2/1/'),
('La canebierer','/1/1/2/2/'),
('Le marche o poisson','/1/1/2/3/'),
('Placa','/1/2/1/1/'),
('Marmontova','/1/2/2/1/'),
('Avenida Paulista','/2/1/1/1/'),
('Da Bahia de Todos os Santos','/2/1/2/1/'),
('1995','/2/2/1/1/'),
('Alamedia','/2/2/2/1/')

SELECT nazwa, poziom.ToString() FROM planeta

-- ZADANIE 2

--a) wy�wietli� ca�� jedn� (wybran�) ga��� drzewa (od �wiata do ulicy)
--b*) doda� nowy kraj
--c) wy�wietli� nazw� kontynentu na kt�rym le�y miasto 'x'
--d) wy�wietli� nazwy wszystkich kraj�w
--e) sprawdzi� czy kraj 'x' le�y na kontynencie 'y'
--f) czy 'x' oraz 'y' s� krajami
--g) wy�wietli� wszystkie ulice miasta 'x'


--a) wy�wietli� ca�� jedn� (wybran�) ga��� drzewa (od �wiata do ulicy)

SELECT nazwa FROM planeta
WHERE poziom = '/1/1/2/2/' -- La canebier
OR poziom = '/1/1/2/'  -- Marsylia
OR poziom = '/1/1/' -- Francja
OR poziom = '/1/';     -- Europa 


--b*) doda� nowy kraj

INSERT INTO planeta VALUES ('Polska', '/1/3/'); 

SELECT * FROM planeta WHERE poziom.GetAncestor(1) = '/1/'; -- sprawdzam czy zadzialalo


--c) wy�wietli� nazw� kontynentu na kt�rym le�y miasto 'x'

SELECT nazwa Miasto, 
		(SELECT nazwa 
		FROM planeta 
		WHERE poziom = p.poziom.GetAncestor(2)) lezy_na_kontynencie
FROM planeta p
WHERE p.nazwa = 'Paryz';


--d) wy�wietli� nazwy wszystkich kraj�w

SELECT nazwa Wszystkie_kraje 
FROM planeta 
WHERE poziom.GetLevel() = 2;


--e) sprawdzi� czy kraj 'x' le�y na kontynencie 'y'

SELECT nazwa Kraj, 
	CASE 
	WHEN poziom.IsDescendantOf('/1/') = 1 --europa
	THEN 'Tak'
    ELSE 'Nie'
    END czy_lezy_w_europie,
	CASE 
	WHEN poziom.IsDescendantOf('/2/') = 1 --azja poludniowa 
	THEN 'Tak'
    ELSE 'Nie'
    END czy_lezy_w_azji_poludniowej
FROM planeta
WHERE nazwa = 'Francja';



--f) czy 'x' oraz 'y' s� krajami
SELECT nazwa Nazwa, 
	CASE 
	WHEN poziom.GetLevel() = 2
	THEN 'Tak'
	ELSE 'Nie'
	END Czy_jest_krajem
FROM planeta 
WHERE nazwa = 'Europa' OR nazwa = 'Francja';


--g) wy�wietli� wszystkie ulice miasta 'x'

SELECT nazwa Ulice
FROM planeta 
WHERE poziom.GetLevel() = 4 AND poziom.IsDescendantOf((SELECT poziom FROM planeta WHERE nazwa = 'Marsylia')) = 1;


-- ZADANIE 3

-- Struktur� drzewa z p.1 zapisa� bez u�ycia typu hierarchicznego

CREATE TABLE planeta2 (id_nazwa INT PRIMARY KEY IDENTITY ,
nazwa VARCHAR(40),
id_planeta INT)

INSERT INTO planeta2(nazwa) values('Planeta'), ('Europa'), ('Ameryka poludniowa'), 
('Francja'), ('Chorwacja'), ('Brazylia'), ('Kolumbia'), 
('Paryz'), ('Marsylia'), ('Dubrvnik'), ('Split'), ('Sao Paulo'), ('Salvador'), ('Bogota'), ('Cali'), 
('Avenue Victor-Hugo'), ('Avenue Saint Antoine'), ('La canebierer'),('Le marche o poisson'),('Placa'), 
('Marmontova'), ('Avenida Paulista'), ('Da Bahia de Todos os Santos'), ('1995'), ('Alamedia') 


update planeta2 set id_planeta=1 where id_nazwa in (2,3)
update planeta2 set id_planeta=2 where id_nazwa in (4,5)
update planeta2 set id_planeta=3 where id_nazwa in (6,7)
update planeta2 set id_planeta=4 where id_nazwa in (8,9)
update planeta2 set id_planeta=5 where id_nazwa in (10,11)
update planeta2 set id_planeta=6 where id_nazwa in (12,13)
update planeta2 set id_planeta=7 where id_nazwa in (14,15)
update planeta2 set id_planeta=8 where id_nazwa in (16)
update planeta2 set id_planeta=9 where id_nazwa in (17,18,19)
update planeta2 set id_planeta=10 where id_nazwa in (20)
update planeta2 set id_planeta=11 where id_nazwa in (21)
update planeta2 set id_planeta=12 where id_nazwa in (22)
update planeta2 set id_planeta=13 where id_nazwa in (23)
update planeta2 set id_planeta=14 where id_nazwa in (24)
update planeta2 set id_planeta=15 where id_nazwa in (25)

SELECT * FROM planeta2;



--a) wy�wietli� ca�� jedn� (wybran�) ga��� drzewa (od �wiata do ulicy)
--b*) doda� nowy kraj
--c) wy�wietli� nazw� kontynentu na kt�rym le�y miasto 'x'
--d) wy�wietli� nazwy wszystkich kraj�w
--e) sprawdzi� czy kraj 'x' le�y na kontynencie 'y'
--f) czy 'x' oraz 'y' s� krajami
--g) wy�wietli� wszystkie ulice miasta 'x'


--a) wyswietlic cala jedna (wybrana) galaz drzewa (od swiata do ulicy)

SELECT (SELECT nazwa from planeta2 WHERE nazwa = 'Planeta') Planeta, p1.nazwa Kontynent, p2.nazwa Kraj, p3.nazwa Miasto, p4.nazwa Ulica 
FROM planeta2 p1
JOIN planeta2 p2 ON p1.id_nazwa = p2.id_planeta
JOIN planeta2 p3 ON p2.id_nazwa = p3.id_planeta
JOIN planeta2 p4 ON p3.id_nazwa = p4.id_planeta
WHERE p4.nazwa = 'Placa'; -- wskazujemy ulcie dla ktorej chcemy wyswietlic galaz


--b*) dodac nowy kraj

INSERT INTO planeta2(nazwa, id_planeta) VALUES ('Polska', 2);

SELECT * FROM planeta2;


--c) wyswietlic nazwy kontynentu na ktorym lezy miasto 'x'

--SELECT *
--FROM planeta2 p1
--JOIN planeta2 p2 ON p1.id_nazwa = p2.id_planeta
--JOIN planeta2 p3 ON p2.id_nazwa = p3.id_planeta

SELECT p3.nazwa Miasto, p1.nazwa lezy_na_kontynencie
FROM planeta2 p1
JOIN planeta2 p2 ON p1.id_nazwa = p2.id_planeta
JOIN planeta2 p3 ON p2.id_nazwa = p3.id_planeta
WHERE p3.nazwa = 'Sao Paulo'; --wskazujemy miasto dla ktorego chcemy znalezc kontynent


--d) wyswietlic nazwy wszystkich krajow

--SELECT nazwa
--FROM planeta2
--WHERE id_planeta IN (2,3);

SELECT p2.nazwa Kraje
FROM planeta2 p1
JOIN planeta2 p2 ON p1.id_nazwa = p2.id_planeta
WHERE p1.id_planeta = 1;


--e) sprawdzic czy kraj 'x' lezy na kontynencie 'y'

SELECT p1.nazwa Kraj, 
	CASE WHEN p2.nazwa = 'Europa'
	THEN 'Tak'
	ELSE 'Nie'
	END Czy_lezy_na_kontynencie
FROM planeta2 p1
INNER JOIN planeta2 p2 ON p1.id_planeta=p2.id_nazwa
WHERE p1.nazwa = 'Francja';

SELECT p1.nazwa Kraj, 
	CASE WHEN p2.nazwa = 'Europa'
	THEN 'Tak'
	ELSE 'Nie'
	END Czy_lezy_na_kontynencie
FROM planeta2 p1
INNER JOIN planeta2 p2 ON p1.id_planeta=p2.id_nazwa
WHERE p1.nazwa = 'Salvador';

--f) czy 'x' oraz 'y' sa krajami

SELECT nazwa Nazwa, 
CASE WHEN nazwa IN (SELECT p2.nazwa Kraje
					FROM planeta2 p1
					JOIN planeta2 p2 ON p1.id_nazwa = p2.id_planeta
					WHERE p1.id_planeta = 1) 
	THEN 'Tak'
	ELSE 'Nie'
	END czy_jest_krajem
FROM planeta2
WHERE nazwa in ('Brazylia','Da Bahia de Todos os Santos')



--g) wyswietlic wszystkie ulice miasta 'x'

SELECT p2.nazwa Ulice
FROM planeta2 p1
INNER JOIN planeta2 p2 ON p1.id_nazwa=p2.id_planeta
WHERE p1.nazwa = 'Marsylia' -- wskazujemy ulice

