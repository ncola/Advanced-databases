create database n_jarzabek
use n_jarzabek

drop table zamowienia_nj

create table zamowienia_nj (id_zamowienia int primary key identity, opis xml)


declare @zamowienie_1 xml = '<Zamowienie>
    <Klient>
      <Imie>Jan</Imie>
      <Nazwisko>Kowalski</Nazwisko>
      <Adres>ul. Kwiatowa 1, Warszawa</Adres>
    </Klient>
    <Produkt>
      <Nazwa>Książka</Nazwa>
      <Cena>29.99</Cena>
    </Produkt>
    <SzczegolyZamowienia>
      <Ilosc>2</Ilosc>
    </SzczegolyZamowienia>
    <Platnosc>
      <MetodaPlatnosci>Karta kredytowa</MetodaPlatnosci>
      <Kwota>59.98</Kwota>
    </Platnosc>
    <AdresDostawy>ul. Kwiatowa 1, Warszawa</AdresDostawy>
    <DataZamowienia>
        <Dzien>10</Dzien>
        <Miesiac>11</Miesiac> 
        <Rok>2022</Rok>
    </DataZamowienia>
  </Zamowienie>'

insert into zamowienia_nj values (@zamowienie_1)

declare @zamowienie_2 xml =  '<Zamowienie>
    <Klient>
      <Imie>Anna</Imie>
      <Nazwisko>Nowak</Nazwisko>
      <Adres>ul. Słoneczna 5, Kraków</Adres>
    </Klient>
    <Produkt>
      <Nazwa>Telewizor</Nazwa>
      <Cena>1999.99</Cena>
    </Produkt>
    <SzczegolyZamowienia>
      <Ilosc>1</Ilosc>
    </SzczegolyZamowienia>
    <Platność>
      <MetodaPlatnosci>Przelew bankowy</MetodaPlatnosci>
      <Kwota>1999.99</Kwota>
    </Platność>
    <AdresDostawy>ul. Słoneczna 5, Kraków</AdresDostawy>
    <DataZamowienia>
        <Dzien>5</Dzien>
        <Miesiac>01</Miesiac> 
        <Rok>2023</Rok>
    </DataZamowienia>
  </Zamowienie>'

insert into zamowienia_nj values (@zamowienie_2)


declare @zamowienie_3 xml = '<Zamowienie>
    <Klient>
      <Imię>Adam</Imię>
      <Nazwisko>Nowicki</Nazwisko>
      <Adres>ul. Leśna 10, Gdańsk</Adres>
    </Klient>
    <Produkt>
      <Nazwa>Smartfon</Nazwa>
      <Cena>899.99</Cena>
    </Produkt>
    <SzczegolyZamowienia>
      <Ilosc>3</Ilosc>
    </SzczegolyZamowienia>
    <Platnosc>
      <MetodaPlatnosci>Pobranie</MetodaPlatnosci>
      <Kwota>2699.97</Kwota>
    </Platnosc>
    <AdresDostawy>ul. Leśna 10, Gdańsk</AdresDostawy>
    <DataZamowienia>
        <Dzien>15</Dzien>
        <Miesiac>05</Miesiac> 
        <Rok>2023</Rok>
    </DataZamowienia>
  </Zamowienie>'

insert into zamowienia_nj values (@zamowienie_3)

SELECT * FROM zamowienia_nj




--schemat relacyjny 7 tabel
CREATE TABLE Zamowienia (
  id_zamowienia INT PRIMARY KEY IDENTITY,
  klient_id INT,
  produkt_id INT,
  szczegoly_id INT,
  platnosc_id INT,
  adres_dostawy VARCHAR(100),
  data_zamowienia DATE
);

CREATE TABLE Klienci (
  id_klienta INT PRIMARY KEY IDENTITY,
  imie VARCHAR(50),
  nazwisko VARCHAR(50),
  adres VARCHAR(100)
);

CREATE TABLE Produkty (
  id_produktu INT PRIMARY KEY IDENTITY,
  nazwa VARCHAR(50),
  cena DECIMAL(10, 2)
);

CREATE TABLE SzczegolyZamowienia (
  id_szczegolow INT PRIMARY KEY IDENTITY,
  ilosc INT
);

CREATE TABLE Platnosci (
  id_platnosci INT PRIMARY KEY IDENTITY,
  metoda_platnosci VARCHAR(50),
  kwota DECIMAL(10, 2)
);

ALTER TABLE Zamowienia
ADD FOREIGN KEY (klient_id) REFERENCES Klienci(id_klienta);

ALTER TABLE Zamowienia
ADD FOREIGN KEY (produkt_id) REFERENCES Produkty(id_produktu);

ALTER TABLE Zamowienia
ADD FOREIGN KEY (szczegoly_id) REFERENCES SzczegolyZamowienia(id_szczegolow);

ALTER TABLE Zamowienia
ADD FOREIGN KEY (platnosc_id) REFERENCES Platnosci(id_platnosci);





-- zapytanie wyświetlające daty złożenia zamówień

-- pierwszy sposob
SELECT 
    opis.value('(/Zamowienie/DataZamowienia)[1]', 'int') as data
FROM zamowienia_nj;

--nieczytelny zapis, nnowa wresja:
SELECT 
    CONCAT(
        opis.value('(/Zamowienie/DataZamowienia/Dzien)[1]', 'int'),
        '-',
        opis.value('(/Zamowienie/DataZamowienia/Miesiac)[1]', 'int'),
        '-',
        opis.value('(/Zamowienie/DataZamowienia/Rok)[1]', 'int')
    ) as data
FROM zamowienia_nj;

-- lub
SELECT 
    opis.value('(/Zamowienie/DataZamowienia/Dzien)[1]', 'int') as Dzien,
    opis.value('(/Zamowienie/DataZamowienia/Miesiac)[1]', 'int') as Miesiac,
    opis.value('(/Zamowienie/DataZamowienia/Rok)[1]', 'int') as Rok
FROM zamowienia_nj;





-- zapytanie wyświetlające informacje o zamawiających
SELECT
    opis.value('(/Zamowienie/Klient/Imie)[1]', 'nvarchar(50)') AS Imie,
    opis.value('(/Zamowienie/Klient/Nazwisko)[1]', 'nvarchar(50)') AS Nazwisko
FROM
    zamowienia_nj;




-- zapytanie wyświetlające informacje o zawartości zamówienia (co zawiera zamówienie np. zawartość paczki)
SELECT
    opis.value('(/Zamowienie/Produkt/Nazwa)[1]', 'nvarchar(50)') AS NazwaProduktu,
    opis.value('(/Zamowienie/Produkt/Cena)[1]', 'decimal(10, 2)') AS CenaProduktu,
    opis.value('(/Zamowienie/SzczegolyZamowienia/Ilosc)[1]', 'int') AS Ilosc
FROM
    zamowienia_nj;



-- zapytanie wyszukujące zamówienia wysyłane do konkretnej lokalizacji (np. miasta)
DECLARE @lokalizacja nvarchar(100) = 'ul. Leśna 10, Gdańsk';

SELECT
    *
FROM
    zamowienia_nj
WHERE
    opis.value('(/Zamowienie/AdresDostawy)[1]', 'nvarchar(100)') = @lokalizacja;




-- zapytanie uzupełniające wybrane zamówienie o dodatkową zawartość
UPDATE zamowienia_nj
SET opis.modify('
    insert 
      <Informacje>
        Nowy
      </Informacje>
    as last into (/Zamowienie/Produkt)[1]
')
WHERE id_zamowienia = 1;

SELECT * FROM zamowienia_nj

