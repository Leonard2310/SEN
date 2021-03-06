create or replace TRIGGER VINCOLI_COINVOLGIMENTI_INSERT
BEFORE INSERT ON COINVOLGIMENTI
FOR EACH ROW
-- Si attiva SUCC all'inserimento di un coinvolgimento
DECLARE
    -- numero massimo di dipartimenti coinvolti in una segnalazione
    max_Dipartimenti constant number := 6;

    -- variabile in cui inserire il numero di dipartimenti coinvolti in una segnalazione
    numero_Dipartimenti_coinvolti number := 0;

    -- dichiarazione dell'eccezione
    OverflowDipartimenti exception;

BEGIN
-- Si fa il conteggio di quante segnalazioni sono già presenti all'int della tabella coinvolgimenti
--  con il codice in input e inserisce il risultato nel numero did dipartimenti coinvolti
    SELECT COUNT(*) INTO numero_Dipartimenti_coinvolti
    FROM Coinvolgimenti C
    WHERE C.CodSegnalazione = :NEW.CodSegnalazione;

    DBMS_OUTPUT.PUT_LINE('Verifica inserimento del coinvolgimento.');
    IF (numero_Dipartimenti_coinvolti >= max_Dipartimenti)
        THEN RAISE OverflowDipartimenti;
    END IF;

    -- inserimento corretto
    DBMS_OUTPUT.PUT_LINE('Inserimento accettato.');

EXCEPTION
    WHEN OverflowDipartimenti
        THEN DBMS_OUTPUT.PUT_LINE('Inserimento rifiutato: overflow di dipartimenti coinvolti nella segnalazione numero ' || :NEW.CodSegnalazione || '.');
        RAISE_APPLICATION_ERROR(-20000,'Errore massimo numero di dipartimenti coinvolti in una segnalazione.');

END;
