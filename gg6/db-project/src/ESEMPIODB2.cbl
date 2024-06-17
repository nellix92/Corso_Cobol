       IDENTIFICATION DIVISION.
       PROGRAM-ID. ESEMPIODB2.
       AUTHOR. NELLO.
       DATE-WRITTEN. 12/06/2024.
       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01 TEST-DATA.
           03 FILLER PIC X(26) VALUE "0001PINO PINI           45".
           03 FILLER PIC X(26) VALUE "0002LINO LINI           35".
           03 FILLER PIC X(26) VALUE "0003GINO GINI           25".
           03 FILLER PIC X(26) VALUE "0004VINO VINI           55".
           03 FILLER PIC X(26) VALUE "0005RINO RINI           15".
           03 FILLER PIC X(26) VALUE "0006ZINO ZINI           65".
           03 FILLER PIC X(26) VALUE "0007TINO TINI           75".
       01 TEST-DATA-R REDEFINES TEST-DATA.
           03 TEST-TBL OCCURS 7.
            05 TEST-NUMERO PIC 9(4).
            05 TEST-NOME   PIC X(20).
            05 TEST-ETA    PIC 9(2).
       01 IDX              PIC 9(2).
       01 SYS-TIME         PIC 9(8).
      
      *****************************************************************
      *****************INIZIO DEI COMANDI SQL**************************
       EXEC SQL BEGIN DECLARE SECTION END-EXEC.
       01 DBNAME                PIC X(30) VALUE SPACE.
       01 USERNAME              PIC X(30) VALUE SPACE.
       01 PASSWORD              PIC X(30) VALUE SPACE.
       01 PERSONA-REC_VARS.
            03 ID-PERSONA  PIC 9(4) VALUE ZERO.
            03 NOME   PIC X(20).
            03 ETA    PIC 9(2) VALUE ZERO.
       EXEC SQL END DECLARE SECTION END-EXEC.
      ********************INCLUDO SQLCA********************************
       EXEC SQL INCLUDE SQLCA END-EXEC.

       PROCEDURE DIVISION.
           INIZIO.
      ********************CONNESSIONE AL DB*****************************    
           DISPLAY "Mi connetto al database.".
           MOVE "testdb2@db"        TO DBNAME
           MOVE "postgres"        TO USERNAME
           MOVE SPACE              TO PASSWORD
           EXEC SQL
               CONNECT :USERNAME IDENTIFIED BY :PASSWORD USING :DBNAME
           END-EXEC.
           IF SQLCODE NOT = ZERO PERFORM ERROR-RUNTIME STOP RUN.       
           DISPLAY "Conessione al database riuscita!".
          
      **********************DROP TABLE IF EXISTS************************
           EXEC SQL
               DROP TABLE IF EXISTS PERSONA
           END-EXEC.
           IF SQLCODE NOT = ZERO PERFORM ERROR-RUNTIME.
           DISPLAY "Cancello tabella se esiste!".
      ***********************CREATE TABLE*******************************
           EXEC SQL
               CREATE TABLE PERSONA
               (
                   ID_PERSONA      NUMERIC(4,0) NOT NULL,
                   NOME    CHAR(20),
                   ETA     NUMERIC(2,0),
                   CONSTRAINT ID_PERSONA_0 PRIMARY KEY(ID_PERSONA)
               )
           END-EXEC.
           IF SQLCODE NOT = ZERO PERFORM ERROR-RUNTIME.
           DISPLAY "Creazione della tabella completata".
      *********************INSERT ROWS**********************************
      **********************INSERT ONLY ONE ROWS************************
           EXEC SQL
             INSERT INTO PERSONA(ID_PERSONA,NOME,ETA) VALUES 
                                   (0, 'CORCA CAVOLO', 50)
           END-EXEC.
           IF SQLCODE NOT = ZERO PERFORM ERROR-RUNTIME.
           DISPLAY "Inserimento record completato".

      **********************INSERT MULTI ROWS************************
           PERFORM VARYING  IDX FROM 1 BY 1 UNTIL IDX  > 7
                 MOVE TEST-NUMERO(IDX) TO ID-PERSONA  
                 MOVE TEST-NOME(IDX) TO NOME   
                 MOVE TEST-ETA(IDX) TO ETA  
                 DISPLAY ID-PERSONA
                 DISPLAY NOME
                 DISPLAY ETA
                 EXEC SQL
                       INSERT INTO PERSONA(ID_PERSONA,NOME,ETA) VALUES
                       (:ID-PERSONA,:NOME,:ETA) 
                 END-EXEC
          
           IF SQLCODE NOT = ZERO PERFORM ERROR-RUNTIME
           END-PERFORM.
           DISPLAY "Inserimento records completato".
             
      ********************COMMIT****************************************
           EXEC SQL COMMIT WORK END-EXEC.
      ********************DISCONNECT************************************
           EXEC SQL DISCONNECT ALL END-EXEC. 
      *********************FINISH***************************************
           DISPLAY "Programma finito" 
           STOP RUN.

       
       
       STOP RUN.
      ********************VISUALIZZAZIONI ERRORI************************ 
           ERROR-RUNTIME.
               DISPLAY "*********SQL ERROR***********"
               EVALUATE SQLCODE
                 WHEN +10
                      DISPLAY "RECORD NOT FOUND"
                 WHEN -01
                      DISPLAY "CONNESSIONE FALLITA"
                 WHEN -20
                      DISPLAY "INTERNAL ERROR"
                 WHEN -30
                      DISPLAY "ERRORE POSTGRES"
                      DISPLAY "ERRCODE: " SQLSTATE
                      DISPLAY SQLERRMC
                 WHEN OTHER
                      DISPLAY "ERRORE SCONOSCIUTO"
                      DISPLAY "ERRCODE: " SQLSTATE
                      DISPLAY SQLERRMC
           STOP RUN.

