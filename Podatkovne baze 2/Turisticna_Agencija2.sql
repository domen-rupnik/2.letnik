/*==============================================================*/
/* DBMS name:      ORACLE Version 10gR2                         */
/* Created on:     29. 12. 2019 15:26:55                        */
/*==============================================================*/


alter table Hotel
   drop constraint FK_HOTEL_HOTEL_V_K_POSTA;

alter table Letovanje
   drop constraint FK_LETOVANJ_GRE_NA_LE_STRANKA;

alter table Letovanje
   drop constraint FK_LETOVANJ_PRENOCISC_HOTEL;

alter table Letovanje
   drop constraint FK_LETOVANJ_PREVOZ_NA_PREVOZ;

alter table Oseba
   drop constraint FK_OSEBA_STALNO_PR_POSTA;

alter table Oseba
   drop constraint FK_OSEBA_ZACASNO_P_POSTA;

alter table Poslovalnica
   drop constraint FK_POSLOVAL_POSLOVALN_POSTA;

alter table Posta
   drop constraint FK_POSTA_KRAJ_V_DR_DRZAVA;

alter table Potovanje
   drop constraint FK_POTOVANJ_PREVOZ_NA_PREVOZ;

alter table Prenocisce_za_Potovanje
   drop constraint FK_PRENOCIS_PRENOCISC_POTOVANJ;

alter table Prenocisce_za_Potovanje
   drop constraint FK_PRENOCIS_PRENOCISC_HOTEL;

alter table Prevoz
   drop constraint FK_PREVOZ_IMA_PREVOZNI;

alter table Prevoz
   drop constraint FK_PREVOZ_PREVOZ_IZ_POSTA;

alter table Prevoz
   drop constraint FK_PREVOZ_PREVOZ_V_POSTA;

alter table Program
   drop constraint FK_PROGRAM_PROGRAMI__POSTA;

alter table Program_na_Potovanju
   drop constraint FK_PROGRAM__PROGRAM_N_PROGRAM;

alter table Program_na_Potovanju
   drop constraint FK_PROGRAM__PROGRAM_N_POTOVANJ;

alter table Stranka
   drop constraint FK_STRANKA_JE_OSEBA;

alter table Vsa_Potovanja
   drop constraint FK_VSA_POTO_GRE_NA_PO_STRANKA;

alter table Vsa_Potovanja
   drop constraint FK_VSA_POTO_GRE_NA_PO_POTOVANJ;

alter table Zaposleni
   drop constraint FK_ZAPOSLEN_DELA_V_POSLOVAL;

alter table Zaposleni
   drop constraint FK_ZAPOSLEN_JE2_OSEBA;

alter table Zaposleni
   drop constraint FK_ZAPOSLEN_JE_NADREJ_ZAPOSLEN;

drop table Drzava cascade constraints;

drop index Hotel_v_Kraju_FK;

drop table Hotel cascade constraints;

drop index Prevoz_na_Letovanje_FK;

drop index Prenocisce_za_Letovanje_FK;

drop index Gre_na_Letovanje_FK;

drop table Letovanje cascade constraints;

drop index Zacasno_prebivalisce_FK;

drop index Stalno_prebivalisce_FK;

drop table Oseba cascade constraints;

drop index Poslovalnica_v_kraju_FK;

drop table Poslovalnica cascade constraints;

drop index Kraj_v_Drzavi_FK;

drop table Posta cascade constraints;

drop index Prevoz_na_Potovanje_FK;

drop table Potovanje cascade constraints;

drop index Prenocisce_za_Potovanje2_FK;

drop table Prenocisce_za_Potovanje cascade constraints;

drop index Prevoz_iz_FK;

drop index Prevoz_v_FK;

drop index Ima_FK;

drop table Prevoz cascade constraints;

drop table Prevoznik cascade constraints;

drop index Programi_v_Kraju_FK;

drop table Program cascade constraints;

drop index Program_na_Potovanju2_FK;

drop table Program_na_Potovanju cascade constraints;

drop table Stranka cascade constraints;

drop index Gre_na_Potovanje2_FK;

drop table Vsa_Potovanja cascade constraints;

drop index Je_nadrejeni_FK;

drop index Dela_v_FK;

drop table Zaposleni cascade constraints;

/*==============================================================*/
/* Table: Drzava                                                */
/*==============================================================*/
create table Drzava  (
   ID_Drzava            NUMBER                          not null,
   Ime_Drzava           VARCHAR2(30)                    not null,
   constraint PK_DRZAVA primary key (ID_Drzava)
);

/*==============================================================*/
/* Table: Hotel                                                 */
/*==============================================================*/
create table Hotel  (
   ID_Hotel             NUMBER                          not null,
   Postna_Stevilka      NUMBER                          not null,
   Ime_Hotel            VARCHAR2(30)                    not null,
   Ocena                NUMBER,
   Naslov_Hotel         VARCHAR2(30)                    not null,
   constraint PK_HOTEL primary key (ID_Hotel)
);

