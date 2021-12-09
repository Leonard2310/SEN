CREATE OR REPLACE PACKAGE PACK_SEN AS 

    -- PROCEDURES
    PROCEDURE insert_utenti(
        InNumeroDiTelefono IN UTENTI.NumeroDiTelefono%TYPE,
        InNome IN UTENTI.Nome%TYPE,
        InCognome IN UTENTI.Cognome%TYPE,
        InProvincia IN UTENTI.Provincia%TYPE,
        InCittà IN UTENTI.Città%TYPE,
        InCAP IN UTENTI.CAP%TYPE,
        InVia IN UTENTI.Via%TYPE,
        InNumeroCivico IN UTENTI.NumeroCivico%TYPE
    );
    
    PROCEDURE insert_richieste(
        InProvincia IN RICHIESTE.Provincia%TYPE,
        InCittà IN RICHIESTE.Città%TYPE,
        InCAP IN RICHIESTE.CAP%TYPE,
        InVia IN RICHIESTE.Via%TYPE,
        InNumeroCivico IN RICHIESTE.NumeroCivico%TYPE,
        InTStamp IN RICHIESTE.TStamp%TYPE
    );
    
    PROCEDURE valori_iniziali_dipartimento(
        InNumeroEmergenza IN DIPARTIMENTI.NumeroEmergenza%TYPE,
        InTipologia IN DIPARTIMENTI.Tipologia%TYPE,
        InNumeroVeicoli IN DIPARTIMENTI.NumeroVeicoli%TYPE,
        InProvincia IN DIPARTIMENTI.Provincia%TYPE,
        InCittà IN DIPARTIMENTI.Città%TYPE,
        InCAP IN DIPARTIMENTI.CAP%TYPE,
        InVia IN DIPARTIMENTI.Via%TYPE,
        InNumeroCivico IN DIPARTIMENTI.NumeroCivico%TYPE
    );

    PROCEDURE valori_iniziali_operatore(
        InNome IN OPERATORI.Nome%TYPE,
        InCognome IN OPERATORI.Cognome%TYPE,
        InRuolo IN OPERATORI.Ruolo%TYPE
    );

    
    -- FUNCTIONS
    /*
    FUNCTION join_centralinista(
        InProvincia IN RICHIESTE.Provincia%TYPE,
        InCittà IN RICHIESTE.Città%TYPE,
        InCAP IN RICHIESTE.CAP%TYPE,
        InVia IN RICHIESTE.Via%TYPE,
        InNumeroCivico IN RICHIESTE.NumeroCivico%TYPE,
        InTStamp IN RICHIESTE.TStamp%TYPE,
        InTipologiaEmergenza IN SEGNALAZIONI.TipologiaEmergenza%TYPE
    ) RETURN STORICO_SEGNALAZIONI;
    */

  /* TODO enter package declarations (types, exceptions, methods etc) here */ 

END PACK_SEN;