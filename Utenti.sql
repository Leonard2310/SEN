-- Si è ora connessi come "sen".

-- 1) Tabella utenti
CREATE TABLE UTENTI(
    NumeroDiTelefono NUMBER(10),
    Nome VARCHAR2(30) NOT NULL,
    Cognome VARCHAR2(30) NOT NULL,
    Provincia CHAR(2),
    Città VARCHAR2(35), -- La città con nome più lungo in Italia presenta ben 34 lettere
    CAP NUMBER(5),
    Via VARCHAR2(35),
    NumeroCivico NUMBER(5), -- Il numero civico più alto in Italia è circa 14500

    CONSTRAINT PK_UTENTI PRIMARY KEY(NumeroDiTelefono)
)
STORAGE(INITIAL 1490k NEXT 745k MINEXTENTS 1 MAXEXTENTS 5 PCTINCREASE 5);

-- Eseguendo ciascuna CREATE TABLE, nell'output screen appare "Creato table <nome_table>."

-- 2) Tabella segnalazioni
/* LISTA DELLE SEGNALAZIONI ACCETTATE DAL DATABASE
*
* ----- INTERVENTO SINGOLO -----
*
* ***** VIGILI DEL FUOCO *****
* INCENDI, FUGHE DI GAS, CROLLI, CALAMITÀ, ATTACCHI TERRORISTICI, SOCCORSO IN RICERCA, ALLUVIONI, INCIDENTI
*
* ***** PRONTO SOCCORSO *****
* INCIDENTI, CALAMITÀ, ATTACCHI TERRORISTICI, INCENDI, CROLLI, VIOLENZE
*
* ***** POLIZIA DI STATO *****
* FURTI, SMARRIMENTI, VIOLENZE, INFLAZIONI, TRAFFICO URBANO, MANIFESTAZIONI, INCIDENTI, ASSASINI, VIOLAZIONI VARIE, TERRORISMO
*
* ***** ARMA DEI CARABINIERI *****
* FURTI, SMARRIMENTI, ATTACCHI TERRORISTICI, VIOLENZE, ESPLOSIONI, MANIFESTAZIONI, INCIDENTI, ASSASINI, VIOLAZIONI VARIE
*
* ***** GUARDIA DI FINANZA *****
* TRUFFA, EVASIONE FISCALE, CONTRABBANDO, RICICLAGGIO, CONTRAFFAZIONE
*
* ***** ESERCITO *****
* ATTACCHI TERRORISTICI, VIOLENZE, POSSESSO DI DROGA, INCIDENTI, MANIFESTAZIONI
*
* ----- INTERVENTO MULTIPLO -----
*
* INCENDI (VIGILI DEL FUOCO, PRONTO SOCCORSO, ARMA DEI CARABINIERI)
*
* ATTACCHI TERRORISTICI (VIGILI DEL FUOCO, PRONTO SOCCORSO, ARMA DEI CARABINIERI)
*
* CALAMITÀ (VIGILI DEL FUOCO, PRONTO SOCCORSO, ARMA DEI CARABINIERI, ESERCITO)
*
* VIOLENZE (PRONTO SOCCORSO, POLIZIA DI STATO, ARMA DEI CARABINIERI, ESERCITO)
*
* INCIDENTI (VIGILI DEL FUOCO, PRONTO SOCCORSO, POLIZIA DI STATO, ARMA DEI CARABINIERI, ESERCITO)
*
* CROLLI (VIGILI DEL FUOCO, PRONTO SOCCORSO, POLIZIA DI STATO, ARMA DEI CARABINIERI, ESERCITO)
*
* MANIFESTAZIONI (POLIZIA DI STATO, ARMA DEI CARABINIERI, ESERCITO)
*
* ASSASSINI (POLIZIA DI STATO, ARMA DEI CARABINIERI, ESERCITO)
*
 */
CREATE TABLE SEGNALAZIONI(
    Codice NUMBER(10),
    TipologiaEmergenza VARCHAR2(30) NOT NULL,
    NumTelefonicoUtente NUMBER(10),
    Provincia CHAR(2) NOT NULL,
    Città VARCHAR2(35) NOT NULL,
    CAP NUMBER(5),
    Via VARCHAR2(35) NOT NULL,
    NumeroCivico NUMBER(5),
    Data_Ora TIMESTAMP(0) NOT NULL,

    CONSTRAINT PK_SEGNALAZIONI PRIMARY KEY(Codice)
)
STORAGE(INITIAL 1330k NEXT 665k MINEXTENTS 1 MAXEXTENTS 5 PCTINCREASE 5);