/*==============================================================*/
/* Index: Hotel_v_Kraju_FK                                      */
/*==============================================================*/
create index Hotel_v_Kraju_FK on Hotel (
   Postna_Stevilka ASC
);

/*==============================================================*/
/* Table: Letovanje                                             */
/*==============================================================*/
create table Letovanje  (
   ID_Letovanje         NUMBER(6)                       not null,
   ID_Prevoz            NUMBER,
   EMSO                 NUMBER                          not null,
   ID_Stranka           NUMBER                          not null,
   ID_Hotel             NUMBER                          not null,
   L_Odhod              DATE                            not null,
   L_Prihod             DATE                            not null,
   Cas_Trajanja         NUMBER,
   constraint PK_LETOVANJE primary key (ID_Letovanje)
);

/*==============================================================*/
/* Index: Gre_na_Letovanje_FK                                   */
/*==============================================================*/
create index Gre_na_Letovanje_FK on Letovanje (
   EMSO ASC,
   ID_Stranka ASC
);

/*==============================================================*/
/* Index: Prenocisce_za_Letovanje_FK                            */
/*==============================================================*/
create index Prenocisce_za_Letovanje_FK on Letovanje (
   ID_Hotel ASC
);

/*==============================================================*/
/* Index: Prevoz_na_Letovanje_FK                                */
/*==============================================================*/
create index Prevoz_na_Letovanje_FK on Letovanje (
   ID_Prevoz ASC
);

/*==============================================================*/
/* Table: Oseba                                                 */
/*==============================================================*/
create table Oseba  (
   EMSO                 NUMBER                          not null,
   Postna_Stevilka      NUMBER,
   Pos_Postna_Stevilka  NUMBER                          not null,
   Ime_Oseba            VARCHAR2(20)                    not null,
   Priimek              VARCHAR2(20)                    not null,
   Spol                 VARCHAR2(1)                     not null,
   Datum_Rojstva        DATE                            not null,
   Email                VARCHAR2(50)                    not null,
   Naslov_Oseba         VARCHAR2(50)                    not null,
   constraint PK_OSEBA primary key (EMSO)
);

/*==============================================================*/
/* Index: Stalno_prebivalisce_FK                                */
/*==============================================================*/
create index Stalno_prebivalisce_FK on Oseba (
   Pos_Postna_Stevilka ASC
);

/*==============================================================*/
/* Index: Zacasno_prebivalisce_FK                               */
/*==============================================================*/
create index Zacasno_prebivalisce_FK on Oseba (
   Postna_Stevilka ASC
);

/*==============================================================*/
/* Table: Poslovalnica                                          */
/*==============================================================*/
create table Poslovalnica  (
   ID_Poslovalnica      NUMBER                          not null,
   Postna_Stevilka      NUMBER                          not null,
   Ime_Poslovalnica     VARCHAR2(30)                    not null,
   constraint PK_POSLOVALNICA primary key (ID_Poslovalnica)
);

/*==============================================================*/
/* Index: Poslovalnica_v_kraju_FK                               */
/*==============================================================*/
create index Poslovalnica_v_kraju_FK on Poslovalnica (
   Postna_Stevilka ASC
);

/*==============================================================*/
/* Table: Posta                                                 */
/*==============================================================*/
create table Posta  (
   Postna_Stevilka      NUMBER                          not null,
   ID_Drzava            NUMBER                          not null,
   Kraj                 VARCHAR2(30)                    not null,
   constraint PK_POSTA primary key (Postna_Stevilka)
);

/*==============================================================*/
/* Index: Kraj_v_Drzavi_FK                                      */
/*==============================================================*/
create index Kraj_v_Drzavi_FK on Posta (
   ID_Drzava ASC
);

/*==============================================================*/
/* Table: Potovanje                                             */
/*==============================================================*/
create table Potovanje  (
   ID_Potovanje         NUMBER                          not null,
   ID_Prevoz            NUMBER                          not null,
   Trajanje             NUMBER,
   constraint PK_POTOVANJE primary key (ID_Potovanje)
);

/*==============================================================*/
/* Index: Prevoz_na_Potovanje_FK                                */
/*==============================================================*/
create index Prevoz_na_Potovanje_FK on Potovanje (
   ID_Prevoz ASC
);

/*==============================================================*/
/* Table: Prenocisce_za_Potovanje                               */
/*==============================================================*/
create table Prenocisce_za_Potovanje  (
   ID_Potovanje         NUMBER                          not null,
   ID_Hotel             NUMBER                          not null,
   constraint PK_PRENOCISCE_ZA_POTOVANJE primary key (ID_Potovanje, ID_Hotel)
);

/*==============================================================*/
/* Index: Prenocisce_za_Potovanje2_FK                           */
/*==============================================================*/
create index Prenocisce_za_Potovanje2_FK on Prenocisce_za_Potovanje (
   ID_Hotel ASC
);

