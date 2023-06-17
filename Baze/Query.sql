create database MuzeulSagrada
ON PRIMARY
(
	NAME = MuzeuSagradaData1,
	FILENAME = 'D:\DB\MuzeuSagrada.mdf',
	size = 10MB,
	maxsize = UNLIMITED,
	filegrowth = 1GB
),
(
	NAME = MuzeuSagradaData2,
	FILENAME = 'D:\DB\MuzeuSagrada1.mdf',
	size = 10MB,
	maxsize = UNLIMITED,
	filegrowth = 1GB
),
(
	NAME = MuzeuSagradaData3,
	FILENAME = 'D:\DB\MuzeuSagrada.ndf',
	size = 10MB,
	maxsize = UNLIMITED,
	filegrowth = 1GB
),
(
	NAME = MuzeuSagradaData4,
	FILENAME = 'D:\DB\MuzeuSagrada1.ndf',
	size = 10MB,
	maxsize = UNLIMITED,
	filegrowth = 1GB
)
LOG ON
(
	NAME = LoggerMuzeu1,
	FILENAME = 'D:\DB\LoggerMuzeu1.ldf',
	size = 10MB,
	maxsize = UNLIMITED,
	filegrowth = 1GB
),
(
	NAME = LoggerMuzeu2,
	FILENAME = 'D:\DB\LoggerMuzeu2.ldf',
	size = 10MB,
	maxsize = UNLIMITED,
	filegrowth = 1GB
);


if OBJECT_ID('Angajati','U') is not null
	drop table Angajati
create table Angajati(
	IDAngajat int identity(1,1) primary key,
	Nume nvarchar(20),
	Prenume nvarchar(20),
	Localitate nvarchar(20),
	Departament nvarchar(20),
	NumarTelefon char(10),
	DataAngajare Date,
	DataExpirareContract Date,
	AniExperientaDomeniu int
)

if OBJECT_ID('Functii','U') is not null
	drop table Functii
create table Functii(
	IDFunctie int identity(1,1) primary key,
	NumeFunctie nvarchar(20),
	IntervalOrar nvarchar(20),
	Responsabilitati nvarchar(100),
	Executie char(2),
	DataObtinereFunctie DATE
)

if OBJECT_ID('Salarii','U') is not null
	drop table Salarii
create table Salarii(
	IDSalariu int identity(1,1) primary key,
	SalariuBrut int,
	SalariuNet int,
	DataAvans Date,
	DataLichidare Date,
	OreSuplimentare int,
	ValoareAvans int
)

if OBJECT_ID('SalariuFunctie','U') is not null
	drop table SalariuFunctie
create table SalariuFunctie(
	IDSalariuFunctie int identity(1,1) primary key,
	IDSalariu int,
	IDFunctie int,
	foreign key(IDSalariu) references Salarii(IDSalariu) on delete cascade,
	foreign key(IDFunctie) references Functii(IDFunctie) on delete cascade
)

if OBJECT_ID('FunctieAngajat','U') is not null
	drop table FunctieAngajat
create table FunctieAngajat(
	IDFunctieAngajat int identity(1,1) primary key,
	IDFunctie int,
	IDAngajat int,
	DataObtinereFunctie DATE,
	foreign key(IDFunctie) references Functii(IDFunctie) on delete cascade,
	foreign key(IDAngajat) references Angajati(IDAngajat) on delete cascade,
)

if OBJECT_ID('Impozite','U') is not null
	drop table Impozite
create table Impozite(
	IDImpozit int identity(1,1) primary key,
	IDSalariu int,
	ProcentAsigurareMedicala int,
	ProcentCasaPensii int,
	ProcentTaxaSalariat int,
	foreign key(IDSalariu) references Salarii(IDSalariu) on delete cascade
)
if OBJECT_ID('Furnizori','U') is not null
	drop table Furnizori
create table Furnizori(
	IDFurnizor int identity(1,1) primary key,
	NumeFurnizor nvarchar(50),
	CodSRL varchar(7),
	Adresa nvarchar(50),
	UltimaLivrare Date,
	DurataContractFurnizare int,
	AnActivitatePiata Date,

)

if OBJECT_ID('Suveniruri','U') is not null
	drop table Suveniruri
create table Suveniruri(
	IDSuvenir int identity(1,1) primary key,
	Nume nvarchar(20),
	Material nvarchar(15),
	Tip nvarchar(15),
	TaraProvenienta nvarchar(20),
	Pret int,
	BucatiStoc int,
)

if OBJECT_ID('FurnizorSuvenir','U') is not null
	drop table FurnizorSuvenir
create table FurnizorSuvenir(
	IDFurnizorSuvenir int identity(1,1) primary key,
	IDSuvenir int,
	IDFurnizor int,
	foreign key(IDSuvenir) references Suveniruri(IDSuvenir) on delete cascade,
	foreign key(IDFurnizor) references Furnizori(IDFurnizor) on delete cascade
)

if OBJECT_ID('Unelte','U') is not null
	drop table Unelte
create table Unelte(
	IDUnealta int identity(1,1) primary key,
	Nume nvarchar(20),
	Marca nvarchar(20),
	TipUnealta nvarchar(20),
	DataAchizitie Date,
	DataExpirareGarantie Date,

)

if object_id('FurnizorUnealta','U') is not null
	drop table FurnizorUnealta
create table FurnizorUnealta(
	IDFurnizorUnealta int identity(1,1) primary key,
	IDUnealta int,
	IDFurnizor int,
	foreign key(IDUnealta) references Unelte(IDUnealta) on delete cascade,
	foreign key(IDFurnizor) references Furnizori(IDFurnizor) on delete cascade,
)

if object_id('AngajatUnealta','U') is not null
	drop table AngajatUnealta
create table AngajatUnealta(
	IDAngajatUnealta int identity(1,1) primary key,
	IDAngajat int,
	IDUnealta int,
	foreign key(IDAngajat) references Angajati(IDAngajat) on delete cascade,
	foreign key(IDUnealta) references Unelte(IDUnealta) on delete cascade
)

if object_id('Incasari','U') is not null
	drop table Incasari
create table Incasari(
	IDIncasare int identity(1,1) primary key,
	SumaIncasata int,
	NumarClienti int,
)

if object_id('IncasareSuvenir','U') is not null
	drop table IncasareSuvenir
create table IncasareSuvenir(
	IDIncasareSuvenir int identity(1,1) primary key,
	IDIncasare int,
	IDSuvenir int,
	DataIncasare Date,
	foreign key(IDIncasare) references Incasari(IdIncasare) on delete cascade,
	foreign key(IDSuvenir) references Suveniruri(IDSuvenir) on delete cascade
)

if object_id('Clienti','U') is not null
	drop table Clienti
create table Clienti(
	IDClient int identity(1,1) primary key,
	Nume nvarchar(20),
	Prenume nvarchar(20),
	ClientFidel char(2),
	TipClient nvarchar(10),
	Telefon char(10),
	Mail nvarchar(30),
	DataUltimaVizita Date
)

if object_id('Expozitii','U') is not null
	drop table Expozitii
create table Expozitii(
	IDExpozitie int identity(1,1) primary key,
	IDAngajat int,
	Locatie nvarchar(50),
	Descriere nvarchar(100),
	CapacitatePersoane int,
	foreign key(IDAngajat) references Angajati(IDAngajat) on delete cascade
)
if object_id('Rezervari','U') is not null
	drop table Rezervari
create table Rezervari(
	IDRezervare int identity(1000,1) primary key,
	IDExpozitie int,
	IDClient int,
	NumarBilete int,
	DataRezervare Date,
	OraRezervare int,
	foreign key(IDClient) references Clienti(IDClient) on delete cascade,
	foreign key(IDExpozitie) references Expozitii(IDExpozitie) on delete cascade
)

if object_id('Exponate','U') is not null
	drop table Exponate
create table Exponate(
	IDExponat int identity(1,1) primary key,
	IDExpozitie int,
	DataAparitie Date,
	Nume nvarchar(20),
	Tip nvarchar(20),
	TaraAparitie nvarchar(10),
	Descriere nvarchar(50),
	foreign key(IDExpozitie) references Expozitii(IDExpozitie) on delete cascade
)

if object_id('Creatori','U') is not null
	drop table Creatori
create table Creatori(
	IDCreator int identity(1,1) primary key,
	Nume nvarchar(20),
	Prenume nvarchar(20),
	DataNastere Date,
	DataDeces Date,
	Adresa nvarchar(30),
	Studii nvarchar(20),
	TipuriPreferate nvarchar(30)
)

if object_id('CreatorExponat','U') is not null
	drop table CreatorExponat
create table CreatorExponat(
	IDCreatorExponat int identity(1,1) primary key,
	IDCreator int,
	IDExponat int,
	foreign key(IDCreator) references Creatori(IDCreator) on delete cascade,
	foreign key(IDExponat) references Exponate(IDExponat) on delete cascade
)

if object_id('IncasareRezervare','U') is not null
	drop table IncasareRezervare
create table IncasareRezervare(
	IDIncasareRezervare int identity(1,1) primary key,
	IDIncasare int,
	IDRezervare int,
	DataIncasare Date,
	foreign key(IDIncasare) references Incasari(IDIncasare) on delete cascade,
	foreign key(IDRezervare) references Rezervari(IDRezervare) on delete cascade
	)
	DBCC CHECKIDENT ('Angajati', RESEED, 0);
INSERT INTO Angajati (Nume, Prenume, Localitate, Departament, NumarTelefon, DataAngajare, DataExpirareContract, AniExperientaDomeniu) 
VALUES 
('Popescu', 'Ion', 'Bucuresti', 'IT', '0756215487', '2022-01-15', '2022-07-15', 2),
('Ionescu', 'Ana', 'Iasi', 'HR', '0732458963', '2021-09-01', '2023-09-01', 5),
('Vasilescu', 'Andrei', 'Brasov', 'Vanzari', '0756654321', '2022-03-02', '2023-03-02', 3),
('Georgescu', 'Mihai', 'Constanta', 'Ingrijire', '0721122334', '2022-02-28', '2022-08-28', 1),
('Dragomirescu', 'Elena', 'Ploiesti', 'Ingrijire', '0766112233', '2022-01-01', '2022-07-01', 4),
('Dumitru', 'Alexandru', 'Bucuresti', 'Primire oaspeti', '0734112233', '2022-04-15', '2022-10-15', 2),
('Popa', 'Maria', 'Cluj-Napoca', 'Vanzari', '0722334455', '2022-01-05', '2023-01-05', 6),
('Marin', 'Andreea', 'Timisoara', 'Primire oaspeti', '0754112233', '2022-01-20', '2022-07-20', 1),
('Gheorghe', 'Diana', 'Oradea', 'Management', '0721002233', '2022-02-01', '2023-02-01', 3),
('Voicu', 'Razvan', 'Bacau', 'Vanzari', '0766888822', '2022-03-15', '2022-09-15', 2),
('Dinu', 'Gabriel', 'Bucuresti', 'Marketing', '0732445566', '2022-01-10', '2022-07-10', 1),
('Ilie', 'Adrian', 'Braila', 'Management', '0744556677', '2022-02-15', '2023-02-15', 4),
('Florescu', 'Cristina', 'Galati', 'Management', '0722669988', '2022-04-01', '2023-04-01', 5),
('Stefanescu', 'Alexandra', 'Bucuresti', 'Reabilitare', '0721678999', '2022-03-01', '2022-09-01', 2),
('Munteanu', 'Iulia', 'Cluj-Napoca', 'HR', '0741002233', '2022-01-08', '2023-01-08', 3);
select* from Angajati

DBCC CHECKIDENT ('Functii', RESEED, 0);
INSERT INTO Functii (NumeFunctie, IntervalOrar, Responsabilitati, Executie, DataObtinereFunctie)
VALUES
('Ghid turistic', '9:00 - 17:00', 'Conduce vizitatorii prin muzeu si le ofera informatii despre exponate', 'Da', '2022-01-01'),
('Curator', '9:00 - 18:00', 'Coordoneaza activitatile de cercetare si expozitionare ale muzeului', 'Da', '2021-05-01'),
('Arhivar', '9:00 - 16:30', 'Se ocupa de organizarea si mentinerea in bune conditii a arhivei muzeului', 'Nu', '2021-09-15'),
('Conservator', '10:00 - 18:00', 'Restaureaza obiectele de arta si de patrimoniu din colectia muzeului', 'Da', '2020-06-01'),
('Asistent curator', '9:00 - 17:00', 'Ofera suport curatorului in activitatile de cercetare si expozitionare ale muzeului', 'Da', '2022-02-01'),
('Tehnician', '9:00 - 17:00', 'Se ocupa de mentenanta si reparatia echipamentelor si sistemelor muzeului', 'Nu', '2021-04-01'),
('Administrator', '9:00 - 17:00', 'Se ocupa de administrarea si gestionarea resurselor muzeului', 'Nu', '2020-01-01'),
('Manager', '9:00 - 18:00', 'Coordoneaza activitatile operationale si strategice ale muzeului', 'Nu', '2019-05-01'),
('Asistent cercetare', '9:00 - 17:00', 'Ofera suport cercetatorilor in activitatile de cercetare ale muzeului', 'Da', '2022-03-01'),
('Designer expozitie', '9:00 - 18:00', 'Se ocupa de designul si organizarea expozitiilor din muzeu', 'Da', '2021-10-01'),
('Vanzator bilete', '9:00 - 17:00', 'Ofera bilete si informatii turistilor care viziteaza muzeul', 'Nu', '2022-04-01'),
('Receptioner', '9:00 - 17:00', 'Se ocupa de primirea si redirectionarea vizitatorilor catre sectiunile muzeului', 'Nu', '2020-09-01'),
('Sofer', '9:00 - 17:00', 'Conduce vehiculele muzeului si transporta obiectele de patrimoniu', 'Nu', '2021-03-01');
select* from Functii


DBCC CHECKIDENT ('Salarii', RESEED, 0);
INSERT INTO Salarii (SalariuBrut, SalariuNet, DataAvans, DataLichidare, OreSuplimentare, ValoareAvans)
VALUES 
(4000, 3200, '2023-04-01', '2023-04-30', 10, 500),
(3000, 2400, '2023-04-01', '2023-04-30', 8, 200),
(3500, 2800, '2023-04-01', '2023-04-30', 12, 300),
(4500, 3600, '2023-04-01', '2023-04-30', 6, 400),
(5000, 4000, '2023-04-01', '2023-04-30', 14, 600),
(2500, 2000, '2023-04-01', '2023-04-30', 5, 100),
(4200, 3360, '2023-04-01', '2023-04-30', 15, 700),
(3200, 2560, '2023-04-01', '2023-04-30', 11, 400),
(3700, 2960, '2023-04-01', '2023-04-30', 9, 250),
(2800, 2240, '2023-04-01', '2023-04-30', 7, 150),
(5500, 4400, '2023-04-01', '2023-04-30', 16, 800),
(2000, 1600, '2023-04-01', '2023-04-30', 4, 50),
(4800, 3840, '2023-04-01', '2023-04-30', 13, 500),
(6000, 4800, '2023-04-01', '2023-04-30', 18, 1000),
(4300, 3440, '2023-04-01', '2023-04-30', 10, 400);
select *from Salarii



INSERT INTO SalariuFunctie (IDSalariu, IDFunctie)
VALUES 
(1, 1),
(2, 3),
(3, 2),
(4, 1),
(5, 4),
(6, 1),
(7, 2),
(8, 4),
(9, 3),
(10, 1),
(11, 4),
(12, 2),
(13, 1),
(14, 4),
(15, 3),
(7,5),
(3,6),
(4,5),
(9,7),
(10,8),
(3,9),
(4,10),
(6,11),
(10,12),
(11,13);
select* from SalariuFunctie




DBCC CHECKIDENT ('Impozite', RESEED, 0);
INSERT INTO Impozite (IDSalariu, ProcentAsigurareMedicala, ProcentCasaPensii, ProcentTaxaSalariat) 
VALUES 
(1,5 , 7, 3),
(2, 4, 3, 10),
(3, 7, 9, 3),
(4, 10, 9, 3),
(5, 10, 15, 5),
(6, 10, 15, 5),
(7, 10, 20, 14),
(8, 3, 10, 2),
(9, 7, 5, 3),
(10, 5, 5, 3),
(11, 5, 5, 7),
(12, 15, 5, 7),
(13, 12, 1, 3),
(14, 23, 10, 4),
(15, 10, 15, 5);
select* from Impozite