-- 3) Tabella dipartimenti
CREATE TABLE DIPARTIMENTI(
    ID NUMBER(4),
    NumeroEmergenza NUMBER(3) NOT NULL,
    Tipologia VARCHAR2(25) NOT NULL,
    NumeroOperatori NUMBER(6),
    NumeroVeicoli NUMBER(4),
    Provincia CHAR(2) NOT NULL,
    Città VARCHAR2(35) NOT NULL,
    CAP NUMBER(5) NOT NULL,
    Via VARCHAR2(35) NOT NULL,
    NumeroCivico NUMBER(5) NOT NULL,

    CONSTRAINT PK_DIPARTIMENTI PRIMARY KEY(ID),
    CONSTRAINT CK_DIPARTIMENTI CHECK(Tipologia IN
                                        ('Vigili del Fuoco', 'Pronto Soccorso',
                                        'Polizia di Stato', 'Arma dei Carabinieri',
                                        'Guardia di Finanza', 'Esercito'))
)
STORAGE(INITIAL 15k NEXT 4k MINEXTENTS 1 MAXEXTENTS 5 PCTINCREASE 5);

-- 4) Tabella operatori
CREATE TABLE OPERATORI(
    ID NUMBER(6),
    Nome VARCHAR2(30) NOT NULL,
    Cognome VARCHAR2(30) NOT NULL,
    IDDip NUMBER(4) NOT NULL,
    Ruolo VARCHAR2(30) NOT NULL,

    CONSTRAINT PK_OPERATORI PRIMARY KEY(ID)
)
STORAGE(INITIAL 459k NEXT 92k MINEXTENTS 1 MAXEXTENTS 5 PCTINCREASE 5);

-- 5) Tabella titoli_di_studi
CREATE TABLE TITOLIDISTUDI(
    Specializzazione VARCHAR2(50),

    CONSTRAINT PK_TITOLIDISTUDI PRIMARY KEY(Specializzazione)
)
STORAGE(INITIAL 50k MINEXTENTS 1 MAXEXTENTS 5 PCTINCREASE 5);

-- 6) Tabella competenze
CREATE TABLE COMPETENZE(
    IDOpe NUMBER(6),
    SpecTitolo VARCHAR2(50),

    CONSTRAINT PK_COMPETENZE PRIMARY KEY(IDOpe, SpecTitolo)
)
STORAGE(INITIAL 207k NEXT 50k MINEXTENTS 1 MAXEXTENTS 5 PCTINCREASE 5);

-- 7) Tabella coinvolgimenti
CREATE TABLE COINVOLGIMENTI(
    IDDip NUMBER(4),
    CodSegnalazione NUMBER(10),

    CONSTRAINT PK_COINVOLGIMENTI PRIMARY KEY(IDDip, CodSegnalazione)
)
STORAGE(INITIAL 110k NEXT 55k MINEXTENTS 1 MAXEXTENTS 5 PCTINCREASE 5);

-- 8) Tabella storico_segnalazioni
CREATE TABLE STORICO_SEGNALAZIONI (
    Codice NUMBER(10),
    NumeroDiTelefono NUMBER(10),
    Nome VARCHAR2(30),
    Cognome VARCHAR2(30),
    TipologiaEmergenza VARCHAR2(30),
    Provincia CHAR(2),
    Città VARCHAR2(35),
    CAP NUMBER(5),
    Via VARCHAR2(35),
    NumeroCivico NUMBER(5),
    Data_Ora TIMESTAMP(0),

    CONSTRAINT PK_STORICO_SEGNALAZIONI PRIMARY KEY(Codice)
)
STORAGE(INITIAL 1560k NEXT 3120k MINEXTENTS 1 MAXEXTENTS 5 PCTINCREASE 5);