/*==============================================================*/
/* Table: Prevoz                                                */
/*==============================================================*/
create table Prevoz  (
   ID_Prevoz            NUMBER                          not null,
   Postna_Stevilka      NUMBER                          not null,
   ID_Prevoznik         NUMBER                          not null,
   Pos_Postna_Stevilka  NUMBER                          not null,
   P_Odhod              DATE                            not null,
   P_Prihod             DATE                            not null,
   constraint PK_PREVOZ primary key (ID_Prevoz)
);

/*==============================================================*/
/* Index: Ima_FK                                                */
/*==============================================================*/
create index Ima_FK on Prevoz (
   ID_Prevoznik ASC
);

/*==============================================================*/
/* Index: Prevoz_v_FK                                           */
/*==============================================================*/
create index Prevoz_v_FK on Prevoz (
   Pos_Postna_Stevilka ASC
);

/*==============================================================*/
/* Index: Prevoz_iz_FK                                          */
/*==============================================================*/
create index Prevoz_iz_FK on Prevoz (
   Postna_Stevilka ASC
);

/*==============================================================*/
/* Table: Prevoznik                                             */
/*==============================================================*/
create table Prevoznik  (
   ID_Prevoznik         NUMBER                          not null,
   Vrsta_Prevoza        VARCHAR2(30)                    not null,
   Ime_Prevoznik        VARCHAR2(30)                    not null,
   constraint PK_PREVOZNIK primary key (ID_Prevoznik)
);

/*==============================================================*/
/* Table: Program                                               */
/*==============================================================*/
create table Program  (
   ID_Program           NUMBER                          not null,
   Postna_Stevilka      NUMBER                          not null,
   Opis                 VARCHAR2(1024)                  not null,
   Ime_Program          VARCHAR2(1024)                  not null,
   constraint PK_PROGRAM primary key (ID_Program)
);

/*==============================================================*/
/* Index: Programi_v_Kraju_FK                                   */
/*==============================================================*/
create index Programi_v_Kraju_FK on Program (
   Postna_Stevilka ASC
);

/*==============================================================*/
/* Table: Program_na_Potovanju                                  */
/*==============================================================*/
create table Program_na_Potovanju  (
   ID_Program           NUMBER                          not null,
   ID_Potovanje         NUMBER                          not null,
   constraint PK_PROGRAM_NA_POTOVANJU primary key (ID_Program, ID_Potovanje)
);

/*==============================================================*/
/* Index: Program_na_Potovanju2_FK                              */
/*==============================================================*/
create index Program_na_Potovanju2_FK on Program_na_Potovanju (
   ID_Potovanje ASC
);

/*==============================================================*/
/* Table: Stranka                                               */
/*==============================================================*/
create table Stranka  (
   EMSO                 NUMBER                          not null,
   ID_Stranka           NUMBER                          not null,
   constraint PK_STRANKA primary key (EMSO, ID_Stranka)
);

/*==============================================================*/
/* Table: Vsa_Potovanja                                         */
/*==============================================================*/
create table Vsa_Potovanja  (
   EMSO                 NUMBER                          not null,
   ID_Stranka           NUMBER                          not null,
   ID_Potovanje         NUMBER                          not null,
   constraint PK_VSA_POTOVANJA primary key (EMSO, ID_Stranka, ID_Potovanje)
);

/*==============================================================*/
/* Index: Gre_na_Potovanje2_FK                                  */
/*==============================================================*/
create index Gre_na_Potovanje2_FK on Vsa_Potovanja (
   ID_Potovanje ASC
);

/*==============================================================*/
/* Table: Zaposleni                                             */
/*==============================================================*/
create table Zaposleni  (
   EMSO                 NUMBER                          not null,
   ID_Zaposleni         NUMBER                          not null,
   ID_Poslovalnica      NUMBER                          not null,
   Zap_EMSO             NUMBER,
   Zap_ID_Zaposleni     NUMBER,
   constraint PK_ZAPOSLENI primary key (EMSO, ID_Zaposleni)
);

/*==============================================================*/
/* Index: Dela_v_FK                                             */
/*==============================================================*/
create index Dela_v_FK on Zaposleni (
   ID_Poslovalnica ASC
);

/*==============================================================*/
/* Index: Je_nadrejeni_FK                                       */
/*==============================================================*/
create index Je_nadrejeni_FK on Zaposleni (
   Zap_EMSO ASC,
   Zap_ID_Zaposleni ASC
);

alter table Hotel
   add constraint FK_HOTEL_HOTEL_V_K_POSTA foreign key (Postna_Stevilka)
      references Posta (Postna_Stevilka);

alter table Letovanje
   add constraint FK_LETOVANJ_GRE_NA_LE_STRANKA foreign key (EMSO, ID_Stranka)
      references Stranka (EMSO, ID_Stranka);

alter table Letovanje
   add constraint FK_LETOVANJ_PRENOCISC_HOTEL foreign key (ID_Hotel)
      references Hotel (ID_Hotel);

alter table Letovanje
   add constraint FK_LETOVANJ_PREVOZ_NA_PREVOZ foreign key (ID_Prevoz)
      references Prevoz (ID_Prevoz);

alter table Oseba
   add constraint FK_OSEBA_STALNO_PR_POSTA foreign key (Pos_Postna_Stevilka)
      references Posta (Postna_Stevilka);