DBCC CHECKIDENT ('Furnizori', RESEED, 5);
Insert into Furnizori(NumeFurnizor, CodSRL, Adresa, UltimaLivrare, DurataContractFurnizare, AnActivitatePiata) values
('SC Prodcom SRL', 'RO5412', 'Strada Mare, nr. 25, Bucuresti', '2021-10-20', 12, '2010-01-01'),
('Firma Global SRL', 'RO54321', 'Strada Pietei, nr. 10, Cluj-Napoca', '2022-03-15', 6, '2015-06-01'),
('Sofistic Art SRL', 'RO67890', 'Strada Florilor, nr. 7, Timisoara', '2022-01-05', 24, '2005-12-15'),
('Best Trade SRL', 'RO24680', 'Bulevardul Libertatii, nr. 1, Iasi', '2021-12-01', 18, '2008-09-30'),
('Mega Prod SRL', 'RO13579', 'Strada Victoriei, nr. 20, Cluj-Napoca', '2021-11-10', 12, '2012-05-10'),
('Arti Gold SRL', 'RO98765', 'Bulevardul Unirii, nr. 12, Bucuresti', '2022-02-20', 6, '2019-04-01'),
('New Art SRL', 'RO01234', 'Strada Muncii, nr. 5, Timisoara', '2022-01-30', 12, '2003-08-01'),
('Decor Art SRL', 'RO56789', 'Strada Principala, nr. 30, Brasov', '2021-12-15', 24, '2006-02-15'),
('Classic Style SRL', 'RO24601', 'Bulevardul Stefan cel Mare, nr. 5, Iasi', '2022-03-25', 12, '2011-11-01'),
('Gift Shop SRL', 'RO13579', 'Strada Unirii, nr. 15, Cluj-Napoca', '2022-02-01', 18, '2007-05-01'),
('Smart Art SRL', 'RO86420', 'Strada Avram Iancu, nr. 25, Timisoara', '2021-10-01', 12, '2014-09-01'),
('Pro Arts SRL', 'RO98761', 'Bulevardul Decebal, nr. 50, Bucuresti', '2022-03-05', 6, '2016-01-01'),
('Lega Art SRL', 'RO01235', 'Strada Dacia, nr. 10, Cluj-Napoca', '2021-11-20', 12, '2010-04-01'),
('Max Art SRL', 'RO56780', 'Strada Brasovului, nr. 25, Brasov', '2021-10-15', 18, '2008-12-01'),
('Arti Style SRL', 'RO24681', 'Bulevardul Independentei, nr. 10, Iasi', '2022-02-15', 12, '2013-05-01')
Select* from Furnizori
delete Furnizori

DBCC CHECKIDENT ('Suveniruri', RESEED, 0);
INSERT INTO Suveniruri (Nume, Material, Tip, TaraProvenienta, Pret, BucatiStoc) VALUES
('Magnet Frigider', 'Metal', 'Magnet', 'Romania', 5, 10),
('Tricou muzeu', 'Bumbac', 'Tricou', 'Romania', 20, 5),
('Breloc cheie masina', 'Metal', 'Breloc', 'Franta', 8, 15),
('Magnet Muzeu', 'Metal', 'Magnet', 'Romania', 6, 20),
('Pahar Negru-mat', 'Sticla', 'Pahar', 'Cehia', 12, 10),
('Breloc', 'Metal', 'Breloc', 'Italia', 7, 25),
('Tricou NY', 'Bumbac', 'Tricou', 'Spania', 18, 8),
('Pahar Muzeu', 'Sticla', 'Pahar', 'Germania', 11, 12),
('Termometru', 'Metal', 'Activ', 'Olanda', 5, 15),
('Breloc Oras', 'Metal', 'Breloc', 'Marea Britanie', 9, 20),
('Pahar Viena', 'Sticla', 'Pahar', 'Austria', 13, 7),
('Magnet New York', 'Metal', 'Magnet', 'SUA', 7, 18),
('Tricou Los Angeles', 'Bumbac', 'Tricou', 'SUA', 22, 6),
('Breloc Sidney', 'Metal', 'Breloc', 'Australia', 10, 10),
('Sculptura Muzeu', 'Lemn', 'Pahar', 'Brazilia', 15, 9),
('Sculptura Muzeu', 'Lemn', 'Aranjament', 'Brazilia', 15, 9),
('Magnet copil', 'Metal', 'Magnet', 'Romania', 5, 10),
('Hanorac muzeu', 'Bumbac', 'Vestimentar', 'Romania', 20, 5),
('Breloc model nou', 'Metal', 'Breloc', 'Franta', 8, 15),
('Magnet LV', 'Metal', 'Magnet', 'Romania', 6, 20),
('Pahar colorat', 'Sticla', 'Pahar', 'Cehia', 12, 10),
('Vedere', 'Metal', 'Poza', 'Italia', 7, 25),
('Tricou verde NY', 'Bumbac', 'Tricou', 'Spania', 18, 8),
('Pahar Muzeu Versace', 'Sticla', 'Pahar', 'Germania', 11, 12),
('Magnet chei', 'Metal', 'Magnet', 'Olanda', 5, 15),
('Breloc Oras', 'Metal', 'Breloc', 'Marea Britanie', 9, 20),
('Cana colorata', 'Sticla', 'Cana', 'Austria', 13, 7),
('Magnet New York', 'Metal', 'Magnet', 'SUA', 7, 18),
('Tricou caricatura', 'Bumbac', 'Tricou', 'SUA', 22, 6),
('Breloc Sidney', 'Metal', 'Breloc', 'Australia', 10, 10);
select* from Suveniruri

delete FurnizorSuvenir
DBCC CHECKIDENT ('FurnizorSuvenir', RESEED, 0);
INSERT INTO FurnizorSuvenir(IDSuvenir, IDFurnizor)
VALUES (1, 9),
       (2, 10),
       (3, 11),
       (4, 11),
       (5, 7),
       (6, 8),
       (7, 10),
       (8, 10),
       (9, 11),
       (10, 12),
       (11, 13),
       (12, 15),
       (13, 15),
       (14, 17),
       (15, 19);
	   select* from FurnizorSuvenir

delete Unelte
DBCC CHECKIDENT ('Unelte', RESEED, 0);
INSERT INTO Unelte(Nume, Marca, TipUnealta, DataAchizitie, DataExpirareGarantie)
VALUES ('Unitate PC', 'Samsung', 'Electric', '2020-01-01', '2023-01-01'),
       ('Monitor', 'Dell', 'Electric', '2021-02-05', '2025-02-05'),
       ('Kit programare', 'Lenovo', 'Electric', '2019-06-15', '2022-06-15'),
       ('Monitor', 'Dell', 'Electric', '2022-03-20', '2025-03-20'),
       ('Unitate PC', 'Dell', 'Electric', '2020-12-01', '2024-12-01'),
       ('Intrerupator', 'Schneider', 'Electric', '2021-09-10', '2026-09-10'),
       ('Casa de marcat', 'Phillips', 'Electric', '2019-04-12', '2022-04-12'),
       ('Polizor unghiular', 'Makita', 'Electric', '2020-07-20', '2023-07-20'),
       ('Cleste', 'Knipex', 'Manual', '2021-01-10', '2024-01-10'),
       ('Fierastrau circular', 'Bosch', 'Electric', '2022-02-14', '2027-02-14'),
       ('Lampa de lucru', 'Einhell', 'Electrica', '2020-05-01', '2023-05-01'),
       ('Aparat evidenta', 'LoveON', 'Electric', '2021-08-10', '2026-08-10'),
       ('Aparat monitorizare', 'LCD', 'Bruiaj', '2019-07-08', '2022-07-08'),
       ('Costum special', 'Bigotti', 'Vestimentar', '2022-04-15', '2025-04-15'),
       ('Prelungitor', 'Hammas', 'Electric', '2020-11-10', '2023-11-10'),
	   ('Calculator buzunar','Dell','Electric','2020/01/01','2023/01/01'),   
		('Masina de gaurit',	'DeWalt'	,'Electric'	,'2021-02-05'	,'2025-02-05'),
		('Imprimanta',' Dell',	'Recuzita'	,'2019-06-15','2022-06-15'),
		('Foarfeca','	Fiskars',	'Manuala','2022-03-20'	,'2025-03-20'),
		('PC Monitorizare',	'Dell'	,'Electric','2020-12-01',	'2024-12-01'),
		('Tabla portabila',	'Ineos'	,'Recuzita'	,'2021-09-10'	,'2026-09-10'),
		('Server','	Synology',	'Electric'	,'2019-04-12',	'2022-04-12'),
		('Server','	SynologyS',	',Electric'	,'2020-07-20'	,'2023-07-20'),
		('Cleste','	Knipex',	'Manual',	'2021-01-10'	,'2024-01-10'),
		('Imprimanta','	Hama',	'Recuzita'	,'2022-02-14',	'2027-02-14'),
		('Lampa de lucru',	'Einhell'	,'Electrica'	,'2020-05-01'	,'2023-05-01'),
		('Tabla Smart',	'Hama'	,'Electric'	,'2021-08-10'	,'2026-08-10'),
		('Markere',	'Bic',	'Recuzita',	'2019-07-08',	'2022-07-08'),
		('Imprimanta',	'Canon','	Recuzita',	'2022-04-15'	,'2025-04-15'),
		('Stanca',	'Stanley','	Manuala',	'2020-11-10',	'2023-11-10');
select * from Unelte

delete FurnizorUnealta
DBCC CHECKIDENT ('FurnizorUnealta', RESEED, 0);
INSERT INTO FurnizorUnealta(IDUnealta, IDFurnizor)
VALUES (1, 6),
       (2, 8),
       (3, 9),
       (4, 10),
       (5, 6),
       (6, 7),
       (7, 12),
       (8, 13),
       (9, 14),
       (10, 15),
       (11, 18),
       (12, 15),
       (13, 17),
       (14, 20);
	   select* from FurnizorUnealta

delete AngajatUnealta
DBCC CHECKIDENT ('AngajatUnealta', RESEED, 0);
insert into AngajatUnealta(IDAngajat,IDUnealta) values 
(1, 1), 
(1, 2), 
(1, 3), 
(2, 4), 
(2, 5), 
(2, 6), 
(3, 4), 
(4, 8), 
(4, 9), 
(4, 10), 
(5, 4), 
(5, 10), 
(5, 11), 
(6, 12), 
(6, 13),
(6,14),
(7,16),
(7,18),
(8,12),
(8,14),
(9,18),
(9,21),
(1,22),
(9,23),
(1,23),
(9,25),
(12,25),
(13,25),
(15,25),
(15,27),
(12,27),
(12,28),
(13,28),
(10,28),
(10,29),
(5,24),
(5,19),
(6,19);
select* from AngajatUnealta

delete Incasari
DBCC CHECKIDENT ('Incasari', RESEED, 0);
insert into Incasari (SumaIncasata,NumarClienti) values 
(100,20), 
(200,30), 
(300,10), 
(400,5), 
(500,40), 
(600,12),
(700,15),
(800,30), 
( 900,25), 
(1000,47), 
( 1100,42), 
( 1200,39), 
(1300,25), 
( 1400,36), 
( 1500,23),
(2000,43),
(1750,25),
(2000,100),
(2100,153);

select* from Incasari

delete IncasareSuvenir
DBCC CHECKIDENT ('IncasareSuvenir', RESEED, 0);
insert into IncasareSuvenir(IDIncasare,IDSuvenir,DataIncasare) values 
(1, 1,'2023/05/01'), 
(1, 2,'2022/05/02'), 
(2, 3,'2023/04/05'),
(2, 4,'2023/03/27'),
(3, 5,'2023/05/23'),
(3, 6,'2023/05/20'),
(4, 7,'2022/04/25'),
(4, 8,'2022/08/05'),
(5, 9,'2023/07/05'), 
(5, 10,'2023/05/04'), 
(6, 11,'2022/04/03'), 
(6, 12,'2021/07/03'), 
(7, 13,'2022/05/29'), 
(7, 14,'2021/04/30'), 
(8, 15,'2021/02/28'),
(9,10,'2022/04/25'),
(9,11,'2023/03/02'),
(10,10,'2022/04/05');
select * from IncasareSuvenir

delete Clienti
DBCC CHECKIDENT ('Clienti', RESEED, 0);

INSERT INTO Clienti (Nume, Prenume, ClientFidel, TipClient, Telefon, Mail, DataUltimaVizita)
VALUES
('Popescu', 'Ion', 'DA', 'VIP', '0712345678', 'ion.popescu@gmail.com', '2022-03-15'),
('Ionescu', 'Maria', 'NU', 'EXTENDED', '0756789123', 'maria.ionescu@yahoo.com', '2022-01-10'),
('Georgescu', 'Andrei', 'NU', 'REGULAR', '0723456789', 'andrei.georgescu@hotmail.com', '2022-04-01'),
('Dumitrescu', 'Cristina', 'NU', 'VIP', '0734567891', 'cristina.dumitrescu@gmail.com', '2022-02-20'),
('Popa', 'Gabriel', 'DA', 'REGULAR', '0745678912', 'gabriel.popa@gmail.com', '2022-04-10'),
('Radu', 'Diana', 'NU', 'EXTENDED', '0722222222', 'diana.radu@yahoo.com', '2022-03-01'),
('Munteanu', 'Alexandru', 'NU', 'VIP', '0733333333', 'alexandru.munteanu@hotmail.com', '2022-02-15'),
('Balan', 'Adrian', 'DA', 'REGULAR', '0755555555', 'adrian.balan@gmail.com', '2022-04-05'),
('Stefanescu', 'Cristina', 'NU', 'EXTENDED', '0711111111', 'cristina.stefanescu@yahoo.com', '2022-03-10'),
('Gheorghiu', 'Maria', 'DA', 'VIP', '0744444444', 'maria.gheorghiu@gmail.com', '2022-01-15'),
('Preda', 'Radu', 'DA', 'VIP', '0722222222', 'radu.preda@yahoo.com', '2022-04-10'),
('Florescu', 'Simona', 'NU', 'EXTENDED', '0733333333', 'simona.florescu@hotmail.com', '2022-03-20'),
('Badea', 'Andrei', 'NU', 'EXTENDED', '0755555555', 'andrei.badea@gmail.com', '2022-02-05'),
('Dobre', 'Alina', 'NU', 'REGULAR', '0711111111', 'alina.dobre@yahoo.com', '2021-03-04');
select* from Clienti

delete Expozitii
DBCC CHECKIDENT ('Expozitii', RESEED, 6);
--Greseala la declarare
alter table Expozitii
	alter column Locatie nvarchar(100)
INSERT INTO Expozitii (IDAngajat, Locatie, Descriere, CapacitatePersoane)
VALUES 
(1, 'Galeria Renasterii', 'Expozitie de artă renascentistă', 50),
(2, 'Sala Impresionistă', 'Expozitie de artă impresionistă', 75),
(3, 'Sala Sculpturii', 'Expozitie de sculptură contemporană', 30),
(4, 'Sala de Artă Modernă', 'Expozitie de artă modernă', 40),
(5, 'Galeria Antică', 'Expozitie de artefacte antice', 60),
(6, 'Galeria de Arte Plastice', 'Expozitie de artă contemporană', 45),
(7, 'Sala Orientală', 'Expozitie de artă orientală', 25),
(8, 'Sala de Artă Clasică', 'Expozitie de artă clasică', 35),
(9, 'Sala de Arte Decorative', 'Expozitie de arte decorative', 50),
(10, 'Sala de Artă Fotografică', 'Expozitie de artă fotografică', 20),
(11, 'Sala de Artă Digitală', 'Expozitie de artă digitală', 30),
(12, 'Galeria de Artă Contemporană', 'Expozitie de artă contemporană', 40),
(13, 'Sala de Artă Populară', 'Expozitie de artă populară', 55),
(14, 'Sala de Artă Americană', 'Expozitie de artă americană', 25),
(15, 'Sala de Artă Britanică', 'Expozitie de artă britanică', 30);
select* from Expozitii

delete Rezervari
DBCC CHECKIDENT ('Rezervari', RESEED, 1016);
insert into Rezervari(IDExpozitie, IDClient, NumarBilete, DataRezervare, OraRezervare)
values
(21, 3, 2, '2023-05-01', 10),
(7, 2, 3, '2023-05-02', 11),
(7, 5, 1, '2023-05-03', 12),
(9, 1, 4, '2023-05-04', 13),
(10, 4, 2, '2023-05-05', 14),
(11, 6, 1, '2023-05-06', 15),
(12, 7, 3, '2023-05-07', 16),
(12, 8, 2, '2023-05-08', 17),
(9, 9, 1, '2023-05-09', 18),
(7, 10, 2, '2023-05-10', 19),
(21, 11, 3, '2023-05-11', 20),
(7, 12, 1, '2023-05-12', 21),
(8, 13, 2, '2023-05-13', 22),
(8, 14, 1, '2023-05-14', 23),
(11, 2, 2, '2023-05-15', 24)
select *from Rezervari

delete Exponate
-- greseala la declarare tabel
	alter table Exponate
		alter column Nume nvarchar(50)
	alter table Exponate
		alter column Descriere nvarchar(100)
	
