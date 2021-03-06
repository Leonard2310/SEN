create or replace TRIGGER VERIFICA_INSERT_UTENTI
BEFORE INSERT ON UTENTI
FOR EACH ROW
-- Si attiva PRIMA dell'inserimento utenti
DECLARE
-- Controlla se il NumTelefonico che si vuole inserire è già presente -> aumenta count e fa raise
    -- dichiarazione variabile per verifica dell'esistenza dell'utente
    numero_utenti NUMBER := 0;
    -- dichiarazione dell'eccezione
    UTENTE_ESISTENTE EXCEPTION;
BEGIN
    SELECT COUNT(*) INTO numero_utenti FROM UTENTI U
                    WHERE U.NumeroDiTelefono = :NEW.NumeroDiTelefono;
    IF (numero_utenti > 0)
    THEN
        RAISE UTENTE_ESISTENTE;
    END IF;
EXCEPTION
    WHEN UTENTE_ESISTENTE
    THEN
        DBMS_OUTPUT.PUT_LINE('Inserimento rifiutato: utente già esistente.');
        RAISE_APPLICATION_ERROR(-20500,'Errore inserimento di un utente già esistente.');
END;