alter table Oseba
   add constraint FK_OSEBA_ZACASNO_P_POSTA foreign key (Postna_Stevilka)
      references Posta (Postna_Stevilka);

alter table Poslovalnica
   add constraint FK_POSLOVAL_POSLOVALN_POSTA foreign key (Postna_Stevilka)
      references Posta (Postna_Stevilka);

alter table Posta
   add constraint FK_POSTA_KRAJ_V_DR_DRZAVA foreign key (ID_Drzava)
      references Drzava (ID_Drzava);

alter table Potovanje
   add constraint FK_POTOVANJ_PREVOZ_NA_PREVOZ foreign key (ID_Prevoz)
      references Prevoz (ID_Prevoz);

alter table Prenocisce_za_Potovanje
   add constraint FK_PRENOCIS_PRENOCISC_POTOVANJ foreign key (ID_Potovanje)
      references Potovanje (ID_Potovanje);

alter table Prenocisce_za_Potovanje
   add constraint FK_PRENOCIS_PRENOCISC_HOTEL foreign key (ID_Hotel)
      references Hotel (ID_Hotel);

alter table Prevoz
   add constraint FK_PREVOZ_IMA_PREVOZNI foreign key (ID_Prevoznik)
      references Prevoznik (ID_Prevoznik);

alter table Prevoz
   add constraint FK_PREVOZ_PREVOZ_IZ_POSTA foreign key (Postna_Stevilka)
      references Posta (Postna_Stevilka);

alter table Prevoz
   add constraint FK_PREVOZ_PREVOZ_V_POSTA foreign key (Pos_Postna_Stevilka)
      references Posta (Postna_Stevilka);

alter table Program
   add constraint FK_PROGRAM_PROGRAMI__POSTA foreign key (Postna_Stevilka)
      references Posta (Postna_Stevilka);

alter table Program_na_Potovanju
   add constraint FK_PROGRAM__PROGRAM_N_PROGRAM foreign key (ID_Program)
      references Program (ID_Program);

alter table Program_na_Potovanju
   add constraint FK_PROGRAM__PROGRAM_N_POTOVANJ foreign key (ID_Potovanje)
      references Potovanje (ID_Potovanje);

alter table Stranka
   add constraint FK_STRANKA_JE_OSEBA foreign key (EMSO)
      references Oseba (EMSO);

alter table Vsa_Potovanja
   add constraint FK_VSA_POTO_GRE_NA_PO_STRANKA foreign key (EMSO, ID_Stranka)
      references Stranka (EMSO, ID_Stranka);

alter table Vsa_Potovanja
   add constraint FK_VSA_POTO_GRE_NA_PO_POTOVANJ foreign key (ID_Potovanje)
      references Potovanje (ID_Potovanje);

alter table Zaposleni
   add constraint FK_ZAPOSLEN_DELA_V_POSLOVAL foreign key (ID_Poslovalnica)
      references Poslovalnica (ID_Poslovalnica);

alter table Zaposleni
   add constraint FK_ZAPOSLEN_JE2_OSEBA foreign key (EMSO)
      references Oseba (EMSO);

alter table Zaposleni
   add constraint FK_ZAPOSLEN_JE_NADREJ_ZAPOSLEN foreign key (Zap_EMSO, Zap_ID_Zaposleni)
      references Zaposleni (EMSO, ID_Zaposleni);



insert into drzava (ID_DRZAVA, IME_DRZAVA) values (1, 'Grčija');
insert into drzava (ID_DRZAVA, IME_DRZAVA) values (2, 'Tunizija');
insert into drzava (ID_DRZAVA, IME_DRZAVA) values (3, 'Turčija');
insert into drzava (ID_DRZAVA, IME_DRZAVA) values (4, 'Švedska');
insert into drzava (ID_DRZAVA, IME_DRZAVA) values (5, 'Egipt');
insert into drzava (ID_DRZAVA, IME_DRZAVA) values (6, 'Italija');
insert into drzava (ID_DRZAVA, IME_DRZAVA) values (7, 'Slovenija');
insert into drzava (ID_DRZAVA, IME_DRZAVA) values (8, 'Španija');
insert into drzava (ID_DRZAVA, IME_DRZAVA) values (9, 'Hrvaška');
insert into drzava (ID_DRZAVA, IME_DRZAVA) values (10, 'Srbija');