DBCC CHECKIDENT ('Exponate', RESEED, 22);
INSERT INTO Exponate(IDExpozitie, DataAparitie, Nume, Tip, TaraAparitie, Descriere) 
VALUES 
(7, '2022-01-01', 'Tablou abstract', 'Pictură', 'Franta', 'O operă de artă abstractă'),
(7, '2022-01-01', 'Vază din portelan', 'Sculptură', 'China', 'O vază frumoasă si delicată'),
(7, '2022-01-01', 'Statuie de bronz', 'Sculptură', 'Grecia', 'O statuie reprezentând zeul Zeus'),
(8, '2022-02-15', 'Colier din aur', 'Bijuterie', 'India', 'Un colier frumos din aur'),
(8, '2022-02-15', 'Brătară din argint', 'Bijuterie', 'Mexic', 'O brătară masivă din argint'),
(8, '2022-02-15', 'Inel cu diamant', 'Bijuterie', 'Belgia', 'Un inel cu un diamant mare si strălucitor'),
(9, '2022-03-10', 'Cana din ceramică', 'Ceramică', 'Spania', 'O cană frumoasă si rustică din ceramică'),
(10, '2022-03-10', 'Farfurie de portelan', 'Ceramică', 'Japonia', 'O farfurie frumoasă si delicată din porțelan'),
(9, '2022-03-10', 'Vază din sticlă', 'Ceramică', 'Italia', 'O vază mare si transparentă din sticlă'),
(10, '2022-04-05', 'Brosă din perle', 'Bijuterie', 'Franta', 'O brosă elegantă din perle'),
(10, '2022-04-05', 'Cercei cu pietre semipretioase', 'Bijuterie', 'Thailanda', 'Cercei lungi si strălucitori cu pietre semipretioase'),
(11, '2022-04-05', 'Brătară din aur', 'Bijuterie', 'Italia', 'O brătară subtire si elegantă din aur'),
(11, '2022-05-20', 'Vază din argint', 'Sculptură', 'Turcia', 'O vază masivă din argint'),
(11, '2022-05-20', 'Statuie de marmură', 'Sculptură', 'Grecia', 'O statuie frumoasă si realistă a lui Apollo'),
(12, '2022-05-20', 'Tablou în ulei', 'Pictură', 'Italia', 'Un tablou reprezentând o priveliste din Venetia'),
(12, '2022-06-11', 'Farfurie din ceramică', 'Ceramică', 'Turcia', 'O farfurie mică si rustică din ceramică'),
(12, '2022-06-11', 'Vază din portelan', 'Sculptură', 'China', 'O vază frumoasă si delicată'),
(21, '2022-06-11', 'Tablou în ulei', 'Pictură', 'Spania', 'Un tablou impresionist reprezentând o grădină înflorită'),
(13, '2022-07-02', 'Brosă din aur', 'Bijuterie', 'Italia', 'O brosă subtire si elegantă din aur'),
(13, '2022-07-02', 'Cercei din argint', 'Bijuterie', 'Mexic', 'Cercei lungi si masivi din argint'),
(14, '2022-07-02', 'Inel cu rubin', 'Bijuterie', 'Thailanda', 'Un inel cu un rubin mare si frumos'),
(14, '2022-08-18', 'Statuie de marmură', 'Sculptură', 'Italia', 'O statuie frumoasă si detaliată a unei zeite'),
(14, '2022-08-18', 'Vază din argint', 'Sculptură', 'Turcia', 'O vază mare si masivă din argint'),
(15, '2022-08-18', 'Tablou abstract', 'Pictură', 'Franta', 'Un tablou abstract cu forme geometrice'),
(15, '2022-09-05', 'Farfurie de portelan', 'Ceramică', 'Japonia', 'O farfurie frumoasă si delicată din porțelan'),
(16, '2022-09-05', 'Vază din sticlă', 'Ceramică', 'Italia', 'O vază mare si transparentă din sticlă'),
(16, '2022-09-05', 'Cana din ceramică', 'Ceramică', 'Spania', 'O cană frumoasă si rustică din ceramică'),
(17, '2022-10-22', 'Inel cu safir', 'Bijuterie', 'Belgia', 'Un inel cu un safir mare si frumos'),
(17, '2022-10-22', 'Cercei din aur', 'Bijuterie', 'Italia', 'Cercei mici si eleganti din aur'),
(18, '2022-10-22', 'Brosă din argint', 'Bijuterie', 'Grecia', 'O brosă masivă si rustică din argint'),
(19, '2022-11-11', 'Tablou în ulei', 'Pictură', 'Italia', 'Un tablou reprezentând o priveliste din Toscana'),
(20, '2022-11-11', 'Statuie de bronz', 'Sculptură', 'Grecia', 'O statuie frumoasă si realistă a lui Ares')
select* from Exponate

alter table Creatori
	alter column Studii nvarchar(50)
delete Creatori
DBCC CHECKIDENT ('Creatori', RESEED, 3);
INSERT INTO Creatori(Nume, Prenume, DataNastere, DataDeces, Adresa, Studii, TipuriPreferate) VALUES
('Popescu', 'Maria', '1980-03-15', NULL, 'Bucuresti, Romania', 'Facultatea de Arte', 'Pictura'),
('Ionescu', 'Alex', '1975-06-20', '2020-11-10', 'Brasov, Romania', 'Facultatea de Arte', 'Sculptura'),
('Vasilescu', 'Ana', '1995-01-01', NULL, 'Cluj-Napoca, Romania', 'Facultatea de Arhitectura', 'Design de interior'),
('Mihai', 'Dragos', '1988-12-05', NULL, 'Iasi, Romania', 'Facultatea de Arte', 'Pictura'),
('Stefanescu', 'Andrei', '1982-09-30', '2022-02-14', 'Timisoara, Romania', 'Facultatea de Arte', 'Grafica'),
('Radu', 'Ioana', '1990-07-25', NULL, 'Constanta, Romania', 'Facultatea de Arte', 'Arta textila'),
('Popa', 'Andreea', '1985-04-10', NULL, 'Bacau, Romania', 'Facultatea de Arhitectura', 'Design de exterior'),
('Avram', 'Vlad', '1998-11-18', NULL, 'Pitesti, Romania', 'Facultatea de Arte', 'Fotografie'),
('Badea', 'Andrei', '1970-02-22', '2021-03-10', 'Suceava, Romania', 'Facultatea de Arte', 'Sculptura'),
('Pavel', 'Diana', '1993-08-08', NULL, 'Craiova, Romania', 'Facultatea de Arhitectura', 'Design de mobilier'),
('Dinu', 'Mihai', '1987-05-01', '2022-01-15', 'Bucuresti, Romania', 'Facultatea de Arte', 'Pictura'),
('Radulescu', 'Raluca', '1996-10-12', NULL, 'Iasi, Romania', 'Facultatea de Arte', 'Arta digitala'),
('Balan', 'Cristian', '1978-09-08', NULL, 'Braila, Romania', 'Facultatea de Arhitectura', 'Design de gradini'),
('Negrea', 'Ana-Maria', '1991-12-23', NULL, 'Cluj-Napoca, Romania', 'Facultatea de Arte', 'Sculptura'),
('Stancu', 'Gabriel', '1984-03-31', NULL, 'Ploiesti, Romania', 'Facultatea de Arte', 'Arta decorativa');

select* from Creatori

DBCC CHECKIDENT ('CreatorExponat', RESEED, 0);
INSERT INTO CreatorExponat(IDCreator, IDExponat) VALUES
(4, 23),
(5, 24),
(6,25),
(7, 26),
(8, 27),
(9, 28),
(10, 29),
(11, 30),
(12, 31),
(13,32),
(14, 33),
(15, 34),
(12, 35),
(13, 36),
(15, 37),
(5,38),
(5,39),
(6,40),
(6,41),
(7,42),
(7,43),
(8,44),
(8,45),
(9,46),
(10,47),
(11,48),
(11,49),
(12,50),
(13,51),
(12,52),
(12,53),
(13,54);

insert into IncasareRezervare(IDIncasare,IDRezervare,DataIncasare) values
(1, 1017,'2023/05/05'),
(2, 1019,'2022/04/03'),
(3, 1020,'2023/05/04'),
(4, 1018,'2023/05/01'),
(5, 1021,'2023/05/02'),
(6, 1022,'2023/05/03'),
(7, 1023,'2023/05/04'),
(8, 1024,'2023/05/07'),
(9, 1025,'2023/05/06'),
(10, 1026,'2023/05/08'),
(11, 1027,'2023/05/09'),
(12, 1028,'2023/05/10'),
(13, 1029,'2022/04/07'),
(14, 1030,'2023/05/11'),
(15, 1031,'2023/05/12');
select* from IncasareRezervare

-- sa se afiseze toate uneltele de tip electric si angajatii care au acces la ele
select u.Nume,u.Marca,a.Nume,a.Prenume
from Angajati a inner join AngajatUnealta au
on a.IDAngajat=au.IDAngajat
inner join Unelte u on au.IDUnealta=u.IDUnealta
where u.TipUnealta='Electric'
select* from Expozitii
-- sa se afiseze autorii operelor de arta care sunt prezentate in cadrul expozitiei Galeria Renasterii,in viata,in ordine alfabetica a numelor

select c.Nume as NumeAutor,c.Prenume as PrenumeAutor,e.Nume as NumeExponat
from Creatori c inner join CreatorExponat ce
on c.IDCreator=ce.IDCreator inner join Exponate e
on ce.IDExponat=e.IDExponat inner join Expozitii ex
on ex.IDExpozitie=e.IDExpozitie
where ex.Locatie='Galeria Renasterii'

-- sa se afiseze toti autorii operelor de arta, operele acestora, respectiv expozitia la care se afla pentru autorii care sunt inca in viata

select c.Nume as NumeAutor,c.Prenume as PrenumeAutor,e.Nume as NumeExponate, ex.Locatie as LocatieExpozitie
from Creatori c inner join CreatorExponat ce
on c.IDCreator=ce.IDCreator inner join Exponate e
on ce.IDExponat=e.IDExponat inner join Expozitii ex
on ex.IDExpozitie=e.IDExpozitie
where DataDeces is NULL

-- sa se afiseze toate incasarile obtinute in urma rezervarii facute de Clientii al caror nume incepe cu P
select c.Nume,inc.SumaIncasata,ir.DataIncasare
from Clienti c inner join Rezervari r
on c.IDClient=r.IDClient inner join IncasareRezervare ir
on ir.IDRezervare=r.IDRezervare inner join  Incasari inc
on inc.IDIncasare=ir.IDIncasare
where c.Nume like 'P%'
order by inc.SumaIncasata desc

update Impozite
set ProcentAsigurareMedicala=5,ProcentCasaPensii=7,ProcentTaxaSalariat=3
where IDImpozit=1


-- sa se afiseze toate uneltele de tip electric si angajatii care au acces la ele
select u.Nume,u.Marca,a.Nume,a.Prenume
from Angajati a inner join AngajatUnealta au
on a.IDAngajat=au.IDAngajat
inner join Unelte u on au.IDUnealta=u.IDUnealta
where u.TipUnealta='Electric'
select* from Expozitii
-- sa se afiseze autorii operelor de arta care sunt prezentate in cadrul expozitiei Galeria Renasterii,in viata,in ordine alfabetica a numelor

select c.Nume as NumeAutor,c.Prenume as PrenumeAutor,e.Nume as NumeExponat
from Creatori c inner join CreatorExponat ce
on c.IDCreator=ce.IDCreator inner join Exponate e
on ce.IDExponat=e.IDExponat inner join Expozitii ex
on ex.IDExpozitie=e.IDExpozitie
where ex.Locatie='Galeria Renasterii'

-- sa se afiseze toti autorii operelor de arta, operele acestora, respectiv expozitia la care se afla pentru autorii care sunt inca in viata

select c.Nume as NumeAutor,c.Prenume as PrenumeAutor,e.Nume as NumeExponate, ex.Locatie as LocatieExpozitie
from Creatori c inner join CreatorExponat ce
on c.IDCreator=ce.IDCreator inner join Exponate e
on ce.IDExponat=e.IDExponat inner join Expozitii ex
on ex.IDExpozitie=e.IDExpozitie
where DataDeces is NULL

-- sa se afiseze toate incasarile obtinute in urma rezervarii facute de Clientii al caror nume incepe cu P
select c.Nume,inc.SumaIncasata,ir.DataIncasare
from Clienti c inner join Rezervari r
on c.IDClient=r.IDClient inner join IncasareRezervare ir
on ir.IDRezervare=r.IDRezervare inner join  Incasari inc
on inc.IDIncasare=ir.IDIncasare
where c.Nume like 'P%'
order by inc.SumaIncasata desc

update Impozite
set ProcentAsigurareMedicala=5,ProcentCasaPensii=7,ProcentTaxaSalariat=3
where IDImpozit=1
select* from Impozite



-- sa se afiseze toate uneltele de tip electric si angajatii care au acces la ele
select u.Nume,u.Marca,a.Nume,a.Prenume
from Angajati a inner join AngajatUnealta au
on a.IDAngajat=au.IDAngajat
inner join Unelte u on au.IDUnealta=u.IDUnealta
where u.TipUnealta='Electric'
select* from Expozitii
-- sa se afiseze autorii operelor de arta care sunt prezentate in cadrul expozitiei Galeria Renasterii,in viata,in ordine alfabetica a numelor

select c.Nume as NumeAutor,c.Prenume as PrenumeAutor,e.Nume as NumeExponat
from Creatori c inner join CreatorExponat ce
on c.IDCreator=ce.IDCreator inner join Exponate e
on ce.IDExponat=e.IDExponat inner join Expozitii ex
on ex.IDExpozitie=e.IDExpozitie
where ex.Locatie='Galeria Renasterii'

-- sa se afiseze toti autorii operelor de arta, operele acestora, respectiv expozitia la care se afla pentru autorii care sunt inca in viata

select c.Nume as NumeAutor,c.Prenume as PrenumeAutor,e.Nume as NumeExponate, ex.Locatie as LocatieExpozitie
from Creatori c inner join CreatorExponat ce
on c.IDCreator=ce.IDCreator inner join Exponate e
on ce.IDExponat=e.IDExponat inner join Expozitii ex
on ex.IDExpozitie=e.IDExpozitie
where DataDeces is NULL

-- sa se afiseze toate incasarile obtinute in urma rezervarii facute de Clientii al caror nume incepe cu P
select c.Nume,inc.SumaIncasata,ir.DataIncasare
from Clienti c inner join Rezervari r
on c.IDClient=r.IDClient inner join IncasareRezervare ir
on ir.IDRezervare=r.IDRezervare inner join  Incasari inc
on inc.IDIncasare=ir.IDIncasare
where c.Nume like 'P%'
order by inc.SumaIncasata desc

--sa se afiseze toti angajati al caror Procent pentru Asigurarea medicala depaseste pragul de 10 %

select a.Nume,a.Prenume,i.ProcentAsigurareMedicala
from Angajati a inner join FunctieAngajat fa
on a.IDAngajat=fa.IDAngajat
inner join Functii f
on fa.IDFunctie=f.IDFunctie
inner join SalariuFunctie sa
on sa.IDFunctie=f.IDFunctie
inner join Salarii s
on s.IDSalariu=sa.IDSalariu
inner join Impozite i
on i.IDSalariu=sa.IDSalariu
where i.ProcentAsigurareMedicala >10

-- sa se afiseze top 3 furnizori de suveniruri ale caror suveniruri au reusit incasari de peste 600 de lei ordonati descrescator

select top 3 f.NumeFurnizor,inc.SumaIncasata
from Furnizori f inner join FurnizorSuvenir fz
on f.IDFurnizor=fz.IDFurnizor inner join Suveniruri s
on s.IDSuvenir=fz.idSuvenir inner join IncasareSuvenir incs
on incs.IDSuvenir=s.IDSuvenir inner join Incasari inc
on inc.IDIncasare=incs.IDIncasare
where inc.SumaIncasata>699
order by inc.SumaIncasata desc

-- Sa se afiseze furnizorii uneltelor care apar in inventarul angajatilor ce au functii de Management si salarii net peste 2000 lei.

select f.NumeFurnizor
from Furnizori f inner join FurnizorUnealta fu
on f.IDFurnizor=fu.IDFurnizor
inner join Unelte u
on fu.IDUnealta=u.IDUnealta
inner join AngajatUnealta au
on u.IDUnealta=au.IDUnealta
inner join Angajati a
on a.IDAngajat=au.IDAngajat
inner join FunctieAngajat fa
on fa.IDAngajat=a.IDAngajat
inner join Functii func
on fa.IDFunctie=func.IDFunctie
inner join SalariuFunctie sf
on sf.IDFunctie=func.IDFunctie
inner join Salarii sal
on sal.IDSalariu=sf.IDSalariu
where sal.SalariuNet>=2000
group by f.NumeFurnizor

