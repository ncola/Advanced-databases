-- ZADANIE 1:

exec sp_configure 'show advanced options', 1
reconfigure

exec sp_configure 'filestream access level', 2
reconfigure




-- ZADANIE 2:

CREATE DATABASE jarzabekn
-- dodanie filegroupy fielstreamowej
ALTER DATABASE jarzabekn
ADD filegroup ft_filegroup contains filestream 
-- dodanie pliku do tej filegroupy (nazwa pliku, sciezka)
ALTER DATABASE jarzabekn
ADD file (name = 'plik_ft', filename = 'c:\jarzabekn')
to filegroup ft_filegroup;

ALTER DATABASE jarzabekn
SET filestream (directory_name='katalog_bazy') --   powstanie folder, to bd odpwoiednik naszej bazy danych po stronie serwera
ALTER DATABASE jarzabekn
SET filestream (non_transacted_access=full) 



-- ZADANIE 3:
USE jarzabekn
CREATE TABLE nikola AS filetable 
WITH (filetable_directory='katalog_tabeli')

SELECT * FROM nikola;



-- ZADANIE 4
-- pierwszy poziom
INSERT INTO nikola (name, file_stream) values ('plik0.xls', cast('' as varbinary(max)))  

INSERT INTO nikola (name, file_stream) values ('plik0.doc', cast('to jest doc' as varbinary(max)))  

INSERT INTO nikola (name, file_stream) values ('plik0.txt', cast('to jest txt' as varbinary(max)))  

INSERT INTO nikola (name, is_directory) values ('now_folder1',1)
UPDATE nikola
SET name = 'nowy_folder1'
WHERE name = 'now_folder1'

SELECT * FROM nikola

-- drugi poziom

DECLARE @sciezka_katalogu hierarchyid 
DECLARE @sciezka_pliku varchar(max)

SELECT @sciezka_katalogu=path_locator FROM nikola WHERE name='nowy_folder1'
SELECT @sciezka_katalogu.ToString() -- sprawdzamy,  /72923260550216.99281298918658.326584812/

SELECT @sciezka_pliku= @sciezka_katalogu.ToString() +
convert(varchar(20), convert(bigint, substring(convert(binary(16),newid()),1,6)))+'.'+
convert(varchar(20), convert(bigint, substring(convert(binary(16),newid()),7,6)))+'.'+
convert(varchar(20), convert(bigint, substring(convert(binary(16),newid()),13,4)))+'/'

SELECT @sciezka_pliku -- sprawzdamy, sciezka do pliku ktory bedzie znajodwal sie w podkatalogu

INSERT INTO nikola (name,path_locator, file_stream) VALUES ('plik1.xls', @sciezka_pliku, cast('' as varbinary(max)))
INSERT INTO nikola (name,path_locator, file_stream) VALUES ('plik1.doc', @sciezka_pliku, cast('to jest doc w folder1' as varbinary(max)))
INSERT INTO nikola (name,path_locator, file_stream) VALUES ('plik1.txt', @sciezka_pliku, cast('to jest tx w folder1' as varbinary(max)))
INSERT INTO nikola (name,path_locator,is_directory) values ('nowy_folder2',@sciezka_pliku, 1)

SELECT* FROM nikola

-- trzeci poziom

DECLARE @sciezka_katalogu hierarchyid 
DECLARE @sciezka_pliku varchar(max)

SELECT @sciezka_katalogu=path_locator FROM nikola WHERE name='nowy_folder2'

SELECT @sciezka_pliku= @sciezka_katalogu.ToString() +
convert(varchar(20), convert(bigint, substring(convert(binary(16),newid()),1,6)))+'.'+
convert(varchar(20), convert(bigint, substring(convert(binary(16),newid()),7,6)))+'.'+
convert(varchar(20), convert(bigint, substring(convert(binary(16),newid()),13,4)))+'/'

INSERT INTO nikola (name,path_locator, file_stream) VALUES ('plik2.ppt', @sciezka_pliku, cast('' as varbinary(max)))
INSERT INTO nikola (name,path_locator, file_stream) VALUES ('plik2.doc', @sciezka_pliku, cast('to jest doc w folder2' as varbinary(max)))
INSERT INTO nikola (name,path_locator, file_stream) VALUES ('plik2.txt', @sciezka_pliku, cast('to jest tx w folder2' as varbinary(max)))
INSERT INTO nikola (name,path_locator,is_directory) values ('nowy_folder3',@sciezka_pliku, 1)

-- czwarty poziom
DECLARE @sciezka_katalogu hierarchyid 
DECLARE @sciezka_pliku varchar(max)

SELECT @sciezka_katalogu=path_locator FROM nikola WHERE name='nowy_folder3'

SELECT @sciezka_pliku= @sciezka_katalogu.ToString() +
convert(varchar(20), convert(bigint, substring(convert(binary(16),newid()),1,6)))+'.'+
convert(varchar(20), convert(bigint, substring(convert(binary(16),newid()),7,6)))+'.'+
convert(varchar(20), convert(bigint, substring(convert(binary(16),newid()),13,4)))+'/'


INSERT INTO nikola (name,path_locator, file_stream) VALUES ('plik3.txt', @sciezka_pliku, cast('to jest txt w folder3' as varbinary(max)))
INSERT INTO nikola (name,path_locator, file_stream) VALUES ('plik3.doc', @sciezka_pliku, cast('to jest doc w folder3' as varbinary(max)))




-- ZADANIE 5
-- zamiana zawartosci pliku
UPDATE nikola 
SET file_stream=cast('To jest zadanie 5 podpunkt a' as varbinary(max))
WHERE name='plik0.txt'

-- podmiana zawartosci pliku z innego pliku 

DECLARE @plik_do_podmiany varbinary(max)

SELECT @plik_do_podmiany = cast(bulkcolumn as varbinary(max))
FROM openrowset(bulk 'C:\sas\plik_do_podmiany.xlsx', single_blob) as x


UPDATE nikola 
SET file_stream= @plik_do_podmiany
WHERE name='plik0.xlsx'



-- ZADANIE 6
DELETE FROM nikola 
WHERE name='plik1.doc'

SELECT * FROM nikola