insert into posta values (181621, 1, 'Atene');
insert into posta values (845182, 1, 'Korint');
insert into posta values (889942, 1, 'Rodos');
insert into posta values (946291, 1, 'Heraklion');
insert into posta values (15842, 2, 'Monastir');
insert into posta values (81848, 2, 'Hammamet');
insert into posta values (98427, 2, 'Kairouan');
insert into posta values (81561, 2, 'Mahdia');
insert into posta values (8461125, 3, 'Carigrad');
insert into posta values (4816842, 3, 'Ankara');
insert into posta values (8129926, 3, 'Antalya');
insert into posta values (8181517, 3, 'Alanya');
insert into posta values (5415, 4, 'Stockholm');
insert into posta values (5951, 4, 'Goteborg');
insert into posta values (9959, 4, 'Malmo');
insert into posta values (9125, 4, 'Lund');
insert into posta values (959595951, 5, 'Hurgada');
insert into posta values (151841918, 5, 'Luksor');
insert into posta values (951819192, 5, 'Aleksandrija');
insert into posta values (928625918, 5, 'Asuan');
insert into posta values (5496585, 6, 'Milano');
insert into posta values (2543984, 6, 'Udine');
insert into posta values (5584559, 6, 'Rim');
insert into posta values (2145269, 6, 'Napoli');
insert into posta values (4458556, 6, 'Salerno');
insert into posta values (6000, 7, 'Koper');
insert into posta values (1000, 7, 'Ljubljana');
insert into posta values (2000, 7, 'Maribor');
insert into posta values (4915948, 8, 'Barcelona');
insert into posta values (4915555, 8, 'Madrid');
insert into posta values (4591995, 8, 'Sevilla');
insert into posta values (485474, 9, 'Split');
insert into posta values (925268, 9, 'Zadar');
insert into posta values (785221, 9, 'Dubrovnik');
insert into posta values (5236214, 10, 'Kragujevac');
insert into posta values (2514587, 10, 'Novi Sad');
insert into posta values (5848536, 10, 'Beograd');



insert into poslovalnica values (1, 1000, 'Poslovalnica Ljubljana');
insert into poslovalnica values (2, 1000, 'Poslovalnica Ljubljana 2');
insert into poslovalnica values (3, 2000, 'Poslovalnica Maribor');
insert into poslovalnica values (4, 6000, 'Poslovalnica Koper');

insert into prevoznik values (1, 'Avtobusni', 'Nomago');
insert into prevoznik values (2, 'Letalski', 'Adria Airways');
insert into prevoznik values (3, 'Avtobusni', 'Izletnik');
insert into prevoznik values (4, 'Avtobusni', 'Celjski Prevozi');
insert into prevoznik values (5, 'Letalski', 'EasyJet');
insert into prevoznik values (6, 'Letalski', 'American Airline');


insert into program values (1, 1000, 'Ogledali si bomo znamenitosti Ljubljane', 'Ljubljanski program');
insert into program values (2, 925268, 'Ogledali si bomo znamenitosti Zadra', 'Zadrski program');
insert into program values (3, 5848536, 'Ogledali si bomo znamenitosti Beograda', 'Gradski program');
insert into program values (4, 959595951, 'Ogledali si bomo piramide', 'Egipčanski program');
insert into program values (5, 5496585, 'Ogledali si bomo Milano', 'Milanski program');
insert into program values (6, 5584559, 'Ogledali si bomo Rim', 'Rimski program');
insert into program values (7, 889942, 'Ogledali si bomo znamenitosti Rodosa', 'Grški program');
insert into program values (8, 4458556, 'Ogledali si bomo znamenitosti Salerna', 'Salerno program');
insert into program values (9, 4915948, 'Ogledali si bomo Camp Nou', 'Camp Nou program');
insert into program values (10, 4915948, 'Ogledali si bomo znamenitosti Barcelone', 'Barelonski program');

insert into hotel values (1, 4915948, 'Hotel di Viva', 4.2, 'Partizanska ulica 3');
insert into hotel values (2, 4915555, 'Hotel di Madrid', 3.9, 'Groharjeva 18');
insert into hotel values (3, 4915555, 'Hotel Star', 4.5, 'Vidmarjeva 212');
insert into hotel values (4, 925268, 'Mirella', 2.9, 'Vodnikova 45');
insert into hotel values (5, 959595951, 'Sausona', 3.7, 'Vodna ulica 1');
insert into hotel values (6, 181621, 'Modri hotel', 4.2, 'Palmova ulica 2');
insert into hotel values (7, 5496585, 'Gucci', 4.8, 'Via Stella 18');
insert into hotel values (8, 845182, 'Plavi hotel', 3.5, 'Majstrova ulica 84');
insert into hotel values (9, 6000, 'Bellavita', 2.8, 'Notranjska ulica 2');
insert into hotel values (10, 5584559, 'Juventina', 4.7, 'Stara ulica 89');
insert into hotel values (11, 485474, 'Splitski hotel', 4.2, 'Hišnikova ulica 44');
insert into hotel values (12, 5415, 'Dortmundson', 3.5, 'Poljska ulica 22');
insert into hotel values (13, 946291, 'Hotel Las Palmas', 4.8, 'Pod palmami 88');
insert into hotel values (14, 951819192, 'Fligium', 3.9, 'Flemska ulica 942');
insert into hotel values (15, 928625918, 'Bernabeuski', 1.9, 'Barbarska ulica 299');
insert into hotel values (16, 4591995, 'La Villa', 3.4, 'Borštnikova ulica 928');
insert into hotel values (17, 5848536, 'La Maria Hotel', 4.8, 'Zadnikova ulica 99');
insert into hotel values (18, 1000, 'Hotel Slon', 4.9, 'Plečnikova ulica 2');
insert into hotel values (19, 951819192, 'Hotel Union', 4.1, 'Memorijska ulica 42');
insert into hotel values (20, 5496585, 'La Hotel', 4.9, 'Ferrarijeva ulica 2');