-- afiseaza toti clientii(ID,Nume,Prenume) care participa la o expozitie care il are ca responsabil pe angajatul cu id-ul 1 si au email-ul cu extensia gmail.com
select c.IDClient,c.Nume,c.Prenume
from Clienti c inner join Rezervari r
on c.IDClient=r.IDClient inner join Expozitii e
on r.IDExpozitie=e.IDExpozitie inner join Angajati a
on a.IDAngajat=e.IDAngajat
where a.IDAngajat=1 and c.Mail like '%gmail.com'

--Afisarea tuturor angajatilor  care au salarii(se afiseaza si acestea,brut si net) in care sunt incluse peste 5 ore suplimentare, iar data avansului este pe ziua de 1 a lunii, sortat in ordine descrescatoare a salariilor.
select a.Nume,f.NumeFunctie,s.SalariuBrut,s.SalariuNet
from Angajati a inner join FunctieAngajat fa
on fa.IDAngajat=a.IDAngajat inner join Functii f
on f.IDFunctie=fa.IDFunctie inner join SalariuFunctie sf
on sf.IDFunctie=f.IDFunctie inner join Salarii s
on s.IDSalariu=sf.IDSalariu
where s.OreSuplimentare>5 and DAY(s.DataAvans)=1
order by s.SalariuBrut desc

--Afisarea numelui furnizorului, anul de activitate pe piata si id-ul furnizorului care a produs unelte pentru responsabilul pe "Sala sculpturii"

select f.IDFurnizor as ID,f.NumeFurnizor as Nume, f.AnActivitatePiata as AnFurnizor
from Furnizori f inner join FurnizorUnealta fu
on f.IDFurnizor=fu.IDFurnizor inner join Unelte u
on u.IDUnealta=fu.IDUnealta inner join AngajatUnealta au
on au.IDUnealta=u.IDUnealta inner join Angajati a
on a.IDAngajat=au.IDAngajat inner join Expozitii e
on e.IDAngajat=a.IDAngajat
where e.Locatie='Sala sculpturii'

--11. afisarea tuturor creatorilor care prezinta exponate pentru sala angajatilor care au unealta 'Tabla portabila'
select c.Nume,c.Prenume,c.IDCreator
from Creatori c inner join CreatorExponat ce
on c.IDCreator=ce.IDCreator inner join Exponate e
on ce.IDExponat =e.IDExponat inner join Expozitii expo
on expo.IDExpozitie=e.IDExpozitie inner join Angajati a
on a.IDAngajat=expo.IDAngajat inner join AngajatUnealta au
on au.IDAngajat=a.IDAngajat inner join Unelte u
on au.IDUnealta=u.IDUnealta
where u.Nume='Tabla portabila'

-- 12.afisarea tuturor angajatilor a caror diferenta dintre salariu net pe functie si brut pe functie este de peste 1500 lei(sse vor afisa si duplicate de tip angajat functie)
select a.Nume,a.Prenume,a.NumarTelefon,f.NumeFunctie,s.SalariuBrut-s.SalariuNet as DiferentaSalarii
from Angajati a inner join FunctieAngajat fa
on a.IDAngajat=fa.IDAngajat inner join  Functii f
on fa.IDFunctie=f.IDFunctie inner join SalariuFunctie sf
on f.IDFunctie=sf.IDFunctie inner join Salarii s
on sf.IDSalariu=s.IDSalariu
where s.SalariuBrut-s.SalariuNet>900 and a.NumarTelefon like '072%'

--13 afisarea tuturor angajatilor ale caror sali au produs incasari din rezervari peste 1000 de lei, dar si incasarile acestora
select a.IDAngajat,a.Nume,a.Prenume,i.SumaIncasata
from Angajati a inner join Expozitii e
on a.IDAngajat=e.IDAngajat inner join Rezervari r
on r.IDExpozitie=e.IDExpozitie inner join IncasareRezervare ir
on ir.IDRezervare=r.IDRezervare inner join Incasari i
on i.IDIncasare=ir.IDIncasare
where i.SumaIncasata>1000

--14

select c.IDClient,c.Nume,c.Prenume
from Clienti c inner join Rezervari r
on c.IDClient=r.IDClient inner join Expozitii e
on e.IDExpozitie=r.IDExpozitie inner join Angajati a
on a.IDAngajat=e.IDAngajat inner join FunctieAngajat fa
on a.IDAngajat=fa.IDAngajat inner join Functii f
on fa.IDFunctie=f.IDFunctie
where f.Executie='DA' and c.TipClient='VIP'

--15 afisarea tuturor angajatilor care au in salile de expozitie opere facute de artisti din Bucuresti, Romania

select a.IDAngajat,a.Nume,a.Prenume
from Angajati a inner join Expozitii e
on a.IDAngajat=e.IDAngajat inner join Exponate ex
on e.IDExpozitie=ex.IDExpozitie inner join CreatorExponat ce
on ex.IDExponat=ce.IDExponat inner join Creatori c
on ce.IDCreator=c.IDCreator
where c.Adresa='Bucuresti, Romania'
--16 Afisarea tuturor functiilor pentru care suma impozitelor din baza de date depaseste 25%

select f.IDFunctie,f.NumeFunctie
from Functii f inner join SalariuFunctie sf
on f.IDFunctie=sf.IDFunctie inner join Salarii s
on sf.IDSalariu=s.IDSalariu inner join Impozite i
on s.IDSalariu=i.IDSalariu
where i.ProcentAsigurareMedicala+i.ProcentCasaPensii+i.ProcentTaxaSalariat>25

--17 Afisarea salariilor tuturor angajatilor din baza de date, a functiilor acestora si a salariilor obtinute in urma micsorarii de pe urma impozitelor trecute in baza de date( SalariuBrut* procent/100)

select a.IDAngajat,a.Nume,a.Prenume,f.NumeFunctie, s.SalariuBrut-s.SalariuBrut*(i.ProcentAsigurareMedicala+i.ProcentCasaPensii+i.ProcentTaxaSalariat)/100 as Salariu
from Angajati a inner join FunctieAngajat fa
on a.IDAngajat=fa.IDAngajat inner join Functii f
on fa.IDFunctie=f.IDFunctie inner join SalariuFunctie sf
on f.IDFunctie=sf.IDFunctie inner join Salarii s
on sf.IDSalariu=s.IDSalariu inner join Impozite i
on i.IDSalariu=s.IDSalariu

--18. Exponate ale angajatilor cu Functia de tehnicieni

select e.IDExponat,e.Nume,e.Descriere
from Exponate e inner join Expozitii expo
on e.IDExpozitie=expo.IDExpozitie inner join Angajati a
on expo.IDAngajat=a.IDAngajat inner join FunctieAngajat fa
on a.IDAngajat=fa.IDAngajat inner join Functii f
on fa.IDFunctie=f.IDFunctie
where f.NumeFunctie='Tehnician' and f.IntervalOrar='9:00 - 17:00'
select* from Functii

--19 Clientii care  au efectuat o rezervare dupa cea efectuat de Balan Adrian
select c.IDClient,c.Nume,c.Prenume,r.DataRezervare
from Clienti c inner join Rezervari r
on c.IDClient=r.IDClient
where r.DataRezervare> ALL
(
select r.DataRezervare
from Clienti c inner join Rezervari r
on c.IDClient=r.IDClient
where c.Nume='Balan' and c.Prenume='Adrian'

)
--20 Angajatii care sunt mai vechi la locul de munca decat angajatul administrator sau manager (alegerea se face in functie de cel care este mai nou angajat)

select a.IDAngajat,a.Nume,a.Prenume
from Angajati a
where a.DataAngajare<
(Select top (1) a.DataAngajare
from Angajati a inner join FunctieAngajat fa
on a.IDAngajat=fa.IDAngajat inner join Functii f
on fa.IDFunctie=f.IDFunctie
where f.NumeFunctie='Administrator' or f.NumeFunctie='Manager'
order by a.DataAngajare desc)

--21 Angajatii care au salariu mai mare decat salariul maxim pentru un tehnician
select distinct a.Nume,a.Prenume
from Angajati a inner join FunctieAngajat fa
on a.IDAngajat=fa.IDAngajat inner join Functii f
on fa.IDFunctie=f.IDFunctie inner join SalariuFunctie sf
on f.IDFunctie=sf.IDFunctie inner join Salarii s
on sf.IDSalariu=s.IDSalariu
where s.SalariuNet>
(select top(1) s.SalariuNet
from Angajati a inner join FunctieAngajat fa
on a.IDAngajat=fa.IDAngajat inner join Functii f
on fa.IDFunctie=f.IDFunctie inner join SalariuFunctie sf
on f.IDFunctie=sf.IDFunctie inner join Salarii s
on sf.IDSalariu=s.IDSalariu
where f.NumeFunctie='Tehnician'
order by s.SalariuNet desc
)

--22 Afisarea codSRL a tuturor furnizorilor cu durata contractului de cel putin 12 ani care produc prin produsele lor vanzari de peste 500 de lei.

select f.IDFurnizor,f.codSRL
from Furnizori f inner join FurnizorSuvenir fs
on f.IDFurnizor=fs.IDFurnizor inner join Suveniruri s
on fs.IDSuvenir=s.IDSuvenir inner join IncasareSuvenir ins
on s.IDSuvenir=ins.IDsuvenir inner join Incasari inc
on ins.IDIncasare=inc.IDIncasare
where inc.SumaIncasata>500 and f.DurataContractFurnizare>=12

--23  Afisarea tuturor exponatelor(ID,Nume,Descriere) care se afla in expozitiile angajatilor din Bucuresti

select expo.IDExponat,expo.Nume,expo.Descriere
from Angajati a inner join Expozitii e
on a.IDAngajat=e.IDAngajat inner join Exponate expo
on e.IDExpozitie=expo.IDExpozitie
where a.Localitate='Bucuresti'

-- 24 Afisarea tuturor Clientilor care au avut ultima vizita inainte ca Vasilescu Andrei sa se angajeze
select IDClient,Nume,Prenume,DataUltimaVizita
from Clienti
where DataUltimaVizita <(
select DataAngajare
from Angajati
where Nume='Vasilescu' and Prenume='Andrei'
)

--26 Afisarea celor mai vechi 3 angajati
select top(3) DataAngajare as DataAngajare,IDAngajat,Nume,Prenume
from Angajati
group by DataAngajare,IDAngajat,Nume,Prenume
order by DataAngajare

--27 Numarul de unelte grupate pe angajati in care numarul de unelte depaseste 3

select a.IDAngajat,a.Nume,a.Prenume,count(*) as NumarUnelte
from Angajati a inner join AngajatUnealta au
on a.IDAngajat=au.IDAngajat inner join Unelte u
on au.IDUnealta=u.IDUnealta
group by a.IDAngajat,a.Nume,a.Prenume
having count(*)>3

--28  Gruparea angajatilor in functie de suma impozitelor prezente in baza de date in care angajatii au un impozit la casaPEnsii mai mare de 5 la suta.

select i.ProcentAsigurareMedicala+i.ProcentCasaPensii+i.ProcentTaxaSalariat as ImpozitTotal,a.IDAngajat,a.Nume,a.Prenume
from Angajati a inner join FunctieAngajat fs
on a.IDAngajat=fs.IDAngajat inner join Functii f
on fs.IDFunctie=f.IDFunctie inner join SalariuFunctie sf
on f.IDFunctie=sf.IDFunctie inner join Salarii s
on sf.IDSalariu=s.IDSalariu inner join Impozite i
on s.IDSalariu=i.IDSalariu
group by i.ProcentAsigurareMedicala+i.ProcentCasaPensii+i.ProcentTaxaSalariat,i.ProcentCasaPensii,a.IDAngajat,a.Nume,a.Prenume
having i.ProcentCasaPensii>5

--29 Gruparea clientilor in functie de numarul de exponate=2 ale expozitiei la care acestia au rezervare.
select c.Nume,c.Prenume,e.CapacitatePersoane
from Clienti c inner join Rezervari r
on c.IDClient=r.IDClient inner join Expozitii e
on r.IDExpozitie=e.IDExpozitie
where c.TipClient='VIP'
group by e.CapacitatePersoane,c.Nume,c.Prenume
having e.CapacitatePersoane<75

--30 adresa furnizorilor care produc numarul maxim de produse de tip suvenir

select f.IDFurnizor,f.Adresa,count(*) as NumarSuveniruri
from Furnizori f inner join FurnizorSuvenir fs
on f.IDFurnizor=fs.IDFurnizor
group by f.IDFurnizor,f.Adresa
having count(*)=3

--31  cod srl al furnizorilor si ultima livrare pentru numarul minim de unelte posibil
select f.IDFurnizor,f.CodSRL
from Furnizori f inner join FurnizorUnealta fu
on f.IDFurnizor=fu.IDFurnizor inner join Unelte u
on fu.IDUNealta=u.IDUnealta
group by f.IDFurnizor,f.CodSRL
having count(*)=
(select top(1) count(*)
from Furnizori f inner join FurnizorUnealta fu
on f.IDFurnizor=fu.IDFurnizor inner join Unelte u
on fu.IDUnealta=u.IDUnealta
group by f.IDFurnizor
order by count(*) 
)

--32 
select a.IDAngajat,a.Nume,a.Prenume
from Angajati a inner join Expozitii e
on a.IDAngajat=e.IDAngajat inner join Rezervari r
on e.IDExpozitie=r.IDExpozitie inner join Clienti c
on r.IDClient=c.IDClient
group by r.NumarBilete,a.IDAngajat,a.Nume,a.Prenume
having r.NumarBilete=2

--33 Afisarea salariilor si a angajatilor care corespund acelor salarii

select s.SalariuBrut,s.SalariuNet,a.Nume,a.Prenume,a.AniExperientaDomeniu
from Angajati a inner join FunctieAngajat fa
on a.IDAngajat=fa.IDAngajat inner join Functii f
on fa.IDFunctie=f.IDFunctie inner join SalariuFunctie sf
on f.IDFunctie=sf.IDFunctie inner join Salarii s
on sf.IDSalariu=s.IDSalariu
group by s.SalariuBrut,s.SalariuNet,a.Nume,a.Prenume,a.AniExperientaDomeniu

-- 34 Unelte + nr angajati care au acces

select u.IDUnealta,count(au.IDUnealta) as NumarAngajatiAcces
from Unelte u inner join AngajatUnealta au
on u.IDUnealta=au.IDUnealta inner join Angajati a
on au.IDAngajat=a.IDAngajat
group by u.IDUnealta

-- 35 Afisarea tuturor salilor si a descrierilor si a numarului de bilete rezervate de clienti,cat si nr de tlf al clientilor pentru acestea dupa ora 15

select e.Locatie,e.Descriere,r.NumarBilete,c.Telefon
from Expozitii e inner join Rezervari r
on e.IDExpozitie=r.IDExpozitie inner join Clienti c
on r.IDClient=c.IDClient
where r.OraRezervare>15
group by e.Locatie,e.Descriere,r.NumarBilete,c.Telefon

--36
select f.NumeFurnizor,f.CodSRL,count(fu.IDUnealta) as NumarUnelte
from Furnizori f inner join FurnizorUnealta fu
on f.IDFurnizor=fu.IDFurnizor inner join Unelte u
on fu.IDUnealta=u.IDUnealta inner join AngajatUnealta au
on u.IDUnealta=au.IDUnealta inner join Angajati a
on au.IDAngajat=a.IDAngajat
where a.Departament='Ingrijire'
group by f.NumeFurnizor,f.CodSRL,fu.IDUnealta

--37
select f.NumeFurnizor,count(fs.IDFurnizor) as NumarSuveniruriCerute
from Furnizori f inner join FurnizorSuvenir fs
on f.IDFurnizor=fs.IDFurnizor inner join Suveniruri s
on fs.IDSuvenir=s.IDSuvenir inner join IncasareSuvenir incs
on s.IDSuvenir=incs.IDSuvenir inner join Incasari inc
on incs.IDIncasare=inc.IDIncasare
where inc.SumaIncasata<1500 and s.TaraProvenienta =
(
	select TaraProvenienta
	from Suveniruri
	where IDSuvenir=1
)
group by f.NumeFurnizor,fs.IDFurnizor



--38 
select max(u.Nume) as NumeUnealta ,max(u.Marca) as Marca,count(au.IDAngajat) as NumarUtilizatori
from Unelte u inner join AngajatUnealta au
on u.IDUnealta=au.IDUnealta inner join Angajati a
on au.IDAngajat=a.IDAngajat
group by u.IDUnealta
having count(au.IDAngajat)=
(
select top(1) count(au.IDAngajat)
from Unelte u inner join AngajatUnealta au
on u.IDUnealta=au.IDUnealta inner join Angajati a
on au.IDAngajat=a.IDAngajat
group by u.IDUnealta
order by count(au.IDAngajat) desc
)
--39
select u.IDUnealta,u.Nume,a.Nume,a.Prenume,a.IDAngajat
from Unelte u inner join AngajatUnealta au
on u.IDUnealta=au.IDUnealta inner join Angajati a
on au.IDAngajat=a.IDAngajat inner join FunctieAngajat fa
on a.IDAngajat= fa.IDAngajat 
where a.Departament='Ingrijire'
group by u.IDUnealta,u.Nume,a.Nume,a.Prenume,a.IdAngajat
--40
select YEAR(f.DataScoatereLaConcurs),count(fa.IDAngajat)
from Angajati a inner join FunctieAngajat fa
on a.IDAngajat=fa.IDAngajat inner join Functii f
on fa.IDFunctie=f.IDFunctie
group by YEAR(f.DataScoatereLaConcurs)
--41
select top(1) a.Nume,a.Prenume,count(c.IDClient) as NumarClienti
from Angajati a inner join Expozitii e
on a.IDAngajat=e.IDAngajat  inner join Rezervari r
on r.IDExpozitie=e.IDExpozitie inner join Clienti c
on c.IDClient=r.IDClient
group by a.Nume,a.Prenume,c.IDClient
order by count(c.IDClient) desc