-- Definizione dei ruoli
-- Ruolo utente e relativi privilegi
CREATE ROLE utente;                                      -- creazione del ruolo
GRANT CONNECT TO utente;                                 -- attribuzione dei privilegi
GRANT INSERT, UPDATE, DELETE ON sen.UTENTI TO utente;    -- attribuzione dei privilegi
-- Dopo ogni singolo GRANT, apparirà nell'output screen "Grant riuscito/a."

-- Ruolo amm_dipartimento e relativi privilegi
CREATE ROLE amm_dipartimento;
GRANT CONNECT TO amm_dipartimento;
GRANT INSERT, UPDATE, DELETE ON sen.DIPARTIMENTI   TO amm_dipartimento;
GRANT INSERT, UPDATE, DELETE ON sen.OPERATORI      TO amm_dipartimento;
GRANT INSERT, UPDATE, DELETE ON sen.TITOLIDISTUDI  TO amm_dipartimento;
GRANT INSERT, UPDATE, DELETE ON sen.COMPETENZE  TO amm_dipartimento;

-- Ruolo centralinista e relativi privilegi
CREATE ROLE centralinista;
GRANT CONNECT TO centralinista;
GRANT SELECT                 ON sen.SEGNALAZIONI   TO centralinista;
GRANT INSERT, UPDATE, DELETE ON sen.COINVOLGIMENTI TO centralinista;


-- Creazione delle sequenze
/* Si creano le seguenti sequenze:
 * 1- codSeg_seq per Codice di SEGNALAZIONI;
 * 2- idDip_seq per ID di DIPARTIMENTI;
 * 3- idOpe_seq per ID di OPERATORI.
 */
-- Dopo ogni singola esecuzione, apparirà nell'output screen "Creato sequence <nome_sequence>."
-- Sequenza per il codice della segnalazione
CREATE SEQUENCE codSeg_seq
    INCREMENT BY 1
    START WITH 1000000
    MINVALUE 1000000
    MAXVALUE 9999999999
    NOCYCLE;

-- Sequenza per l'ID del dipartimento
CREATE SEQUENCE idDip_seq
    INCREMENT BY 1
    START WITH 0
    MINVALUE 0
    MAXVALUE 9999
    NOCYCLE;

-- Sequenza per l'ID dell'operatore
CREATE SEQUENCE idOpe_seq
    INCREMENT BY 1
    START WITH 10000
    MINVALUE 10000
    MAXVALUE 999999
    NOCYCLE;


-- Aggiunta delle chiavi esterne
/* Si aggiungono le seguenti chiavi esterne:
 * 1- IDDip:DIPARTIMENTI per OPERATORI;
 * 2- NumTelefonicoUtente:UTENTI per SEGNALAZIONI;
 * 3- IDDip:DIPARTIMENTI per COINVOLGIMENTI;
 * 4- CodSegnalazione:SEGNALAZIONI per COINVOLGIMENTI;
 * 5- IDOpe:OPERATORI per COMPETENZE;
 * 6- SpecTitolo:TITOLIDISTUDI per COMPETENZE.
 */
-- Dopo ogni singola esecuzione, apparirà nell'output screen "Table <nome_table> modificato."
ALTER TABLE OPERATORI
    ADD CONSTRAINT FK_OPE_DIM FOREIGN KEY (IDDip)
    REFERENCES DIPARTIMENTI(ID)
    ON DELETE CASCADE;
    -- ON DELETE CASCADE: quando si cancella un Dipartimenti, si eliminano anche i suoi Operatori.

ALTER TABLE SEGNALAZIONI
    ADD CONSTRAINT FK_SEG_UTE FOREIGN KEY (NumTelefonicoUtente)
    REFERENCES UTENTI(NumeroDiTelefono);
    -- Nessuna operazione ON DELETE.

ALTER TABLE COINVOLGIMENTI
    ADD CONSTRAINT FK_COI_DIP FOREIGN KEY (IDDip)
    REFERENCES DIPARTIMENTI(ID)
    ON DELETE CASCADE;
    -- ON DELETE CASCADE: quando si cancella un Dipartimento, si eliminano anche i Coinvolgimenti relativi.

ALTER TABLE COINVOLGIMENTI
    ADD CONSTRAINT FK_COI_SEG FOREIGN KEY (CodSegnalazione)
    REFERENCES SEGNALAZIONI(Codice)
    ON DELETE CASCADE;
    -- ON DELETE CASCADE: quando si cancella una Segnalazione, si eliminano anche i Coinvolgimenti relativi.