insert into prevoz (1, 2000, 1, 4915948, TO_DATE('2019-6-6','YYYY-MM-DD'), TO_DATE('2019-6-12','YYYY-MM-DD'));
insert into prevoz (2, 5236214, 2, 959595951, TO_DATE('2019-6-15','YYYY-MM-DD'), TO_DATE('2019-6-18','YYYY-MM-DD'));
insert into prevoz (3, 8129926, 2, 6000, TO_DATE('2019-6-14','YYYY-MM-DD'), TO_DATE('2019-6-21','YYYY-MM-DD'));
insert into prevoz (4, 6000, 1, 181621, TO_DATE('2019-6-28','YYYY-MM-DD'), TO_DATE('2019-7-5','YYYY-MM-DD'));
insert into prevoz (5, 5236214, 3, 4915555, TO_DATE('2019-6-29','YYYY-MM-DD'), TO_DATE('2019-7-7','YYYY-MM-DD'));
insert into prevoz (6, 928625918, 4, 4915555, TO_DATE('2019-6-29','YYYY-MM-DD'), TO_DATE('2019-7-7','YYYY-MM-DD'));
insert into prevoz (7, 2000, 4, 2543984, TO_DATE('2019-6-29','YYYY-MM-DD'), TO_DATE('2019-7-7','YYYY-MM-DD'));
insert into prevoz (8, 5236214, 4, 2543984, TO_DATE('2019-6-29','YYYY-MM-DD'), TO_DATE('2019-7-7','YYYY-MM-DD'));
insert into prevoz (9, 6000, 4, 4915555, TO_DATE('2019-6-29','YYYY-MM-DD'), TO_DATE('2019-7-7','YYYY-MM-DD'));
insert into prevoz (10, 8129926, 4, 5951, TO_DATE('2019-6-29','YYYY-MM-DD'), TO_DATE('2019-7-7','YYYY-MM-DD'));


insert into letovanje values (1, 1, 1212978513451, 1, 1, TO_DATE('2019-6-6','YYYY-MM-DD'), TO_DATE('2019-6-12','YYYY-MM-DD'), null);
insert into letovanje values (2, null, 1212378512281, 10, 5, TO_DATE('2019-6-6','YYYY-MM-DD'), TO_DATE('2019-6-12','YYYY-MM-DD'), null);
insert into letovanje values (3, null, 0505976501261, 6, 9, TO_DATE('2019-6-6','YYYY-MM-DD'), TO_DATE('2019-6-10','YYYY-MM-DD'), null);
insert into letovanje values (4, null, 1212978512123, 2, 20, TO_DATE('2019-6-15','YYYY-MM-DD'), TO_DATE('2019-6-20','YYYY-MM-DD'), null);
insert into letovanje values (5, 2, 1232978512281, 5, 14, TO_DATE('2019-6-15','YYYY-MM-DD'), TO_DATE('2019-6-18','YYYY-MM-DD'), null);
insert into letovanje values (6, null, 1212978512290, 4, 2, TO_DATE('2019-6-6','YYYY-MM-DD'), TO_DATE('2019-6-12','YYYY-MM-DD'), null);
insert into letovanje values (7, null, 1212978512321, 3, 1, TO_DATE('2019-6-6','YYYY-MM-DD'), TO_DATE('2019-6-12','YYYY-MM-DD'), null);
insert into letovanje values (8, null, 1212378512281, 10, 2, TO_DATE('2019-6-13','YYYY-MM-DD'), TO_DATE('2019-6-20','YYYY-MM-DD'), null);
insert into letovanje values (9, 3, 1212978512280, 9, 20, TO_DATE('2019-6-14','YYYY-MM-DD'), TO_DATE('2019-6-21','YYYY-MM-DD'), null);
insert into letovanje values (10, null, 0703997512281, 8, 7, TO_DATE('2019-6-14','YYYY-MM-DD'), TO_DATE('2019-6-20','YYYY-MM-DD'), null);
insert into letovanje values (11, null, 2805998500089, 7, 16, TO_DATE('2019-6-15','YYYY-MM-DD'), TO_DATE('2019-6-19','YYYY-MM-DD'), null);
insert into letovanje values (12, null, 1212978513281, 13, 15, TO_DATE('2019-6-15','YYYY-MM-DD'), TO_DATE('2019-6-20','YYYY-MM-DD'), null);
insert into letovanje values (13, null, 1212978511281, 12, 11, TO_DATE('2019-6-16','YYYY-MM-DD'), TO_DATE('2019-6-22','YYYY-MM-DD'), null);
insert into letovanje values (14, null, 0101990512281, 11, 5, TO_DATE('2019-6-16','YYYY-MM-DD'), TO_DATE('2019-6-22','YYYY-MM-DD'), null);
insert into letovanje values (15, null, 1212378512281, 10, 9, TO_DATE('2019-6-27','YYYY-MM-DD'), TO_DATE('2019-7-3','YYYY-MM-DD'), null);
insert into letovanje values (16, null, 1212978512280, 9, 3, TO_DATE('2019-6-27','YYYY-MM-DD'), TO_DATE('2019-7-2','YYYY-MM-DD'), null);
insert into letovanje values (17, null, 2805998500089, 7, 8, TO_DATE('2019-6-28','YYYY-MM-DD'), TO_DATE('2019-7-5','YYYY-MM-DD'), null);
insert into letovanje values (18, 4, 0505976501261, 6, 15, TO_DATE('2019-6-28','YYYY-MM-DD'), TO_DATE('2019-7-5','YYYY-MM-DD'), null);
insert into letovanje values (19, 5, 1212978512123, 2, 7, TO_DATE('2019-6-29','YYYY-MM-DD'), TO_DATE('2019-7-7','YYYY-MM-DD'), null);
insert into letovanje values (20, null, 1232978512281, 5, 4, TO_DATE('2019-6-30','YYYY-MM-DD'), TO_DATE('2019-7-9','YYYY-MM-DD'), null);