--42 
select sum(s.SalariuNet)/count(s.SalariuNet) as SalariuMediu
from Angajati a inner join FunctieAngajat fa
on a.IDAngajat=fa.IDAngajat inner join Functii f
on fa.IDFunctie=f.IDFunctie inner join SalariuFunctie sf
on f.IDFunctie=sf.IDFunctie inner join Salarii s
on s.IDSalariu=sf.IDSalariu
where a.Departament in ('Ingrijire','Management')
--43
select sum(Pret*BucatiStoc) as SumaIncasata
from Suveniruri
where Nume like 'Tricou%'

--44
select c.IDCreator,count(*) as NumarCreatiiExpuse
from Creatori c inner join CreatorExponat ce
on c.IDCreator=ce.IDCreator inner join Exponate e
on ce.IDExponat=e.IDExponat
where c.Studii='Facultatea de Arte'
group by c.IDCreator

--45
select *
from Furnizori
EXCEPT
select *
from Furnizori
where CodSRL like '%0'

--46
select*
from Furnizori
where Adresa like '%Bucuresti'
Union
select*
from Furnizori
where Adresa like '%Cluj-Napoca'

--47

select*
from Suveniruri
where IDSuvenir%2=0
intersect
select*
from Suveniruri
where IDSuvenir%5=0

--48

select a.IDAngajat,a.Nume,a.Prenume
from Angajati a inner join FunctieAngajat fa
on a.IDAngajat=fa.IDAngajat inner join Functii f
on fa.IDFunctie=f.IDFunctie
where f.Executie='DA'
intersect
select IDAngajat,Nume,Prenume
from Angajati
where AniExperientaDomeniu>2

--49
select IDClient,Nume,Prenume,Telefon,TipClient
from Clienti
where Mail like '%@gmail.com'
EXCEPT
select IDClient,Nume,Prenume,Telefon,TipClient
from Clienti
where Mail like '%@gmail.com' and TipClient = 'REGULAR'

--50

select e.IDExpozitie,e.Locatie,count(e.IDExpozitie) as NumarVaze
from Expozitii e inner join Exponate ex
on e.IDExpozitie=ex.IDExpozitie
where ex.Tip='Bijuterie'
group by e.IDExpozitie,e.Locatie
having count(e.IDExpozitie)>=2

--51

select distinct c.IDCreator,c.Nume,c.Prenume
from Creatori c inner join CreatorExponat ce
on c.IDCreator=ce.IDCreator inner join Exponate expo
on ce.IDExponat=expo.IDExponat inner join Expozitii e
on expo.IDExpozitie=e.IDExpozitie inner join Angajati a
on e.IDAngajat=a.IDAngajat inner join AngajatUnealta au
on a.IDAngajat=au.IDAngajat inner join Unelte u
on au.IDUnealta=u.IDUnealta inner join FurnizorUnealta fu
on u.IDUnealta=fu.IDUnealta inner join Furnizori f
on fu.IDFurnizor=f.IDFurnizor
where f.CodSRL like '%0'

--52 
select s.SalariuNet,count(*) as NumarAngajati
from Angajati a inner join FunctieAngajat fu
on a.IDAngajat=fu.IDAngajat inner join Functii f
on fu.IDFunctie=f.IDFunctie inner join SalariuFunctie sf
on f.IDFunctie=sf.IDFunctie inner join Salarii s
on s.IDSalariu=sf.IDSalariu
where s.IDSalariu % 2 =1
group by s.SalariuNet


--53
select sum(i.SumaIncasata) as SumaTotala
from Suveniruri s inner join IncasareSuvenir incs
on s.IDSuvenir=incs.IDSuvenir inner join Incasari i
on incs.IDIncasare=i.IDincasare
where s.Nume='Magnet'

--54
declare @variabila int=10
select count(*) as NumarAngajati
from Angajati a inner join FunctieAngajat fa
on a.IDAngajat=fa.IDAngajat inner join Functii f
on fa.IDFunctie=f.IDFunctie inner join SalariuFunctie sf
on f.IDFunctie=sf.IDFunctie inner join Salarii s
on sf.IDSalariu=s.IDSalariu inner join Impozite i
on s.IDSalariu=i.IDSalariu
where i.ProcentAsigurareMedicala=@variabila
group by i.ProcentAsigurareMedicala

--55
select MONTH(a.DataExpirareContract) as Luna ,count(*) as NumarAngajati
from Angajati a
where MONTH(a.DataExpirareContract) in ('6','7','8')
group by MONTH(a.DataExpirareContract)

--56
select a.IDAngajat,a.Nume,a.Prenume
from Angajati a inner join Expozitii e
on a.IDAngajat=e.IDAngajat inner join Rezervari r
on r.IDExpozitie=e.IDExpozitie inner join Clienti c
on c.IDClient=r.IDClient
where c.Telefon like '%1' or c.Telefon like '%3' or c.Telefon like '%5' or c.Telefon like '%7' or c.Telefon like '%9'

--57 
select f.NumeFurnizor,count(*) as NumarAngajati
from Angajati a inner join AngajatUnealta au
on a.IDAngajat=au.IDAngajat inner join Unelte u
on au.IDUnealta=u.IDUnealta inner join FurnizorUnealta fu
on u.IDUnealta= fu.IDUnealta inner join Furnizori f
on fu.IDFurnizor=f.IDFurnizor
where f.CodSRL like '%0'
group by f.NumeFurnizor

--58

select a.IDAngajat,a.Nume,a.Prenume,a.NumarTelefon,expo.Nume,expo.Descriere
from Angajati a inner join Expozitii e
on a.IDAngajat=e.IDAngajat inner join Exponate expo
on expo.IDExpozitie=e.IDExpozitie
where expo.TaraAparitie='Grecia'
union
select a.IDAngajat,a.Nume,a.Prenume,a.NumarTelefon,expo.Nume,expo.Descriere
from Angajati a inner join Expozitii e
on a.IDAngajat=e.IDAngajat inner join Exponate expo
on expo.IDExpozitie=e.IDExpozitie
where expo.TaraAparitie='Italia'

--59
select YEAR(AnActivitatePiata) as AnulAparitiei,count(*) as NumarFurnizoriAparuti
from Furnizori
group by YEAR(AnActivitatePiata)

--60 
select c.IDClient,c.Nume,c.Prenume,a.Nume,a.Prenume
from Clienti c inner join Rezervari r
on c.IDClient=r.IDClient inner join Expozitii ex
on r.IDExpozitie=ex.IDExpozitie inner join Angajati a
on ex.IDAngajat=a.IDAngajat inner join FunctieAngajat fa
on a.IDAngajat=fa.IDAngajat inner join Functii f
on fa.IDFunctie=f.IDFunctie
where f.NumeFunctie='Arhivar'

--61

select c.Nume,c.Prenume,count(*) as NumarRezervari
from Clienti c inner join Rezervari r
on c.IDClient=r.IDClient
group by c.Nume,c.Prenume
having count(*)=( select  top(1) count(*) as NumarRezervari
				  from Clienti c inner join Rezervari r
				  on c.IDClient=r.IDClient
				  group by c.IDClient
				  order by NumarRezervari desc
				  )
--62
select distinct c.IDClient,c.Nume,c.Prenume,c.TipClient
from Clienti c
inner join Rezervari r
on c.IDClient=r.IDClient
inner join Expozitii e
on e.IDExpozitie=r.IDExpozitie
inner join Angajati a
on a.IDAngajat=e.IDExpozitie
inner join AngajatUnealta au
on au.IDAngajat=a.IDAngajat
inner join Unelte u
on u.IDUnealta=au.IDUnealta
inner join FurnizorUnealta fu
on fu.IDUnealta=u.IDUnealta
inner join Furnizori f
on f.IDFurnizor=fu.IDFurnizor
inner join  FurnizorSuvenir fs
on fs.IDFurnizor=f.IDFurnizor
inner join Suveniruri s
on s.IDSuvenir=fs.IDSuvenir
inner join IncasareSuvenir incs
on incs.IDSuvenir=s.IDSuvenir
inner join Incasari inc
on inc.IDIncasare=incs.IDIncasare
where inc.SumaIncasata>500  and c.TipClient <>'VIP'

--63
select incs.DataIncasare,count(incs.IDSuvenir) as  NumarSuveniruri
from Suveniruri s inner join IncasareSuvenir incs
on s.IDSuvenir=incs.IDSuvenir inner join Incasari i
on i.IDIncasare=incs.IDSuvenir
group by incs.DataIncasare
having count(incs.IDSuvenir)> 1


--UPDATE
--1
UPDATE Clienti 
set ClientFidel='DA',TipClient='VIP'
where IDClient in(
select c.IDClient
from Clienti c inner join Rezervari r
on c.IDClient=r.IDClient inner join Expozitii e
on e.IDExpozitie=r.IDExpozitie
where e.Locatie='Sala Sculpturii'
)
select* from Clienti

--62
declare @contor1 int;
declare @contor2 int;
set @contor1=1
set @contor2=1
while @contor2<15
begin
update Clienti
set DataUltimaVizita =
(select top(1) r.DataRezervare
from Clienti c inner join Rezervari r
on  c.IDClient=r.IDClient
where c.IDClient=@contor1
)
where IDClient=@contor2;
set @contor1=@contor1+1;
set @contor2=@contor2+1;
end
select* from Clienti

--63
update Salarii
set SalariuBrut=SalariuBrut+0.05*SalariuBrut,SalariuNet=SalariuNet+0.05*SalariuNet
from Angajati a inner join FunctieAngajat fa
on a.IDAngajat=fa.IDAngajat inner join Functii f
on fa.IDFunctie=f.IDFunctie inner join SalariuFunctie sf
on f.IDFunctie=sf.IDFunctie inner join Salarii s
on s.IDSalariu=sf.IDSalariu
where a.Departament='Ingrijire'

--64
update Impozite
set ProcentAsigurareMedicala=ProcentAsigurareMedicala-2
from Angajati a inner join FunctieAngajat fa
on a.IDAngajat=fa.IDAngajat inner join Functii f
on fa.IDFunctie=f.IDFunctie inner join SalariuFunctie sf
on f.IDFunctie=sf.IDFunctie inner join Salarii s
on s.IDSalariu=sf.IDSalariu inner join Impozite i
on s.IDSalariu=i.IDSalariu
where a.Departament='Marketing' or a.Departament='IT'

--65
update Suveniruri
set Pret=
(select sum(Pret)/count(Pret)
from Furnizori f inner join FurnizorSuvenir fs
on f.IDFurnizor=fs.IDFurnizor inner join Suveniruri s
on s.IDSuvenir=fs.IDSuvenir
where f.Adresa like '%Bucuresti')
from Furnizori f inner join FurnizorSuvenir fs
on f.IDFurnizor=fs.IDFurnizor inner join Suveniruri s
on s.IDSuvenir=fs.IDSuvenir
where f.Adresa like '%Bucuresti'
select* from Suveniruri

--66
update Unelte
set DataExpirareGarantie=DateADD(MONTH,5,DataExpirareGarantie)
from Unelte u inner join AngajatUnealta au
on u.IDUnealta=au.IDUnealta inner join Angajati a
on a.IDAngajat=au.IDAngajat inner join FunctieAngajat fa
on fa.IDAngajat=a.IDAngajat inner join Functii f
on f.IDFunctie=fa.IDFunctie
where f.NumeFunctie='Manager'

--67

declare @contor int;
set @contor=1;
WHILE @contor<15
begin
update Incasari
set DataIncasare=DATEADD(day,@contor,'2023/05/01')
where IDIncasare=@contor
set @contor=@contor+1
end


--68
declare @dataNastereAutor DATE;
set @dataNastereAutor=          (select c.DataNastere
								 from Creatori c inner join CreatorExponat ce
								 on c.IDCreator=ce.IDCreator inner join Exponate e
								 on e.IDExponat=ce.IDExponat
								 where e.IDExponat=40)
update Exponate
set DataAparitie=DATEADD(year,20,@dataNastereAutor)
where IDExponat=40
select* from Exponate
where IDExponat=40

--69

update Rezervari
set OraRezervare=15
from Functii f inner join FunctieAngajat fa
on f.IDFunctie=fa.IDFunctie inner join Angajati a
on fa.IDAngajat=a.IDAngajat inner join Expozitii e
on e.IDAngajat=a.IDAngajat inner join Rezervari r
on r.IDExpozitie=e.IDExpozitie
where f.NumeFunctie='Curator'

--70
update Salarii
set SalariuBrut=SalariuBrut+0.1*SalariuBrut,SalariuNet=SalariuNet+0.1*SalariuNet
where OreSuplimentare>10
select* from Salarii

--71 
declare @AvansMediu int;
declare @celMaiMareSalariu int;
set @AvansMediu=(select avg(ValoareAvans)
					 from Salarii)
set @celMaiMareSalariu=(select max(SalariuBrut)
						from Salarii)
update Salarii
set SalariuBrut=SalariuBrut-@AvansMediu
where SalariuBrut=@celMaiMareSalariu
select* from Salarii

--72
update Furnizori
set DurataContractFurnizare=DurataContractFurnizare+3
where Year(AnActivitatePiata)<2012
select* from Furnizori

--73

update Expozitii
set CapacitatePersoane=CapacitatePersoane/2
from Expozitii e inner join Angajati a
on e.IDAngajat=a.IDAngajat inner join FunctieAngajat fa
on fa.IDAngajat=a.IDAngajat inner join Functii f
on f.IDFunctie=fa.IDFunctie
where f.NumeFunctie='Ghid turistic'

--74

update Salarii
set SalariuNet=SalariuNet+100
from Salarii s inner join SalariuFunctie sf
on s.IDSalariu=sf.IDSalariu inner join Functii f
on f.IDFunctie=sf.IDFunctie inner join FunctieAngajat fa
on f.IDFunctie=fa.IDFunctie inner join Angajati a
on a.IDAngajat=fa.IDAngajat inner join Expozitii e
on e.IDAngajat=a.IDAngajat inner join Exponate expo
on e.IDExpozitie=expo.IDExpozitie
where expo.Tip='Bijuterie'

--75
alter table Impozite
drop column GarantieBijuterii
alter table Impozite
	add GarantieBijuterii int;
	select* from Impozite
update Impozite
set GarantieBijuterii=2
from Impozite i inner join Salarii s
on i.IDSalariu=s.IDSalariu inner join SalariuFunctie sf
on sf.IDSalariu=s.IDSalariu inner join Functii f
on f.IDFunctie=sf.IDFunctie inner join FunctieAngajat fa
on fa.IDFunctie=f.IDFunctie inner join Angajati a
on a.IDAngajat=fa.IDAngajat inner join Expozitii e
on e.IDAngajat=a.IDAngajat inner join Exponate expo
on expo.IDExpozitie=e.IDExpozitie
where expo.tip='Bijuterie'

--76
update Rezervari
set OraRezervare=20
from Rezervari r inner join Expozitii e
on r.IDExpozitie=e.IDExpozitie inner join Angajati a
on a.IDAngajat=e.IDAngajat
where a.IDAngajat=(
select top(1) a.IDAngajat
from Angajati a inner join AngajatUnealta au
on a.IDAngajat=au.IDAngajat inner join Unelte u
on u.IDUnealta=au.IDUnealta
group by a.IDAngajat
order by count(au.IDAngajat) desc
)
--77
declare @minim int;
set @minim=(select min(PretBilet) from Expozitii)
update Expozitii
set PretBilet=PretBilet+@minim/2
where IDExpozitie in(
select e.IDExpozitie
from Expozitii e inner join Rezervari r
on r.IDExpozitie=e.IDExpozitie
group by e.IDExpozitie
having sum(r.NumarBilete)>5
)
-- 78 
update Unelte
set TipUnealta='Manual'
where Marca='Canon' or Marca='Bic' and TipUnealta='Recuzita'


--79
update Clienti
set TipClient='EXTENDED'
from Clienti c inner join Rezervari r
on c.IDClient=r.IDClient inner join Expozitii e
on e.IDEXpozitie=r.IDExpozitie inner join Exponate expo
on expo.IDExpozitie=e.IDExpozitie inner join CreatorExponat ce
on ce.IDExponat=expo.IDExponat inner join Creatori cr
on cr.IDCreator=ce.IDCreator
where cr.TipuriPreferate='Pictura'