ALTER TABLE COMPETENZE
    ADD CONSTRAINT FK_COM_OPE FOREIGN KEY (IDOpe)
    REFERENCES OPERATORI(ID)
    ON DELETE CASCADE;
    -- ON DELETE CASCADE: cancello da Competenze ogni volta che si cancella un Operatore.

ALTER TABLE COMPETENZE
    ADD CONSTRAINT FK_COM_TIT FOREIGN KEY (SpecTitolo)
    REFERENCES TITOLIDISTUDI(Specializzazione)
    ON DELETE CASCADE;
    -- ON DELETE CASCADE: cancello da Competenze ogni volta che si cancella un Titolo di Studi.


--------------------------------------------------------------------------------

-- SEQUENZA DI COMANDI
-- Dopo ogni singola esecuzione degli EXEC, apparirà nell'output screen "Procedura PL/SQL completata correttamente."

-- Abilito la scrittura nell'output screen
SET SERVEROUT ON;

----- UTENTI
EXEC PACK_SEN.valori_iniziali_utenti;
EXEC PACK_SEN.stampa_utenti;

EXEC PACK_SEN.insert_utente(3230001111, 'Pippo', 'Baudo', 'NA', 'Napoli', 80137, 'Via Verdi', 13);
EXEC PACK_SEN.insert_utente(3234441111, 'Mike', 'Bongiorno', 'PA', 'Palermo', 90121, 'Piazza Mozart', 112);
EXEC PACK_SEN.stampa_utenti;

INSERT INTO UTENTI VALUES(3990001234, 'Carlo', 'Conti', 'FI', 'Firenze', 50122, 'Viale Bach', 2);
-- Cambiamone il civico
UPDATE UTENTI SET UTENTI.NumeroCivico=4 WHERE (NumeroDiTelefono=3990001234);
EXEC PACK_SEN.stampa_utenti;

-- Rimuovo Mike Bongiorno
EXEC PACK_SEN.delete_utente(3234441111);
EXEC PACK_SEN.stampa_utenti;


----- DIPARTIMENTI
EXEC PACK_SEN.valori_iniziali_dipartimenti;
EXEC PACK_SEN.stampa_dipartimenti;

EXEC PACK_SEN.insert_dipartimento(113, 'Polizia di Stato', 40, 'BO', 'Bologna', 40121, 'Corso Navona', 1);
EXEC PACK_SEN.stampa_dipartimenti;

-- Rimuovo Polizia di Stato di Bologna, ID=7
EXEC PACK_SEN.delete_dipartimento(7);
EXEC PACK_SEN.stampa_dipartimenti;

----- OPERATORI
EXEC PACK_SEN.valori_iniziali_operatori;
EXEC PACK_SEN.stampa_operatori;
EXEC PACK_SEN.stampa_dipartimenti;

EXEC PACK_SEN.insert_operatore('Carla', 'Fracci', 'Ragioneria', 5, 'Ragioniere');
INSERT INTO COMPETENZE VALUES(idOpe_seq.CURRVAL, 'Scienze Politiche');
EXEC PACK_SEN.stampa_operatori;
EXEC PACK_SEN.stampa_dipartimenti;

EXEC PACK_SEN.delete_operatore(idOpe_seq.CURRVAL);
EXEC PACK_SEN.stampa_operatori;
EXEC PACK_SEN.stampa_dipartimenti;

-- Tutti gli operatori del dipartimento con ID=1 passano in quello con ID=2
UPDATE OPERATORI SET OPERATORI.IDDip=2 WHERE (IDDip=1);
EXEC PACK_SEN.stampa_operatori;
EXEC PACK_SEN.stampa_dipartimenti;

----- STAMPA TITOLI
EXEC PACK_SEN.stampa_titoli;
-- Verifichiamo il titolo di studi. Inseriamo un altro laureato in lettere: non sarà nuovamente aggiunto
EXEC PACK_SEN.insert_operatore('Roberto', 'Bolle', 'Lettere', 3, 'Sovrintendente');
EXEC PACK_SEN.stampa_titoli;

----- STAMPA COMPETENZE
EXEC PACK_SEN.stampa_competenze;