INSERT INTO OSEBA(EMSO,POSTNA_STEVILKA,POS_POSTNA_STEVILKA,IME_OSEBA,PRIIMEK,SPOL,DATUM_ROJSTVA,EMAIL,NASLOV_OSEBA)
VALUES(1212978512281,NULL,1000,'Egon','Kosmac','M',TO_DATE('1978-12-12','YYYY-MM-DD'),'egon@gmail.com','Barjanska cesta 12');
INSERT INTO OSEBA(EMSO,POSTNA_STEVILKA,POS_POSTNA_STEVILKA,IME_OSEBA,PRIIMEK,SPOL,DATUM_ROJSTVA,EMAIL,NASLOV_OSEBA)
VALUES(1312978512281,NULL,6000,'Karla','Vidmar','Z',TO_DATE('1981-06-01','YYYY-MM-DD'),'karla123@gmail.com','Staniceva 31');
INSERT INTO OSEBA(EMSO,POSTNA_STEVILKA,POS_POSTNA_STEVILKA,IME_OSEBA,PRIIMEK,SPOL,DATUM_ROJSTVA,EMAIL,NASLOV_OSEBA)
VALUES(0212978512281,2000,1000,'Zala','Pirc','Z',TO_DATE('1945-05-08','YYYY-MM-DD'),'chinthaka@sbcglobal.net','Vecna ulica 113');
INSERT INTO OSEBA(EMSO,POSTNA_STEVILKA,POS_POSTNA_STEVILKA,IME_OSEBA,PRIIMEK,SPOL,DATUM_ROJSTVA,EMAIL,NASLOV_OSEBA)
VALUES(1212978513281,NULL,2000,'Izidor','Jereb','M',TO_DATE('1957-09-18','YYYY-MM-DD'),'jacks@me.com','Presernova ulica 76');
INSERT INTO OSEBA(EMSO,POSTNA_STEVILKA,POS_POSTNA_STEVILKA,IME_OSEBA,PRIIMEK,SPOL,DATUM_ROJSTVA,EMAIL,NASLOV_OSEBA)
VALUES(1212978511281,NULL,889942,'Tihomir','Kolar','M',TO_DATE('1986-12-13','YYYY-MM-DD'),'cgreuter@hotmail.com','Rodos 45');
INSERT INTO OSEBA(EMSO,POSTNA_STEVILKA,POS_POSTNA_STEVILKA,IME_OSEBA,PRIIMEK,SPOL,DATUM_ROJSTVA,EMAIL,NASLOV_OSEBA)
VALUES(1212978512280,NULL,8129926,'Tomislava','Petek','Z',TO_DATE('1961-11-11','YYYY-MM-DD'),'steve@outlook.com','Antalya');
INSERT INTO OSEBA(EMSO,POSTNA_STEVILKA,POS_POSTNA_STEVILKA,IME_OSEBA,PRIIMEK,SPOL,DATUM_ROJSTVA,EMAIL,NASLOV_OSEBA)
VALUES(0101990512281,NULL,5951,'Cvetka','Rozman','Z',TO_DATE('1997-08-30','YYYY-MM-DD'),'uncled@comcast.net','Gote 54');
INSERT INTO OSEBA(EMSO,POSTNA_STEVILKA,POS_POSTNA_STEVILKA,IME_OSEBA,PRIIMEK,SPOL,DATUM_ROJSTVA,EMAIL,NASLOV_OSEBA)
VALUES(0703997512281,5236214,5496585,'Zvonka','Hribar','Z',TO_DATE('1983-12-11','YYYY-MM-DD'),'dwendlan@gmail.com','Ulica nerode 2');
INSERT INTO OSEBA(EMSO,POSTNA_STEVILKA,POS_POSTNA_STEVILKA,IME_OSEBA,PRIIMEK,SPOL,DATUM_ROJSTVA,EMAIL,NASLOV_OSEBA)
VALUES(2805998500089,NULL,5584559,'Negomir','Turk','M',TO_DATE('2000-11-19','YYYY-MM-DD'),'solomon@gmail.com','Rim bim bim 98');
INSERT INTO OSEBA(EMSO,POSTNA_STEVILKA,POS_POSTNA_STEVILKA,IME_OSEBA,PRIIMEK,SPOL,DATUM_ROJSTVA,EMAIL,NASLOV_OSEBA)
VALUES(0505976501261,NULL,6000,'Vesna','Kos','Z',TO_DATE('1992-09-25','YYYY-MM-DD'),'doormat@mac.com','Bosamarin 28');
INSERT INTO OSEBA(EMSO,POSTNA_STEVILKA,POS_POSTNA_STEVILKA,IME_OSEBA,PRIIMEK,SPOL,DATUM_ROJSTVA,EMAIL,NASLOV_OSEBA)
VALUES(1212378512281,NULL,2543984,'Ana','Kovač','Z',TO_DATE('1980-09-19','YYYY-MM-DD'),'starstuff@sbcglobal.net','Udine 21');
INSERT INTO OSEBA(EMSO,POSTNA_STEVILKA,POS_POSTNA_STEVILKA,IME_OSEBA,PRIIMEK,SPOL,DATUM_ROJSTVA,EMAIL,NASLOV_OSEBA)
VALUES(1232978512281,5236214,959595951,'Ljuba','Zupančič','Z',TO_DATE('1996-06-27','YYYY-MM-DD'),'cgreuter@msn.com','Hurgada 209');
INSERT INTO OSEBA(EMSO,POSTNA_STEVILKA,POS_POSTNA_STEVILKA,IME_OSEBA,PRIIMEK,SPOL,DATUM_ROJSTVA,EMAIL,NASLOV_OSEBA)
VALUES(1212978512290,NULL,9125,'Lado','Krajnc','M',TO_DATE('1986-04-16','YYYY-MM-DD'),'pfitza@mac.com','Lund 1');
INSERT INTO OSEBA(EMSO,POSTNA_STEVILKA,POS_POSTNA_STEVILKA,IME_OSEBA,PRIIMEK,SPOL,DATUM_ROJSTVA,EMAIL,NASLOV_OSEBA)
VALUES(1212978512321,NULL,5415,'Janez','Kovačič','M',TO_DATE('1972-09-16','YYYY-MM-DD'),'cparis@me.com','Stockholm 11');
INSERT INTO OSEBA(EMSO,POSTNA_STEVILKA,POS_POSTNA_STEVILKA,IME_OSEBA,PRIIMEK,SPOL,DATUM_ROJSTVA,EMAIL,NASLOV_OSEBA)
VALUES(1212978512123,5236214,845182,'Hotimir','Horvat','M',TO_DATE('1968-05-05','YYYY-MM-DD'),'niknejad@outlook.com','Korint 18');
INSERT INTO OSEBA(EMSO,POSTNA_STEVILKA,POS_POSTNA_STEVILKA,IME_OSEBA,PRIIMEK,SPOL,DATUM_ROJSTVA,EMAIL,NASLOV_OSEBA)
VALUES(1212978513451,2000,181621,'Anže','Novak','M',TO_DATE('1973-12-01','YYYY-MM-DD'),'msherr@live.com','Atene 32');