--80 
update Angajati
set DataExpirareContract=DATEADD(year,2,DataExpirareContract)
where YEAR(DataExpirareContract)=2022
--Views
--1
if object_ID('SalariereAngajati','V') is not null
	drop view SalariereAngajati
go
create view SalariereAngajati
as
select a.Nume,a.Prenume,max(a.NumarTelefon) as NumarTelefon,max(a.Departament) as Departament,
sum(s.SalariuNet) as SalariuTotal,count(fa.IDAngajat) as NumarFunctii
from Angajati a 
inner join FunctieAngajat fa
on a.IDAngajat=fa.IDAngajat 
inner join Functii f
on f.IDfunctie=fa.IDFunctie 
inner join SalariuFunctie sf
on sf.IDFunctie=f.IDFunctie 
inner join Salarii s
on s.IDSalariu=sf.IDSalariu
group by a.Nume,a.Prenume

--2
if object_ID('AngajatiBijuterii','V') is not null
	drop view AngajatiBijuterii
go
create view AngajatiBijuterii
as
select a.IDAngajat,max(a.Nume) as Nume,max(a.Prenume) as Prenume,max(a.NumarTelefon) as NumarTelefon
,max(a.Localitate) as Localitate,count(*) as NumarBijuterii
from Angajati a 
inner join Expozitii e
on a.IDAngajat=e.IDAngajat 
inner join Exponate expo
on expo.IDExpozitie=e.IDExpozitie
where expo.Tip='Bijuterie'
group by a.IDAngajat

--3
if object_ID('ClientiExponate','V') is not null
	drop view ClientiExponate
go
create view ClientiExponate
as
select c.IDClient,max(c.Nume) as Nume,max(c.Prenume) as Prenume ,max(e.Locatie) as Locatie,count(e.IDExpozitie) as NumarExponate
from Clienti c 
inner join Rezervari r
on r.IDClient=c.IDClient 
inner join Expozitii e
on e.IDExpozitie=r.IDExpozitie 
inner join Exponate expo
on expo.IDExpozitie=e.IDExpozitie
where e.Locatie='Sala Sculpturii'
group by c.IDClient
union
select c.IDClient,max(c.Nume) as Nume,max(c.Prenume) as Prenume ,max(e.Locatie) as Locatie,count(e.IDExpozitie) as NumarExponate
from Clienti c 
inner join Rezervari r
on r.IDClient=c.IDClient 
inner join Expozitii e
on e.IDExpozitie=r.IDExpozitie 
inner join Exponate expo
on expo.IDExpozitie=e.IDExpozitie
where e.Locatie='Galeria Renasterii'
group by c.IDClient

--4
if object_ID('IncasariSuveniruri','V') is not null
	drop view IncasariSuveniruri
go
create view IncasariSuveniruri
as
select f.NumeFurnizor,s.Nume,s.Tip,s.Pret*s.BucatiStoc as ValoareStocRamas,i.SumaIncasata,
s.Pret*s.BucatiStoc+i.SumaIncasata as SumaPosibilaIncasare
from Furnizori f
inner join FurnizorSuvenir fs
on fs.IDFurnizor=f.IDFurnizor
inner join Suveniruri s
on fs.IDSuvenir=s.IDSuvenir
inner join IncasareSuvenir incs
on s.IDSuvenir=incs.IDSuvenir
inner join Incasari i
on i.IDIncasare=incs.IDIncasare
where i.SumaIncasata>=500 

--5
if object_ID('AngajatiResponsabili','V') is not null
	drop view AngajatiResponsabili
go
create view AngajatiResponsabili
as
select c.IDCreator,c.Nume,c.Prenume,c.TipuriPreferate,e.Nume as Exponat,e.Descriere,a.Nume as NumeAngajat,a.Prenume as PRenumeAngajat,a.NumarTelefon
from Creatori c inner join CreatorExponat ce
on c.IDCreator=ce.IDCreator inner join Exponate e
on ce.IDExponat=e.IDExponat inner join Expozitii expo
on expo.IDExpozitie=e.IDExpozitie inner join Angajati a
on a.IDAngajat=expo.IDAngajat

--6
if object_ID('AngajatiUnelte','V') is not null
	drop view AngajatiUnelte
go
create view AngajatiUnelte
as
select max(a.Nume) as Nume,max(a.Prenume) as Prenume,max(a.NumarTelefon) as NumarTelefon,count(au.IDAngajat) as UnelteInventar
from Angajati a inner join AngajatUnealta au
on a.IDAngajat=au.IDAngajat inner join Unelte u
on u.IDUnealta=au.IDUnealta
group by a.IDAngajat

--7

if object_ID('FunctiiImpozit','V') is not null
	drop view FunctiiImpozit
go
create view FunctiiImpozit
as
select f.NumeFunctie,s.SalariuBrut,s.SalariuNet,i.ProcentAsigurareMedicala+i.ProcentCasaPensii+i.ProcentTaxaSalariat
as ImpozitTotal,
s.SalariuBrut-s.SalariuBrut*(i.ProcentAsigurareMedicala+i.ProcentCasaPensii+i.ProcentTaxaSalariat)/100 as Salariu
from Functii f inner join SalariuFunctie sf
on f.IDFunctie=sf.IDFunctie inner join Salarii s
on s.IDSalariu=sf.IDSalariu inner join Impozite i
on i.IDSalariu=s.IDSalariu
where f.Executie='DA'

--Proceduri stocate
--1
IF OBJECT_ID('ClientExponate', 'P') is not null
	DROP PROC ClientExponate
GO
CREATE PROC ClientExponate
	@nume as nvarchar(40),
	@prenume as nvarchar(40)
AS
BEGIN
	select expo.Nume,expo.Descriere
	from Clienti c
	inner join Rezervari r
	on c.IDClient=r.IDClient
	inner join Expozitii e
	on r.IDExpozitie=e.IDExpozitie
	inner join Exponate expo
	on e.IDExpozitie=expo.IDExpozitie
	where c.Nume=@nume and c.Prenume=@prenume
END
exec ClientExponate
@nume='Preda',
@prenume='Radu'
--2
if object_id('ProceduraAngajatiUnelte','P') is not null
	drop procedure ProceduraAngajatiUnelte
go
create procedure ProceduraAngajatiUnelte
	@numarUnelte int
as
begin

select a.IDAngajat,a.Nume,a.Prenume,a.NumarTelefon
from Angajati a 
inner join AngajatUnealta au
on a.IDAngajat=au.IDAngajat
inner join Unelte u
on au.IDUnealta=u.IDUnealta
group by a.IDAngajat,a.Nume,a.Prenume,a.NumarTelefon
having count(au.IDAngajat)=@numarUnelte
end
exec ProceduraAngajatiUnelte
	@numarUnelte=3
--3
if object_id('ProceduraFurnizoriNM','P') is not null
	drop procedure ProceduraFurnizoriNM
go
create procedure ProceduraFurnizoriNM
	@numarUnelte int,
	@numarSuveniruri int
as
begin

select f.NumeFurnizor
from Furnizori f 
inner join FurnizorSuvenir fs
on f.IDFurnizor=fs.IDFurnizor
inner join Suveniruri s
on s.IDSuvenir=fs.IDSuvenir
inner join FurnizorUnealta fu
on fu.IDFurnizor=f.IDFurnizor
inner join Unelte u
on fu.IDUnealta=u.IDUnealta
where f.IDFurnizor in
(
	select f.IDFurnizor
	from Suveniruri  s inner join FurnizorSuvenir fs
	on fs.IDSuvenir= s.IDSuvenir
	inner join Furnizori f
	on f.IDFurnizor=fs.IDFurnizor
	group by f.IDFurnizor
	having count(fs.IDFurnizor)=@numarSuveniruri
)
and u.IDUnealta in
(	
    select f.IDFurnizor
	from Unelte u inner join FurnizorUnealta fu
	on u.IDUnealta=fu.IDUnealta
	inner join Furnizori f
	on f.IDFurnizor=fu.IDFurnizor
	group by f.IDFurnizor
	having count(fu.IDFurnizor)=@numarUnelte

)
group by f.NumeFurnizor
end

exec ProceduraFurnizoriNM
	@numarUnelte=1,
	@numarSuveniruri=2

--4
if object_id('ProceduraClientiSaliRezervari','P') is not null
	drop procedure ProceduraClientiSaliRezervari
go
create procedure ProceduraClientiSaliRezervari
	@numarBileteMinim int,
	@capacitateSalaMinima int,
	@pretMaximBilet int
as
begin
	select c.IDClient,c.Nume,c.Prenume,e.Locatie
	from Clienti c inner join Rezervari r
	on c.IDClient=r.IDClient
	inner join Expozitii e
	on e.IDExpozitie=r.IDExpozitie
	where r.IDClient%2=0 and
	r.NumarBilete>@numarBileteMinim and
	e.CapacitatePersoane>@capacitateSalaMinima and
	e.PretBilet<@pretMaximBilet
end

exec ProceduraClientiSaliRezervari
	@numarBileteMinim=1,
	@capacitateSalaMinima=25,
	@pretMaximBilet=25

--5
if object_id('ProceduraExponateData','P') is not null
	drop procedure ProceduraExponateData
go
create procedure ProceduraExponateData
	@DataInitiala Date,
	@DataFinala Date
as
begin
select expo.DataAparitie,count(*) as NumarExponate
from Expozitii e 
inner join Exponate expo
on e.IDExpozitie=expo.IDExpozitie
inner join Rezervari r
on r.IDExpozitie=expo.IDExpozitie
where r.DataRezervare between @DataInitiala and @DataFinala
group by expo.DataAparitie

end
exec ProceduraExponateData
	@DataInitiala = '2023/05/07',
	@DataFinala='2023/05/09'

--6
if object_id('ProceduraSalariiInterval','P') is not null
	drop procedure ProceduraSalariiInterval
go
create procedure ProceduraSalariiInterval
	@valoareMinima int,
	@valoareMaxima int,
	@procentaj float
as
begin
select f.NumeFunctie,s.SalariuBrut,s.SalariuNet
from Functii f 
inner join SalariuFunctie sf
on f.IDFunctie=sf.IDFunctie
inner join Salarii s
on s.IDSalariu=sf.IDSalariu
where s.SalariuBrut between @valoareMinima and @valoareMaxima
intersect
select f.NumeFunctie,s.SalariuBrut,s.SalariuNet
from Functii f
inner join SalariuFunctie sf
on f.IDFunctie=sf.IDFunctie
inner join Salarii s
on s.IDSalariu=sf.IDSalariu
where s.SalariuNet< s.SalariuBrut*@procentaj
end
exec ProceduraSalariiInterval
	@valoareMinima=3000,
	@valoareMaxima=5000,
	@procentaj=0.9

--7

if object_id('ProceduraAdaugareFunctieAngajat','P') is not null
	drop procedure ProceduraAdaugareFunctieAngajat
go
create procedure ProceduraAdaugareFunctieAngajat
	@SalariuBrut int,
	@SalariuNet int,
	@DataAvans Date,
	@DataLichidare Date,
	@OreSuplimentare int,
	@ValoareAvans int,
	@NumeFunctie nvarchar(40),
	@IntervalOrar nvarchar(15),
	@Responsabilitati nvarchar(100),
	@Executie varchar(3),
	@DataScoatereLaConcurs Date
as
begin
    declare @idFunctie int;
	declare @idSalariu int;
	set @idFunctie = (select top(1) IDFunctie
						from Functii
						order by IDFunctie desc) +1
	set  @idSalariu= (select top(1) IDSalariu
						from Salarii
						order by IDSalariu desc) +1
	insert into Functii(NumeFunctie,IntervalOrar,Responsabilitati,Executie,DataScoatereLaConcurs)
	values(@NumeFunctie,@IntervalOrar,@Responsabilitati,@Executie,@DataScoatereLaConcurs)
	insert into Salarii(SalariuBrut,SalariuNet,DataAvans,DataLichidare,OreSuplimentare,ValoareAvans)
	values (@SalariuBrut,@SalariuNet,@DataAvans,@DataLichidare,@OreSuplimentare,@ValoareAvans)
	insert into SalariuFunctie(IDSalariu,IDFunctie)
	values(@idSalariu,@idFunctie)
	

end
select* from Functii
select* from Salarii
exec ProceduraAdaugareFunctieAngajat
	@SalariuBrut= 3500,
	@SalariuNet=1890,
	@DataAvans='2023/05/02',
	@DataLichidare='2023/05/16',
	@OreSuplimentare=5,
	@ValoareAvans=350,
	@NumeFunctie='Asistent Manager',
	@IntervalOrar= '9:00-18:00',
	@Responsabilitati='Orice cerere a managerului trebuie indeplinita',
	@Executie='NU',
	@DataScoatereLaConcurs='2023/03/02'

--8
if object_id('ProceduraSchimbareNumarTelefon','P') is not null
	drop procedure ProceduraSchimbareNumarTelefon
go
create procedure ProceduraSchimbareNumarTelefon
	@Client int,
	@Nume nvarchar(30),
	@Prenume nvarchar(30),
	@NumarTelefon nvarchar(10)
as
begin
	if @Client=1
		begin
			update Clienti
			set Telefon=@NumarTelefon
			where Nume=@Nume and Prenume= @Prenume
		end
	else
		begin
			update Angajati
			set NumarTelefon=@NumarTelefon
			where Nume=@Nume and Prenume=@Prenume
		end
	
end
exec ProceduraSchimbareNumarTelefon
	@Client=1,
	@Nume='Stefanescu',
	@Prenume='Cristina',
	@NumarTelefon='0753513418'
	select* from Clienti
exec ProceduraSchimbareNumarTelefon
	@Client=0,
	@Nume='Florescu',
	@Prenume='Cristina',
	@NumarTelefon='0735156066'
select* from Angajati
--9
if object_id('ProceduraNumarAngajatiFunctie','P') is not null
	drop procedure ProceduraNumarAngajatiFunctie
go
create procedure ProceduraNumarAngajatiFunctie
	@numarAngajati int
as
begin
select f.IDFunctie,f.NumeFunctie,count(fu.IDFunctie) as NumarAngajati
from Angajati a 
inner join FunctieAngajat fu
on a.IDAngajat=fu.IDAngajat
inner join Functii f
on fu.IDFunctie=f.IDFunctie
group by f.IDFunctie,f.NumeFunctie
having count(fu.IDFunctie)=@numarAngajati
end

exec ProceduraNumarAngajatiFunctie
	@numarAngajati=2

--10
if object_id('ProceduraCreatoriAngajati','P') is not null
	drop procedure ProceduraCreatoriAngajati
go
create procedure ProceduraCreatoriAngajati
	@IDAngajat int
as
begin
select c.Nume,c.Prenume,c.TipuriPreferate
from Angajati a 
inner join Expozitii ex
on a.IDAngajat=ex.IDAngajat
inner join Exponate e
on e.IDExpozitie=ex.IDExpozitie
inner join CreatorExponat ce
on ce.IDExponat=e.IDExponat
inner join Creatori c
on ce.IDCreator=c.IDCreator
where a.IDAngajat=@IDAngajat
end

exec ProceduraCreatoriAngajati
	@IDAngajat=5

--CTE-uri
--1
with maxim as(
	select max(s.SalariuBrut*i.ProcentCasaPensii/100) as Maxim
	from Salarii s
	inner join Impozite i
	on s.IDSalariu=i.IDSalariu
)
select a.Nume,a.Prenume,m.Maxim
from Angajati a 
inner join FunctieAngajat fa
on fa.IDAngajat=a.IDAngajat
inner join Functii f
on f.IDFunctie=fa.IDFunctie
inner join SalariuFunctie sf
on sf.IDFunctie=f.IDFunctie
inner join Salarii s
on s.IDSalariu=sf.IDSalariu
inner join Impozite i
on i.IDSalariu=s.IDSalariu
inner join maxim m on m.Maxim=s.SalariuBrut*i.ProcentCasaPensii/100

--2

with ImpoziteTotale as
(
	select i.IDSalariu,ProcentAsigurareMedicala+ProcentTaxaSalariat+ProcentCasaPensii as ImpozitFinal
	from Impozite i
	inner join Salarii s
	on s.IDSalariu=i.IDSalariu
	inner join SalariuFunctie sf
	on sf.IDSalariu=s.IDSalariu
	inner join Functii f
	on sf.IDFunctie=f.IDFunctie
	where f.NumeFunctie='Asistent Manager' or f.NumeFunctie='Manager'
)
select a.Nume,a.Prenume,s.SalariuBrut-s.SalariuBrut*it.ImpozitFinal/100 as NoulSalariu
from Angajati a 
inner join FunctieAngajat fa
on a.IDAngajat=fa.IDAngajat
inner join Functii f
on f.IDFunctie=fa.IDFunctie
inner join SalariuFunctie sf
on sf.IDFunctie=f.IDFunctie
inner join Salarii s
on s.IDSalariu=sf.IDFunctie
inner join ImpoziteTotale it
on it.IDSalariu=s.IDSalariu