----- SEGNALAZIONI
-- Inseriamo una segnalazione: furto a casa di Pippo Baudo
EXEC PACK_SEN.insert_segnalazione(3230001111, 'Furto', 'NA', 'Napoli', 80137, 'Via Verdi', 13, CURRENT_TIMESTAMP);
EXEC PACK_SEN.stampa_segnalazioni;
-- Inseriamo una seconda segnalazione: incendio segnalato da Carlo Conti
EXEC PACK_SEN.insert_segnalazione(3990001234, 'Incendio', 'FI', 'Firenze', 50122, 'Via Escher', 212, CURRENT_TIMESTAMP);
EXEC PACK_SEN.stampa_segnalazioni;
-- Inseriamo una segnalazione in data futura
EXEC PACK_SEN.insert_segnalazione(3990001234, 'Incidente', 'TA', 'Taranto', 74121, 'Largo Caravaggio', 7, '11-DIC-22 21:09:09');
-- Verrà giustamente dato un errore!

----- STORICO SEGNALAZIONI
-- Inizialmente vuoto
EXEC PACK_SEN.stampa_storico;
-- Rimuoviamo l'utente Carlo Conti
EXEC PACK_SEN.delete_utente(3990001234);
EXEC PACK_SEN.stampa_storico;
-- Mostriamo gli utenti rimanenti sottoforma di tabella
SELECT * FROM UTENTI;
--------------------------------------------------------------------------------


-- Eliminazione delle sequenze
-- Dopo ogni singola esecuzione, apparirà nell'output screen "Sequence <nome_sequence> eliminato."
DROP SEQUENCE codSeg_seq;
DROP SEQUENCE idDip_seq;
DROP SEQUENCE idOpe_seq;


-- Revocazione dei privilegi
-- Dopo ogni singola esecuzione, apparirà nell'output screen "Revoke riuscito/a."
REVOKE INSERT, UPDATE, DELETE ON sen.DIPARTIMENTI   FROM amm_dipartimento;
REVOKE INSERT, UPDATE, DELETE ON sen.OPERATORI      FROM amm_dipartimento;
REVOKE SELECT                 ON sen.SEGNALAZIONI   FROM centralinista;
REVOKE INSERT, UPDATE, DELETE ON sen.UTENTI         FROM utente;
REVOKE INSERT, UPDATE, DELETE ON sen.COINVOLGIMENTI FROM centralinista;
REVOKE INSERT, UPDATE, DELETE ON sen.TITOLIDISTUDI  FROM amm_dipartimento;
REVOKE INSERT, UPDATE, DELETE ON sen.COMPETENZE     FROM amm_dipartimento;


-- Rimozione dei ruoli
-- Dopo ogni singola esecuzione, apparirà nell'output screen "Role <nome_role> eliminato."
DROP ROLE utente;
DROP ROLE amm_dipartimento;
DROP ROLE centralinista;


-- Eliminazione dei vincoli di integrità referenziale
-- Dopo ogni singola esecuzione, apparirà nell'output screen "Table <nome_tabella> modificato."
ALTER TABLE OPERATORI      DROP CONSTRAINT FK_OPE_DIM;
ALTER TABLE SEGNALAZIONI   DROP CONSTRAINT FK_SEG_UTE;
ALTER TABLE COINVOLGIMENTI DROP CONSTRAINT FK_COI_DIP;
ALTER TABLE COINVOLGIMENTI DROP CONSTRAINT FK_COI_SEG;
ALTER TABLE COMPETENZE     DROP CONSTRAINT FK_COM_OPE;
ALTER TABLE COMPETENZE     DROP CONSTRAINT FK_COM_TIT;


-- Eliminazione delle tabelle
-- Dopo ogni singola esecuzione, apparirà nell'output screen "Table <nome_tabella> eliminato."
DROP TABLE OPERATORI;
DROP TABLE COINVOLGIMENTI;
DROP TABLE UTENTI;
DROP TABLE DIPARTIMENTI;
DROP TABLE TITOLIDISTUDI;
DROP TABLE COMPETENZE;
DROP TABLE SEGNALAZIONI;
DROP TABLE STORICO_SEGNALAZIONI;

-- Eliminazione del package
-- Dopo l'esecuzione, apparirà nell'output screen "Package PACK_SEN eliminato."
--DROP PACKAGE PACK_SEN;