insert into stranka values (1212978513451, 1);
insert into stranka values (1212978512123, 2);
insert into stranka values (1212978512321, 3);
insert into stranka values (1212978512290, 4);
insert into stranka values (1232978512281, 5);
insert into stranka values (0505976501261, 6);
insert into stranka values (2805998500089, 7);
insert into stranka values (0703997512281, 8);
insert into stranka values (1212978512280, 9);
insert into stranka values (1212378512281, 10);
insert into stranka values (0101990512281, 11);
insert into stranka values (1212978511281, 12);
insert into stranka values (1212978513281, 13);

insert into zaposleni values (1212978512281,1,1, null, null);
insert into zaposleni values (1312978512281,2,1, null, null);
insert into zaposleni values (0212978512281,3,1, 1212978512281, 1);

insert into potovanje values (1, 6, null);
insert into potovanje values (2, 7, null);
insert into potovanje values (3, 8, null);
insert into potovanje values (4, 9, null);
insert into potovanje values (5, 10, null);

insert into program_na_potovanju values(1, 1);
insert into program_na_potovanju values(2, 1);
insert into program_na_potovanju values(3, 1);

insert into prenocisce_za_potovanje values(1, 5);
insert into prenocisce_za_potovanje values(2, 6);
insert into prenocisce_za_potovanje values(3, 7);
insert into prenocisce_za_potovanje values(4, 8);

insert into vsa_potovanja values(1212978513451, 1, 1);
insert into vsa_potovanja values(1212978513451, 1, 2);
insert into vsa_potovanja values(1212978512290, 4, 3);
insert into vsa_potovanja values(1212978513281, 13, 4);
insert into vsa_potovanja values(2805998500089, 7, 5);



