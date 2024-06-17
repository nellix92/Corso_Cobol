       IDENTIFICATION DIVISION.
       PROGRAM-ID. NOTAFETCHSUB.
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
                      CALL OPERAZIONE-CREATE
                WHEN 'L'
                      CALL OPERAZIONE-LEGGI
                WHEN 'C'
                      CALL OPERAZIONE-CERCA
                WHEN 'U'
                      CALL OPERAZIONE-UPDATE
                WHEN 'D'
                      CALL OPERAZIONE-DELETE
                WHEN OTHER
                      DISPLAY "OPERAZIONE NON VALIDA"
               END-EVALUATE
               DISPLAY "VUOI CONTIMUARE? [Y/N]"
               ACCEPT WS-CONTINUE
           END-PERFORM.
           STOP RUN.


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


