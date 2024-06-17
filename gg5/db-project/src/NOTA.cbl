       IDENTIFICATION DIVISION.
       PROGRAM-ID. NOTA.
       AUTHOR. ROBERTO.
       DATE-WRITTEN. 12/06/2024.

       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01 WS-EOF                PIC X VALUE 'N'.
       01 WS-CONTINUE           PIC X VALUE 'Y'.
       01 WS-MSG                PIC X(100).

       01 IDX              PIC 9(2).
       01 SYS-TIME         PIC 9(8).
      
      *****************************************************************
      *****************INIZIO DEI COMANDI SQL*************************
       EXEC SQL BEGIN DECLARE SECTION END-EXEC.
       01 DBNAME                PIC X(30) VALUE SPACE.
       01 USERNAME              PIC X(30) VALUE SPACE.
       01 PASSWORD              PIC X(30) VALUE SPACE.
       01 NOTA-REC_VARS.
            03 NOME             PIC X(20).
            03 DATA_CREATE      PIC X(10).
            03 NOTA             PIC X(300).
       EXEC SQL END DECLARE SECTION END-EXEC.
      ********************INCLUDO SQLCA********************************       
       EXEC SQL INCLUDE SQLCA END-EXEC.
      
       PROCEDURE DIVISION.
       INIZIO.
      ********************CONNESSIONE AL DB*****************************    
      
           DISPLAY "Mi connetto al database.".
           MOVE "notadb@db"        TO DBNAME
           MOVE "postgres"         TO USERNAME
           MOVE SPACE              TO PASSWORD
           EXEC SQL
               CONNECT :USERNAME IDENTIFIED BY :PASSWORD USING :DBNAME
           END-EXEC.
           IF SQLCODE NOT = 0 THEN PERFORM ERROR-RUNTIME STOP RUN.    
           DISPLAY "Connessione al database riuscita!".

      **********************DROP TABLE IF EXISTS************************


      ***********************CREATE TABLE*******************************
           EXEC SQL
               CREATE TABLE IF NOT EXISTS NOTA
               (
                   NOME            CHAR(20),
                   DATA_CREATE     CHAR(10),
                   NOTA            CHAR(300)
               )
           END-EXEC.
           IF SQLCODE NOT = 0 THEN PERFORM ERROR-RUNTIME STOP RUN.
           DISPLAY "Creazione della tabella completata".

      *********************INSERT ROWS**********************************
           PERFORM UNTIL WS-CONTINUE = 'N' or WS-CONTINUE = 'n'
               DISPLAY "INSERISCI NOME: "
               ACCEPT NOME
               DISPLAY "INSERISCI DATA-CREATE (XX/XX/XXXX): "
               ACCEPT DATA_CREATE
               DISPLAY "INSERISCI NOTA: "
               ACCEPT NOTA 
               EXEC SQL
                   INSERT INTO NOTA (NOME, DATA_CREATE, NOTA)
                   VALUES (:NOME, :DATA_CREATE, :NOTA)
               END-EXEC
               IF SQLCODE NOT = 0 THEN
                   PERFORM ERROR-RUNTIME
                   STOP RUN
               END-IF
               DISPLAY "Inserimento record completato"
               
               DISPLAY "Vuoi inserire un'altra nota? (Y/N): "
               ACCEPT WS-CONTINUE
           END-PERFORM.

      ********************COMMIT****************************************          
           EXEC SQL COMMIT WORK END-EXEC.

      ********************DISCONNECT************************************      
           EXEC SQL DISCONNECT ALL END-EXEC. 

      *********************FINISH***************************************     
           DISPLAY "Programma finito".
           STOP RUN.

      ********************VISUALIZZAZIONI ERRORI************************ 
           ERROR-RUNTIME.
                 DISPLAY "*********SQL ERROR***********"
                 DISPLAY "SQLCODE: " SQLCODE
           STOP RUN.