--3
with MaximIncasari as
(
	select IDIncasare
	from Incasari
	where SumaIncasata>500 and Day(DataIncasare)%3=0
)

select f.NumeFurnizor,f.CodSRL,f.UltimaLivrare
from Furnizori f
inner join FurnizorSuvenir fs
on f.IDFurnizor=fs.IDFurnizor
inner join Suveniruri s
on s.IDSuvenir=fs.IDSuvenir
inner join IncasareSuvenir incs
on incs.IDSuvenir=s.IDSuvenir
inner join MaximIncasari mi
on mi.IDIncasare=incs.IDIncasare

--4


with tabel as(
select u.IDUnealta,count(*) as NumarAngajatiAcces
from Unelte u
inner join AngajatUnealta au
on u.IDUnealta=au.IDUnealta
inner join Angajati a
on a.IDAngajat=au.IDAngajat
group by u.IDUnealta
)

select u.IDUnealta,u.Nume
from Unelte u
inner join AngajatUnealta au
on u.IDUnealta=au.IDUnealta
inner join Angajati a
on a.IDAngajat=au.IDAngajat
group by u.IDUnealta,u.Nume
having count(*)=( select max(NumarAngajatiAcces)
					from tabel)

--5
 with tabelSuveniruriMinime as
 (
 select f.IDFurnizor,count(*) as NumarSuveniruri
 from Furnizori f
 inner join FurnizorSuvenir fs
 on fs.IDFurnizor=f.IDFurnizor
 inner join Suveniruri s
 on  s.IDSuvenir=fs.IDSuvenir
 inner join IncasareSuvenir incs
 on s.IDSuvenir=incs.IDSuvenir
 inner join Incasari inc
 on inc.IDIncasare=incs.IDIncasare
 where inc.SumaIncasata<500
 group by f.IDFurnizor
 )
 select f.NumeFurnizor
 from Furnizori f
 inner join tabelSuveniruriMinime tsm
 on tsm.IDFurnizor=f.IDFurnizor
 where tsm.NumarSuveniruri= (select min(NumarSuveniruri)
							 from tabelSuveniruriMinime)


-- Triggere
--1 
if object_id('TriggerDuplicatFurnizori','TR') is not null
	drop trigger TriggerDuplicatFurnizori
go
create  trigger TriggerDuplicatFurnizori
on Furnizori
after insert,update
as
begin
  if @@ROWCOUNT =0 RETURN;
  set nocount on;
  if exists( select count(*)
			 from Inserted as I
			 inner join Furnizori f
			 on f.CodSRL=I.CodSRL
			 group by I.CodSRL
			 having count(*)>1
			 )
  begin
  throw 5000,'codSRL unic deja existent la nivelul Tabelei',3
  end
  else
  begin
	insert into Furnizori(NumeFurnizor,CodSRL,Adresa,UltimaLivrare,DurataContractFurnizare,AnActivitatePiata)
	select NumeFurnizor,CodSRL,Adresa,UltimaLivrare,DurataContractFurnizare,AnActivitatePiata
	from Inserted
  end
end

insert into Furnizori(NumeFurnizor,CodSRL,Adresa,UltimaLivrare,DurataContractFurnizare,AnActivitatePiata)
values ('SC IONEL SRL','RO5412','Strada Cimitirului, nr.15, Pitesti','2023/04/03',1,'2020/03/03')

--2
IF OBJECT_ID('TInsertClient', 'TR') IS NOT NULL
DROP TRIGGER TInsertClient
GO
CREATE TRIGGER TInsertClient
ON Clienti
AFTER INSERT
AS
BEGIN
	SET NOCOUNT ON;
	IF EXISTS(SELECT *
	FROM Clienti c
	inner join Inserted i
	on i.Nume=c.Nume
	WHERE c.Nume =i.Nume and c.Prenume= i.Prenume and c.Telefon=i.Telefon
	)
	BEGIN
		print 'Insert Nereusit.Userul exista deja!';
		throw 5234,'Eroare Insert',3
		 
	END
	else
	begin
			print 'Insert reusit!'
	end
	
END
select* from Clienti
insert into Clienti(Nume,Prenume,ClientFidel,TipClient,Telefon,Mail,DataUltimaVizita)
values ('Popescu','Ion','DA','VIP','0712345678','ion.popescu@gmail.com','2023/05/02')

--3

IF OBJECT_ID('TDeleteAngajati', 'TR') IS NOT NULL
DROP TRIGGER TDeleteAngajati
GO
CREATE TRIGGER TDeleteAngajati
ON FunctieAngajat
AFTER DELETE,UPDATE
AS
BEGIN
	SET NOCOUNT ON;
	IF EXISTS(
	select*
	from Deleted d
	inner join Functii f
	on d.IDFunctie=f.IDFunctie
	where f.NumeFunctie='Manager'
	)
	BEGIN
		print 'Nu s-a putut efectua stergerea. Angajatul ocupa functia de manager!';
		throw 5234,'Eroare Delete',3
		 
	END
	else
	begin
			print 'Stergere reusita!'
	end
	
END

--4
IF OBJECT_ID('TInsertFurnizor', 'TR') IS NOT NULL
DROP TRIGGER TInsertFurnizor
GO
CREATE TRIGGER TInsertFurnizor
ON Furnizori
AFTER INSERT,UPDATE
AS
BEGIN
	if @@ROWCOUNT=0 RETURN;
	SET NOCOUNT ON;
	IF EXISTS(
	select*
	from Inserted
	where CodSRL not like 'RO%'
	)
	BEGIN
		print 'Codul SRL al Furnizorului trebuie sa aiba prefixul RO';
		throw 5234,'Eroare Delete',3
		 
	END
	else
	begin
			print 'Introducere reusita!'
	end
	
END
insert into Furnizori(NumeFurnizor,CodSRL,Adresa,UltimaLivrare,DurataContractFurnizare,AnActivitatePiata)
values('SC Iana SRL','rz542','Valea mare, nr 20 Bucuresti','2023/05/01',10,'2015/05/03')

--5
IF OBJECT_ID('TPosesieUnealta', 'TR') IS NOT NULL
DROP TRIGGER TPosesieUnealta
GO
CREATE TRIGGER TPosesieUnealta
ON AngajatUnealta
AFTER INSERT
AS
BEGIN
	if @@ROWCOUNT=0 RETURN;
	SET NOCOUNT ON;
	begin
	declare @numarUnelte int;
	declare @numeUnealta nvarchar(30);
	declare @prenumeAngajat nvarchar(30);
	declare @numeAngajat nvarchar(30);
	set @numarUnelte=(select count(*)
					from inserted i
					inner join AngajatUnealta au
					on au.IDAngajat=i.IDAngajat
					inner join Unelte u
					on u.IDUnealta=au.IDUnealta
					group by i.IDAngajat
					)
	set @numeAngajat= (select a.Nume
						from Inserted i
						inner join Angajati a
						on i.IDAngajat=a.IDAngajat
						);
	set @prenumeAngajat=(select a.Prenume
						from Inserted i
						inner join Angajati a
						on i.IDAngajat=a.IDAngajat);
	set @numeUnealta=(select u.Nume
					  from Inserted i
					  inner join Unelte u
					  on i.IDUnealta=u.IDUnealta);
		print 'Angajatul '+ @numeAngajat + ' '+@prenumeAngajat+' are de acum acces la unealta ' +@numeUnealta
		print ' Acesta are acum acces la ' + cast((@numarUnelte+1) as nvarchar(50))+' unelte!'
	end
						
		 
	
	
END

insert into AngajatUnealta(IDAngajat,IDUnealta)
values(1,27)

--6
IF OBJECT_ID('TInsertAngajatFunctie', 'TR') IS NOT NULL
DROP TRIGGER TInsertAngajatFuctie
GO
CREATE TRIGGER TInsertAngajatFunctie
ON FunctieAngajat
AFTER INSERT
AS
BEGIN
	if @@ROWCOUNT=0 RETURN;
	SET NOCOUNT ON;
	BEGIN
		declare @SalariuFunctie int;
		set @SalariuFunctie=(select s.SalariuNet
		from Inserted i
		inner join Functii f
		on f.IDFunctie=i.IDFunctie
		inner join SalariuFunctie sf
		on sf.IDFunctie=f.IDFunctie
		inner join Salarii s
		on s.IDSalariu=sf.IDSalariu)
	if @SalariuFunctie<2500
	begin
		print 'Salariul nu este mai mare de 2500 de lei';
	end
	else
	begin
		print 'Salariul este mai mare de 2500 de lei';
	end
	
	
	
END
insert into FunctieAngajat(IDFunctie,IDAngajat)
values(3,2)

--7
IF OBJECT_ID('TInsertDataAngajati', 'TR') IS NOT NULL
DROP TRIGGER TInsertDataAngajati
GO
CREATE TRIGGER TInsertDataAngajati
ON Angajati
AFTER INSERT,UPDATE
AS
BEGIN
	if @@ROWCOUNT=0 RETURN;
	SET NOCOUNT ON;
	if (select DataAngajare
		from inserted)> (select DataExpirareContract
						 from inserted)
	begin
		print 'Eroare fatala, DataExpirareContract trebuie sa fie mai mare decat DataAngajare';
		throw 5234,'Eroare fatala!',3
	end
	else
	begin
		print 'Insert realizat cu succes!'
	end
	
END
insert into Angajati(Nume,Prenume,Localitate,Departament,NumarTelefon,DataAngajare,DataExpirareContract,AniExperientaDomeniu)
values('Ion','Andrei','da','da','0753513241','2024/03/02','2023/02/02',3)

--8
IF OBJECT_ID('TInsertSuvenirMagnetRomania', 'TR') IS NOT NULL
DROP TRIGGER TInsertSuvenirMagnetRomania
GO
CREATE TRIGGER TInsertSuvenirMagnetRomania
ON Suveniruri
AFTER INSERT,UPDATE
AS
BEGIN

	if @@ROWCOUNT=0 RETURN;
	SET NOCOUNT ON;
	declare @numarMagneti int;
	set @numarMagneti= (select count(*)
		from Suveniruri
		where Tip='Magnet' and TaraProvenienta='Romania'
		group by Tip,TaraProvenienta)
	if @numarMagneti>=4
	begin
		print 'Eroare fatala! Nu pot fi introdusi mai mult de 4 magneti din Romania';
		throw 5234,'Eroare',3
	end
	else
	begin
		print 'Insert realizat cu succes!'
	end
		
END
insert into Suveniruri(Nume,Material,Tip,TaraProvenienta,Pret,BucatiStoc)
values('Magnet s','Fier','Magnet','Romania',15,20)

--9
IF OBJECT_ID('TMarireSalariu', 'TR') IS NOT NULL
DROP TRIGGER TMarireSalariu
GO
CREATE TRIGGER TMarireSalariu
ON Salarii
AFTER UPDATE
AS
BEGIN
	if @@ROWCOUNT=0 RETURN;
	SET NOCOUNT ON;
	if exists(select*
			 from Salarii s
			 inner join inserted i
			 on i.IDSalariu=s.IDSalariu
			 where i.SalariuBrut-s.SalariuBrut<1500 and i.SalariuBrut-s.SalariuBrut>0
			 )
	begin
		print 'Nu poate exista o astfel de crestere salariala!';
		throw 5234,'Eroare',2
	end
	else
	begin
		print 'Marire de salariu realizata cu succes!'
	end
		
	
	
END

update Salarii
set SalariuBrut=SalariuBrut+1001
from Functii f
inner join SalariuFunctie sf
on f.IDFunctie=sf.IDFunctie
inner join Salarii s
on s.IDSalariu=sf.IDSalariu
where f.NumeFunctie='Manager'


--10
IF OBJECT_ID('TModificareGrila', 'TR') IS NOT NULL
DROP TRIGGER TModificareGrila
GO
CREATE TRIGGER TModificareGrila
ON SalariuFunctie
AFTER Insert
AS
BEGIN
	if @@ROWCOUNT=0 RETURN;
	SET NOCOUNT ON;
	if exists(
	select *
	from Angajati a
	inner join FunctieAngajat fa
	on a.IDAngajat=fa.IDAngajat
	inner join Functii f
	on f.IDFunctie=fa.IDFunctie
	inner join inserted i
	on i.IDFunctie=f.IDFunctie
	inner join Salarii s
	on s.IDSalariu=i.IDSalariu
	where a.IDAngajat%2=0
	)
	begin
		print 'Unui angajat cu id-ul numar par i s-a modificat grila salariala!'
	end
	else
	begin
		print 'Nu s-a modificat grila salariala a unui angajat cu id-ul par!'
	end	
END
insert into SalariuFunctie(IDSalariu,IDFunctie)
values(3,8)

--------DELETE

---setup modificare chei straine
ALTER TABLE IncasareSuvenir
	drop  constraint FK__IncasareS__IDSuv__5AEE82B9


ALTER TABLE IncasareSuvenir
ADD 
FOREIGN KEY (IDSuvenir) REFERENCES Suveniruri(IDSuvenir)
ON DELETE CASCADE;

SELECT name
FROM sys.foreign_keys
WHERE parent_object_id = OBJECT_ID('IncasareSuvenir');
--setup modificare chei straine

--1
delete c
from Clienti c
inner join Rezervari r
on c.IDClient=r.IDClient
inner join Expozitii e
on e.IDExpozitie=r.IDExpozitie
inner join Angajati a
on a.IDAngajat=e.IDAngajat
inner join FunctieAngajat fa
on fa.IDAngajat=a.IDAngajat
inner join Functii f
on f.IDFunctie=fa.IDFunctie
where f.NumeFunctie='Curator' and r.DataRezervare>'2023/05/05'

--2 
delete
from Clienti
where Nume like 'D%' and TipClient='EXTENDED' and Mail like '%@yahoo.com'

--3 
delete a
from Angajati a
inner join AngajatUnealta au
on a.IDAngajat=au.IDAngajat
inner join Unelte u
on au.IDUnealta=u.IDUnealta
inner join FurnizorUnealta fu
on fu.IDUnealta=u.IDUnealta
inner join Furnizori f
on f.IDFurnizor=fu.IDFurnizor
inner join FurnizorSuvenir fs
on fs.IDFurnizor=f.IDFurnizor
inner join Suveniruri s
on s.IDSuvenir=fs.IDSuvenir
where s.Nume='Pahar Viena'

--4
delete c
from Clienti c
inner join Rezervari r
on r.IDClient=c.IDClient
inner join IncasareRezervare ir
on ir.IDRezervare=r.IDRezervare
inner join Incasari inc
on ir.IDIncasare=inc.IDIncasare
where inc.SumaIncasata=
(
	select min(SumaIncasata)
	from Incasari
)
select* from Clienti

--5
with tabelFurnizoriAn as
(	
 select f.IDFurnizor,f.AnActivitatePiata
  from Furnizori f left join FurnizorUnealta fu
  on f.IDFurnizor=fu.IDFurnizor
  group by f.IDFurnizor,f.AnActivitatePiata
  having count(fu.IDFurnizor)=0
)
delete f
from Furnizori f
where f.IDFurnizor=
(   select top(1)  t.IDFurnizor
	from tabelFurnizoriAn as t
	order by t.AnActivitatePiata
)
--6
delete c
from Creatori c
inner join CreatorExponat ce
on ce.IDCreator=c.IDCreator
inner join Exponate e
on e.IDExponat=ce.IDExponat
inner join Expozitii expo
on e.IDExpozitie=expo.IDExpozitie
inner join Rezervari r
on r.IDExpozitie=expo.IDExpozitie
inner join Clienti cl
on cl.IDClient=r.IDClient
where cl.IDClient='5'
select* from Creatori

--7
delete i
from Impozite i
inner join Salarii s
on s.IDSalariu=i.IDSalariu
inner join SalariuFunctie sf
on sf.IDSalariu=s.IDSalariu
inner join Functii as f
on f.IDFunctie=sf.IDFunctie
where f.NumeFunctie='Curator'
select* from Impozite

--8
delete c
from Creatori c
where c.IDCreator=(select c.IDCreator
from Creatori c inner join CreatorExponat ce
on c.IDCreator=ce.IDCreator
inner join Exponate e
on e.IDExponat=ce.IDExponat
group by c.IDCreator
having count(ce.IDCreator)=5
)

--9
delete f
from Furnizori f
inner join FurnizorUnealta fu
on fu.IDFurnizor=f.IDFurnizor
inner join Unelte u
on u.IDUnealta=fu.IDUnealta
inner join AngajatUnealta au
on au.IDUnealta=u.IDUnealta
where au.IDAngajat%2=1 and f.IDFurnizor%2=0
select* from Furnizori

