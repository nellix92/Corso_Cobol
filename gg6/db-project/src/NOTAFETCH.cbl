       IDENTIFICATION DIVISION.
       PROGRAM-ID. NOTAFETCH.
       AUTHOR. NELLO.
       DATE-WRITTEN. 12/06/2024.

       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01 WS-EOF                PIC X VALUE 'N'.
       01 WS-CONTINUE           PIC X VALUE 'Y'.
       01 WS-MSG                PIC X(100).
       01 OPERAZIONE            PIC X VALUE SPACE.
       01 IDX              PIC 9(2).
       01 SYS-TIME         PIC 9(8).
       01 NOME_NOTA_SEARCH PIC X(20).
       01 DATA_SEARCH PIC X(10).
       01 NUOVA_NOTA       PIC X(300).
       01 NOTA-REC.
           05 D-NOME PIC X(20).
           05 D-DATA-CREATE PIC X(10).
           05 FILLER           PIC X.
           05 D-NOTA PIC X(300).
      
      ******************************************************************
      *****************INIZIO DEI COMANDI SQL***************************
       EXEC SQL BEGIN DECLARE SECTION END-EXEC.
       01 DBNAME                PIC X(30) VALUE SPACE.
       01 USERNAME              PIC X(30) VALUE SPACE.
       01 PASSWORD              PIC X(30) VALUE SPACE.
       01 NOTA-REC_VARS.
            03 NOME             PIC X(20).
            03 DATA_CREATE      PIC X(10).
            03 NOTA             PIC X(300).
       EXEC SQL END DECLARE SECTION END-EXEC.
      ********************INCLUDO SQLCA*********************************       
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

      *******************MENU*******************************************
           PERFORM UNTIL WS-CONTINUE = 'N'
              DISPLAY "------------MENU------------"
              DISPLAY "SCEGLI UN'OPERAZIONE:"
              DISPLAY "[L]EGGI"
              DISPLAY "[C]ERCA"
              DISPLAY "[U]PDATE"
              DISPLAY "[D]ELETE"
              ACCEPT OPERAZIONE
              EVALUATE OPERAZIONE
                WHEN 'C'
                      PERFORM OPERAZIONE-CREATE
                WHEN 'L'
                      PERFORM OPERAZIONE-LEGGI
                WHEN 'C'
                      PERFORM OPERAZIONE-CERCA
                WHEN 'U'
                      PERFORM OPERAZIONE-UPDATE
                WHEN 'D'
                      PERFORM OPERAZIONE-DELETE
                WHEN OTHER
                      DISPLAY "OPERAZIONE NON VALIDA"
               END-EVALUATE
               DISPLAY "VUOI CONTIMUARE? [Y/N]"
               ACCEPT WS-CONTINUE
           END-PERFORM.
           STOP RUN.
      ***********************CREATE*************************************
       OPERAZIONE-CREATE.
           EXEC SQL
              DECLARE C1 CURSOR FOR
                      SELECT NOME, DATA_CREATE, NOTA 
                      FROM NOTA
                      ORDER BY NOME
           END-EXEC.
           EXEC SQL
                 OPEN C1
           END-EXEC.

           DISPLAY "---- LISTA NOMI ----"
           
           EXEC SQL
                 FETCH C1 INTO :NOME, :DATA_CREATE, :NOTA
           END-EXEC.
           PERFORM UNTIL SQLCODE NOT = 0
               MOVE NOME TO D-NOME
               DISPLAY "NOME: " D-NOME
               EXEC SQL
                   FETCH C1 INTO :NOME, :DATA_CREATE, :NOTA
               END-EXEC
           END-PERFORM.
          
           EXEC SQL
                 CLOSE C1
           END-EXEC.
           DISPLAY "INSERISCI NOME: ".
           ACCEPT NOME.
           DISPLAY "INSERISCI DATA-CREATE (XX/XX/XXXX): ".
           ACCEPT DATA_CREATE.
           DISPLAY "INSERISCI NOTA: ".
           ACCEPT NOTA.
           EXEC SQL
                INSERT INTO NOTA (NOME, DATA_CREATE, NOTA)
                VALUES (:NOME, :DATA_CREATE, :NOTA)
           END-EXEC.
           IF SQLCODE NOT = 0 THEN
               PERFORM ERROR-RUNTIME
               STOP RUN
           END-IF.
           DISPLAY "Inserimento record completato".  
      **********************SELECT * ORDER BY***************************
       OPERAZIONE-LEGGI.
           EXEC SQL
              DECLARE C1 CURSOR FOR
                      SELECT NOME,DATA_CREATE,NOTA 
                      FROM NOTA
                      ORDER BY NOME
           END-EXEC.
           EXEC SQL
                 OPEN C1
           END-EXEC.

           DISPLAY "---------------------------".
           DISPLAY "NOME                  DATA          NOTA".
      ******************CONSUMARE RECORD VUOTO**************************
           EXEC SQL
                 FETCH C1 INTO  :NOME,:DATA_CREATE,:NOTA
           END-EXEC.
           PERFORM UNTIL SQLCODE NOT = ZERO
            MOVE NOME TO D-NOME
            MOVE DATA_CREATE TO D-DATA-CREATE
            MOVE NOTA TO D-NOTA
            EXEC SQL
                 FETCH C1 INTO  :NOME,:DATA_CREATE,:NOTA
            END-EXEC
            DISPLAY NOTA-REC
           END-PERFORM.
          
          
           EXEC SQL
                 CLOSE C1
           END-EXEC.
           
      ***********************SELECT * WHERE ****************************
       OPERAZIONE-CERCA.
           EXEC SQL
              DECLARE C1 CURSOR FOR
                      SELECT NOME, DATA_CREATE, NOTA 
                      FROM NOTA
                      ORDER BY NOME
           END-EXEC.
           EXEC SQL
                 OPEN C1
           END-EXEC.

           DISPLAY "---- LISTA NOMI ----"
           
           EXEC SQL
                 FETCH C1 INTO :NOME, :DATA_CREATE, :NOTA
           END-EXEC.
           PERFORM UNTIL SQLCODE NOT = 0
               MOVE NOME TO D-NOME
               DISPLAY "NOME: " D-NOME
               EXEC SQL
                   FETCH C1 INTO :NOME, :DATA_CREATE, :NOTA
               END-EXEC
           END-PERFORM.
          
           EXEC SQL
                 CLOSE C1
           END-EXEC.
           DISPLAY "INSERISCI IL NOME DA CERCARE: ".
           ACCEPT NOME_NOTA_SEARCH.
           EXEC SQL
               DECLARE C1 CURSOR FOR
                    SELECT NOME,DATA_CREATE,NOTA 
                    FROM NOTA
                    WHERE NOME = :NOME_NOTA_SEARCH
           END-EXEC.
           EXEC SQL
                    OPEN C1
           END-EXEC.

           DISPLAY "---- --------SEARCH----- ---".
           EXEC SQL
                 FETCH C1 INTO  :NOME,:DATA_CREATE,:NOTA
           END-EXEC.
           PERFORM UNTIL SQLCODE NOT = ZERO
            MOVE NOME TO D-NOME
            MOVE DATA_CREATE TO D-DATA-CREATE
            MOVE NOTA TO D-NOTA
            EXEC SQL
                 FETCH C1 INTO  :NOME,:DATA_CREATE,:NOTA
            END-EXEC
            DISPLAY NOTA-REC
           END-PERFORM.
          
          
           EXEC SQL
                 CLOSE C1
           END-EXEC.
      *****************UPDATE WHERE NOME********************************
       OPERAZIONE-UPDATE.
           EXEC SQL
              DECLARE C1 CURSOR FOR
                      SELECT NOME, DATA_CREATE, NOTA 
                      FROM NOTA
                      ORDER BY NOME
           END-EXEC.
           EXEC SQL
                 OPEN C1
           END-EXEC.

           DISPLAY "---- LISTA NOMI ----"
           
           EXEC SQL
                 FETCH C1 INTO :NOME, :DATA_CREATE, :NOTA
           END-EXEC.
           PERFORM UNTIL SQLCODE NOT = 0
               MOVE NOME TO D-NOME
               DISPLAY "NOME: " D-NOME
               EXEC SQL
                   FETCH C1 INTO :NOME, :DATA_CREATE, :NOTA
               END-EXEC
           END-PERFORM.
           EXEC SQL
                 FETCH C2 INTO  :NOME,:DATA_CREATE,:NOTA
           END-EXEC.
           PERFORM UNTIL SQLCODE NOT = ZERO
               MOVE NOME TO D-NOME
               MOVE DATA_CREATE TO D-DATA-CREATE
               MOVE NOTA TO D-NOTA
               DISPLAY NOTA-REC
               EXEC SQL
                   FETCH C2 INTO  :NOME,:DATA_CREATE,:NOTA
               END-EXEC
           END-PERFORM.
          
           EXEC SQL
                 CLOSE C2
           END-EXEC
           DISPLAY "INSERISCI IL NOME DA AGGIORNARE: ".
           ACCEPT NOME_NOTA_SEARCH.
           DISPLAY "INSERISCI LA NUOVA NOTA: ".
           ACCEPT NUOVA_NOTA.

           EXEC SQL
              UPDATE NOTA
              SET NOTA = :NUOVA_NOTA
              WHERE NOME = :NOME_NOTA_SEARCH
           END-EXEC.
           IF SQLCODE NOT = 0 THEN PERFORM ERROR-RUNTIME STOP RUN.
           EXEC SQL
                 COMMIT WORK
           END-EXEC.

           DISPLAY "Nota aggiornata con successo!".
           EXIT.
      *********************DELETE WHERE NOME****************************
       OPERAZIONE-DELETE.
           EXEC SQL
              DECLARE C1 CURSOR FOR
                      SELECT NOME, DATA_CREATE, NOTA 
                      FROM NOTA
                      ORDER BY NOME
           END-EXEC.
           EXEC SQL
                 OPEN C1
           END-EXEC.

           DISPLAY "---- LISTA NOMI ----"
           
           EXEC SQL
                 FETCH C1 INTO :NOME, :DATA_CREATE, :NOTA
           END-EXEC.
           PERFORM UNTIL SQLCODE NOT = 0
               MOVE NOME TO D-NOME
               DISPLAY "NOME: " D-NOME
               EXEC SQL
                   FETCH C1 INTO :NOME, :DATA_CREATE, :NOTA
               END-EXEC
           END-PERFORM.
           DISPLAY "INSERISCI IL NOME DELLA NOTA DA CANCELLARE: ".
           ACCEPT NOME_NOTA_SEARCH.

           EXEC SQL
              DELETE FROM NOTA
              WHERE NOME = :NOME_NOTA_SEARCH
           END-EXEC.
           IF SQLCODE NOT = 0 THEN PERFORM ERROR-RUNTIME STOP RUN.
           EXEC SQL
                COMMIT WORK
           END-EXEC.
           DISPLAY "Nota cancellata con successo!".
           EXIT.
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


