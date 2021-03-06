create or replace TRIGGER VINCOLI_OPERATORI_DELETE
AFTER DELETE ON OPERATORI
FOR EACH ROW
-- Tale trigger si attiva successivamente all'eliminazione sulla tabella operatori
BEGIN
  -- Aggiornamento del numero di opertaori nel dipartimento
  -- Prende il dipartimento con lo stesso ID dell'op eliminato e va ad Aggiornare il cmapo operatore diminuendo di 1
    UPDATE DIPARTIMENTI D SET D.NumeroOperatori = D.NumeroOperatori - 1
    WHERE D.ID = :OLD.IDDip;

    DBMS_OUTPUT.PUT_LINE('Aggiornato numero operatori in tabella DIPARTIMENTI per il dipartimento con ID ' || :OLD.IDDip);
END;