--10
delete au
from AngajatUnealta au
inner join Unelte u
on au.IDUnealta=u.IDUnealta
inner join FurnizorUnealta fu
on fu.IDUnealta=u.IDUnealta
inner join Furnizori f
on f.IDFurnizor=fu.IDFurnizor
where au.IDUnealta%5=0 and f.IDFurnizor>10
select * from AngajatUnealta


--11
with maximum as
(
	select c.IDCreator,count(ce.IDCreator) as NumarOpere
	from Creatori c
	inner join CreatorExponat ce
	on ce.IDCreator=c.IDCreator
	group by c.IDCreator
)
delete r
from Rezervari r
inner join Expozitii e
on r.IDExpozitie=e.IDExpozitie
inner join Exponate expo
on expo.IDExpozitie=e.IDExpozitie
inner join CreatorExponat ce
on expo.IDExponat=ce.IDExponat
inner join Creatori c
on c.IDCreator=ce.IDCreator
where c.IDCreator=( select top(1) IDCreator
					from maximum
					order by NumarOpere desc
					)

--12
delete s
from Salarii s
inner join SalariuFunctie sf
on s.IDSalariu=sf.IDSalariu
inner join Functii f
on f.IDFunctie=sf.IDFunctie
inner join FunctieAngajat fa
on f.IDFunctie=fa.IDFunctie
inner join Angajati a
on a.IDAngajat=fa.IDAngajat
inner join Expozitii e
on e.IDAngajat=a.IDAngajat
inner join Rezervari r
on r.IDExpozitie=e.IDExpozitie
inner join Clienti c
on c.IDClient=r.IDclient
where c.Telefon like '%4'

--13

delete expo
from Exponate expo
inner join Expozitii e
on expo.IDExpozitie=e.IDExpozitie
inner join Rezervari r
on r.IDExpozitie=e.IDExpozitie
inner join IncasareRezervare ir
on ir.IDRezervare=r.IDRezervare
inner join Incasari i
on i.IDIncasare=ir.IDIncasare
where i.SumaIncasata in ( 
						select top(2) SumaIncasata
						from Incasari
						order by SumaIncasata
						
						)
						select* from Exponate
--14
delete a
from Angajati a
inner join AngajatUnealta au
on a.IDAngajat=au.IDAngajat
inner join Unelte u
on u.IDUnealta=au.IDUnealta
where a.IDAngajat in(
						select a.IDAngajat
						from Angajati a
						inner join AngajatUnealta au
						on a.IDAngajat=au.IDAngajat
						group by a.IDAngajat
						having count(au.IDAngajat)=1
						)
and DATEDIFF(year,GETDATE(),a.DataExpirareContract) <1
select*
from Angajati

--15
delete u
from Unelte u
where u.IDUnealta in (
						select u.IDUnealta
						from Unelte u
						inner join AngajatUnealta au
						on u.IDUnealta=au.IDUnealta
						group by u.IDUnealta
						having count(au.IDUnealta)=1
					)
and DateDIFF(month,GETDATE(),u.DataExpirareGarantie)<6

----------Tranzacti

-- 1
begin try
begin tran

insert into Clienti(Nume,Prenume,ClientFidel,TipClient,Telefon,Mail,DataUltimaVizita)
values('Ion','Marinel','NU','REGULAR',NULL,'ion.marinel@yahoo.com','2021/03/04')

update Clienti
set Telefon='0723436541'
where Nume='Ion' and Prenume='Marinel'

select *
from Clienti
where Nume='Ion' and Prenume='Marinel'

commit tran
end try


--2 

set identity_insert Angajati on
declare @IDAng int;
set @IDAng=10
begin try
begin tran

insert into Angajati(IDAngajat,Nume,Prenume,Localitate,Departament,NumarTelefon,DataAngajare,DataExpirareContract,AniExperientaDomeniu)
values(@IDAng,'Martin','Andrei','Bradu','IT','0732332624',GETDATE(),'2024/05/10',3)
set identity_insert Angajati off;
update FunctieAngajat
set IDAngajat=@IDAng
where IDAngajat=@IDAng-2

update AngajatUnealta
set IDAngajat=@IDAng
where IDAngajat=@IDAng-2

delete Angajati
where IDAngajat=@IDAng-2

commit tran
end try
BEGIN CATCH
IF ERROR_NUMBER() = 2627 -- Duplicate key violation
BEGIN
PRINT 'Primary Key violation';
END
ELSE IF ERROR_NUMBER() = 547 -- Constraint violations
BEGIN
PRINT 'Constraint violation';
END
ELSE
BEGIN
PRINT 'Unhandled error';
END;
IF @@TRANCOUNT > 0 ROLLBACK TRANSACTION;
END CATCH;

--3

BEGIN TRY
BEGIN TRAN;

insert into Suveniruri(Nume,Material,Tip,TaraProvenienta,Pret,BucatiStoc)
values('Pantaloni negri','Bumbac','Pantaloni','China',70,20)
--
update Suveniruri
set BucatiStoc=BucatiStoc+5
where Nume <> 'Pantaloni negri'

delete
from Suveniruri
where IDSuvenir = ( select top(1) IDSuvenir
					from Suveniruri
					order by Pret*BucatiStoc)
COMMIT TRAN;
END TRY
BEGIN CATCH
IF ERROR_NUMBER() = 2627 -- Duplicate key violation
BEGIN
PRINT 'Primary Key violation';
END
ELSE IF ERROR_NUMBER() = 547 -- Constraint violations
BEGIN
PRINT 'Constraint violation';
END
ELSE
BEGIN
PRINT 'Unhandled error';
END;
IF @@TRANCOUNT > 0 ROLLBACK TRANSACTION;
END CATCH;
select* from Suveniruri
where Tip='Magnet'
insert into Suveniruri(Nume,Material,Tip,TaraProvenienta,Pret,BucatiStoc)
values('dada','dada','dada','China',5,10)

--4
BEGIN TRAN

UPDATE Salarii
set ValoareAvans=ValoareAvans+200
from Salarii s inner join SalariuFunctie sf
on s.IDSalariu=sf.IDSalariu inner join Functii f
on f.IDFunctie=sf.IDFunctie inner join FunctieAngajat fa
on fa.IDFunctie=f.IDFunctie inner join Angajati a 
on a.IDAngajat=fa.IDAngajat
where a.Departament='Management'

UPDATE Angajati
set Departament='Management*'
from Angajati a
where Departament='Management'

select* from Salarii
select* from Angajati
COMMIT TRAN


--5
BEGIN TRY
BEGIN TRAN
declare @IDClient int;
declare @IDExpozitie int;
set @IDExpozitie=( select IDExpozitie
					from Expozitii
					where Locatie='Galeria de arte Plastice')
set @IDClient=(
select top(1)c.IDClient
from Clienti c inner join Rezervari r
on c.IDClient=r.IDClient
inner join Expozitii ex
on r.IDExpozitie=ex.IDExpozitie
where  ex.Locatie='Galeria de arte Plastice'
order by c.IDClient
)

delete r
from Rezervari r
inner join Clienti c
on c.IDClient=r.IDClient
where c.IDClient=@IDClient

INSERT into Rezervari(IDExpozitie,IDClient,NumarBilete,DataRezervare,OraRezervare)
values(@IDExpozitie+1,@IDClient,5,'2023/05/25',13)

COMMIT TRAN
END TRY
BEGIN CATCH
IF ERROR_NUMBER() = 2627 -- Duplicate key violation
BEGIN
PRINT 'Primary Key violation';
END
ELSE IF ERROR_NUMBER() = 547 -- Constraint violations
BEGIN
PRINT 'Constraint violation';
END
ELSE
BEGIN
PRINT 'Unhandled error';
END;
IF @@TRANCOUNT > 0 ROLLBACK TRANSACTION;
END CATCH;
--6
BEGIN TRAN
	declare @errnum int;
	delete AngajatUnealta
	from AngajatUnealta au inner join Angajati a
	on a.IDAngajat=au.IDAngajat inner join FurnizorUnealta fu
	on fu.IDUnealta=au.IDUnealta inner join Furnizori f
	on f.IDFurnizor=fu.IDFurnizor
	where au.IDAngajat=6 and f.Adresa like '%Bucuresti'

	insert into AngajatUnealta(IDAngajat,IDUnealta)
	values(6, (select top(1) IDUnealta
				from FurnizorUnealta
				where IDFurnizor=7)
				)
SET @errnum = @@ERROR;
IF @errnum <> 0 -- gestioneaaa eroarea
BEGIN
PRINT 'Eroare cu codul '+CAST(@errnum AS VARCHAR);
ROLLBACK
END
ELSE
BEGIN
select * from AngajatUnealta
ROLLBACK
END



--7
select* from Incasari
BEGIN TRAN
declare @errnum int;
	DELETE i
	from Incasari i
	where i.DataIncasare = (
	select top(1) DataIncasare
	from Incasari
	order by DataIncasare)
declare @maximum int;
set @maximum=( select max(BucatiStoc*Pret)
from Suveniruri)
insert into Incasari(DataIncasare,SumaIncasata)
values(GETDATE(),@maximum)
SET @errnum = @@ERROR;
IF @errnum <> 0 -- gestioneaaa eroarea
BEGIN
PRINT 'Eroare cu codul '+CAST(@errnum AS VARCHAR);
ROLLBACK
END
ELSE
BEGIN
select* from Incasari
ROLLBACK
END
--insert pentru a mai scrie in locul datelor sterse
insert into FurnizorUnealta(IDUnealta,IDFurnizor)
values
	  (4,7),
	  (7,9),
	  (9,15),
	  (2,12),
	  (5,20)

--8
BEGIN TRAN
declare @errnum int;
declare @numeUnealta nvarchar(30);
declare @Marca nvarchar(30);
declare @TipUnealta nvarchar(20);
declare @DataAchizitie DATE;
declare @DataExpirareGarantie DATE;
set @numeUnealta= 'Disk Station';
set @Marca='XPenology'
set @TipUnealta='Electric'
set @DataAchizitie='2023/04/05'
set @DataExpirareGarantie='2027/10/05'
--
insert into Unelte(Nume,Marca,TipUnealta,DataAchizitie,DataExpirareGarantie)
values(@numeUnealta,@Marca,@TipUnealta,@DataAchizitie,@DataExpirareGarantie)
--
declare @idUnealta int;
set @idUnealta= (select IDUnealta
				from Unelte
				where Nume=@numeUnealta and Marca=@Marca and DataAchizitie=@DataAchizitie)
declare @idFurnizor int;
set @idFurnizor= (select top(1) IDFurnizor
				from Furnizori
				order by AnActivitatePiata)
				
		
insert into FurnizorUnealta(IDUnealta,IDFurnizor)
values(@idUnealta,@idFurnizor)

delete u
from Unelte u
inner join FurnizorUnealta fu
on u.IDUnealta=fu.IDUnealta
inner join Furnizori f
on f.IDFurnizor=fu.IDFurnizor
where f.DurataContractFurnizare=12


SET @errnum = @@ERROR;
IF @errnum <> 0 -- gestioneaaa eroarea
BEGIN
PRINT 'Eroare cu codul '+CAST(@errnum AS VARCHAR);
ROLLBACK
END
ELSE
BEGIN
select* from FurnizorUnealta
select* from Unelte
ROLLBACK
END

--9

begin tran
	declare @errnum int;
	declare @idCreator int;
with tabelNumarExponate as
(
	select c.IDCreator,count(*) as NumarExponate
	from Creatori c
	inner join CreatorExponat ce
	on c.IDCreator=ce.IDCreator
	group by c.IDCreator
)


select @idCreator=(select top(1) IDCreator
from tabelNumarExponate
order by NumarExponate desc
)

declare @Nume nvarchar(30)
declare @Prenume nvarchar(30)
declare @DataNastere Date
declare @DataDeces Date
declare @Adresa nvarchar(30)
declare @Studii nvarchar(30)
declare @TipuriPreferate nvarchar(30)

set @Nume= (select Nume from Creatori where IDCreator=@idCreator)	
set @Prenume=(select Prenume from Creatori where IDCreator=@idCreator)
set @DataNastere=(select DataNastere from Creatori where IDCreator=@idCreator)
set @DataDeces=(select DataDeces from Creatori where IDCreator=@idCreator)
set @Adresa=(select Adresa from Creatori where IDCreator=@idCreator)
set @Studii=(select Studii from Creatori where IDCreator=@idCreator)
set @TipuriPreferate=(select TipuriPreferate from Creatori where IDCreator=@idCreator)
declare @idNou int
insert into Creatori(Nume,Prenume,DataNastere,DataDeces,Adresa,Studii,TipuriPreferate)
values(@Nume,@Prenume+'*',@DataNastere,@DataDeces,@Adresa,@Studii,@TipuriPreferate)

set @idNou=(select IDCreator
			from Creatori
			where Prenume=@Prenume+'*')

update CreatorExponat
set IDCreator=@idNou
where IDCreator=@idCreator

delete from Creatori
where IDCreator=@idCreator

SET @errnum = @@ERROR;
IF @errnum <> 0 -- gestioneaaa eroarea
BEGIN
PRINT 'Eroare cu codul '+CAST(@errnum AS VARCHAR);
ROLLBACK
END
ELSE
BEGIN
select* from Creatori
select* from CreatorExponat
ROLLBACK
END
--10
BEGIN TRY
BEGIN TRAN
update Impozite
set ProcentAsigurareMedicala=ProcentAsigurareMedicala+2,
	ProcentCasaPensii=ProcentCasaPensii+2,
	ProcentTaxaSalariat=ProcentTaxaSalariat+2
from Impozite i
inner join Salarii s
on s.IDSalariu=i.IDSalariu
inner join SalariuFunctie sf
on sf.IDSalariu=s.IDSalariu
inner join Functii f
on f.IDFunctie=sf.IDFunctie
inner join FunctieAngajat fa
on fa.IDFunctie=f.IDFunctie
inner join Angajati a
on a.IDAngajat=fa.IDAngajat
where a.IDAngajat>=10

delete top(1)
from Impozite

select* from Impozite

ROLLBACK TRAN
END TRY
BEGIN CATCH
IF ERROR_NUMBER() = 2627 -- Duplicate key violation
BEGIN
PRINT 'Primary Key violation';
END
ELSE IF ERROR_NUMBER() = 547 -- Constraint violations
BEGIN
PRINT 'Constraint violation';
END
ELSE
BEGIN
PRINT 'Unhandled error';
END;
IF @@TRANCOUNT > 0 ROLLBACK TRANSACTION;
END CATCH;

--1

select c.Nume,c.Prenume,count(ce.IDExponat) as NumarExponate,count(e.IDExpozitie) as NumarExpozitii,max(r.DataRezervare)--top(1) r.DataRezervare
from Creatori c inner join CreatorExponat ce
on c.IDCreator= ce.IDCreator inner join Exponate ex
on ex.IDExponat=ce.IDExponat inner join Expozitii e
on e.IDExpozitie=ex.IDExpozitie inner join Rezervari r
on r.IDExpozitie=e.IDExpozitie
group by c.Nume,c.Prenume



--2

go
create proc PROCEDURA2
	@numeExponat varchar(100),
	@valoare int
as
begin
	select i.Incasari,c.Nume
	from Incasari i inner join IncasareRezervare ir
	on i.IDIncasare=ir.IDIncasare inner join Rezervari r
	on r.IDRezervare=ir.IDRezervare inner join Expozitii e
	on e.IDExpozitie=r.IDExpozitie inner join Exponate ex
	on ex.IDExpozitie=e.IDExpozitie inner join CreatorExponat ce
	on ce.IDExponat=ex.IDExponat

end


--3

go
create proc Procedura
as
begin

	select e.IDExpozitie,count(r.IDRezervare) as NumarRezervari
	from Expozitii e inner join Rezervari r
	on r.IDExpozitie=e.IDExpozitie
	group by e.IDExpozitie
	having count(r.IDRezervare)>1000

	delete 
	from Expozitii e
	inner join Rezervari r
	on r.IDExpozitie=e.IDExpozitie
	group by e.IDExpoztie
	having count(r.IDRezervare)>1000
	
end


--4

go
create trigger SCADERE
on Incasari
after insert
as
begin

	update Suveniruri
	set BucatiStoc=BucatiStoc-1
	from Suveniruri s inner join IncasareSuvenir incs
	on s.IDSuvenir=incs.IDSuvenir
	where IDIncasare= (select IDIncasare
						from inserted)
					
	

end
--5
go
create trigger Actualizare
on Rezervari
after insert
as
begin

declare @IDClient int;
declare @IDRezervare int;
set @IDClient = (select IDClient
					from inserted i )
set @IDRezervare=(select IDRezervare
					from inserted i)

insert into IncasareRezervare(IDIncasare,IDRezervare,DataIncasare)
	values(5,@IDRezervare,'2023/05/04')

update Incasari
set SumaIncasata=SumaIncasata+200
where IDIncasare=5





end
select* from IncasareRezervare
select* from Rezervari
