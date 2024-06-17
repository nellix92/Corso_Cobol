       IDENTIFICATION DIVISION.
       PROGRAM-ID. NOTA1.
       AUTHOR. NELLO.
       DATE-WRITTEN. 12/06/2024.
       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01 WS-EOF                PIC X VALUE 'N'.
       01 WS-CONTINUE           PIC X VALUE 'Y'.
       01 WS-MSG                PIC X(100).
       01 WS-INDICE             PIC 9(2) VALUE 1.
       01 IDX                   PIC 9(2).
       01 SYS-TIME              PIC 9(8).
       01 WS-TEST-DATA.
           03 FILLER OCCURS 7 TIMES.
              05 TEST-NOME       PIC X(20).
              05 TEST-DATA       PIC X(10).
              05 TEST-NOTA       PIC X(300).
       01 TMP-NOME       PIC X(20).
       01 TMP-DATA       PIC X(10).
       01 TMP-NOTA       PIC X(300). 
      
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
           IF SQLCODE NOT = ZERO  PERFORM ERROR-RUNTIME STOP RUN.    
           DISPLAY "Connessione al database riuscita!".

      **********************DROP TABLE IF EXISTS************************
           EXEC SQL
               DROP TABLE IF EXISTS NOTA
           END-EXEC.
           IF SQLCODE NOT = ZERO PERFORM ERROR-RUNTIME.
           DISPLAY "Cancello tabella se esiste!".

      ***********************CREATE TABLE*******************************
           EXEC SQL
               CREATE TABLE NOTA
               (
                   NOME            CHAR(20),
                   DATA_CREATE     CHAR(10),
                   NOTA            CHAR(300)
               )
           END-EXEC.
           IF SQLCODE NOT = ZERO PERFORM ERROR-RUNTIME.
           DISPLAY "Creazione della tabella completata".

      *********************INSERT ROWS**********************************
           PERFORM UNTIL WS-CONTINUE = 'N' or WS-CONTINUE = 'n'
               DISPLAY "INSERISCI NOME: "
               ACCEPT TEST-NOME(WS-INDICE)
               DISPLAY "INSERISCI DATA-CREATE (XX/XX/XXXX): "
               ACCEPT TEST-DATA(WS-INDICE)
               DISPLAY "INSERISCI NOTA: "
               ACCEPT TEST-NOTA(WS-INDICE)
               MOVE TEST-NOME(WS-INDICE) TO TMP-NOME
               MOVE TEST-DATA(WS-INDICE) TO TMP-DATA
               MOVE TEST-NOTA(WS-INDICE) TO TMP-NOTA
               EXEC SQL
                   INSERT INTO NOTA (NOME, DATA_CREATE, NOTA)
                   VALUES (:TMP-NOME, :TMP-DATA,
                            :TMP-NOTA)
               END-EXEC
               IF SQLCODE NOT = ZERO PERFORM ERROR-RUNTIME STOP RUN
               DISPLAY "Inserimento record completato"
               
               DISPLAY "Vuoi inserire un'altra nota? (Y/N): "
               ACCEPT WS-CONTINUE
               ADD 1 TO WS-INDICE
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


