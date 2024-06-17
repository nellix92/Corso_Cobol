       IDENTIFICATION DIVISION.
       PROGRAM-ID. ESEMPIOFETCHDB.
       AUTHOR. NELLO.
       DATE-WRITTEN. 12/06/2024.
       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01  PERSONA-REC.
            05 D-ID-PERSONA     PIC 9(4).
            05 FILLER           PIC X.
            05 D-NOME           PIC X(20).
            05 FILLER           PIC X.
            05 D-ETA            PIC 9(2).
       01 PERSONA-COUNT         PIC 9(4). 
       01 ID_PERSONA_SEARCH     PIC 9(4) VALUE 4.
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
          
      **********************SELECT COUNT(*) INTO VARIABILE************************
           EXEC SQL
              SELECT COUNT(*) INTO :PERSONA-COUNT FROM PERSONA
           END-EXEC.
           IF SQLCODE NOT = ZERO PERFORM ERROR-RUNTIME.
           DISPLAY "NUMERO RECORD TOTALI: "PERSONA-COUNT.
      **********************SELECT * ORDER BY************************
           EXEC SQL
              DECLARE C1 CURSOR FOR
                      SELECT ID_PERSONA,NOME,ETA 
                      FROM PERSONA
                      ORDER BY ID_PERSONA
           END-EXEC.
           EXEC SQL
                 OPEN C1
           END-EXEC.

           DISPLAY "---- -------------------- ---"
           DISPLAY "NUM  NOME---------------- ETA"
      ******************CONSUMARE RECORD VUOTO**************
           EXEC SQL
                 FETCH C1 INTO  :ID-PERSONA,:NOME,:ETA
           END-EXEC.
           PERFORM UNTIL SQLCODE NOT = ZERO
            MOVE ID-PERSONA TO D-ID-PERSONA
            MOVE NOME       TO D-NOME
            MOVE ETA        TO D-ETA
            EXEC SQL
                 FETCH C1 INTO  :ID-PERSONA,:NOME,:ETA
            END-EXEC
            DISPLAY PERSONA-REC
           END-PERFORM.
          
          
           EXEC SQL
                 CLOSE C1
           END-EXEC
      
      ***********************SELECT * WHERE ************************
           EXEC SQL
              DECLARE C1 CURSOR FOR
                      SELECT ID_PERSONA,NOME,ETA 
                      FROM PERSONA
                      WHERE ID_PERSONA = :ID_PERSONA_SEARCH
                      ORDER BY ID_PERSONA 
           END-EXEC.
           EXEC SQL
                 OPEN C1
           END-EXEC.

           DISPLAY "---- --------SEARCH----- ---"
           DISPLAY "NUM  NOME---------------- ETA"
      ******************CONSUMARE RECORD VUOTO**************
           EXEC SQL
                 FETCH C1 INTO  :ID-PERSONA,:NOME,:ETA
           END-EXEC.
           PERFORM UNTIL SQLCODE NOT = ZERO
            MOVE ID-PERSONA TO D-ID-PERSONA
            MOVE NOME       TO D-NOME
            MOVE ETA        TO D-ETA
            EXEC SQL
                 FETCH C1 INTO  :ID-PERSONA,:NOME,:ETA
            END-EXEC
            DISPLAY PERSONA-REC
           END-PERFORM.

           EXEC SQL
                 CLOSE C1
           END-EXEC


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

