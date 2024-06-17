       IDENTIFICATION DIVISION.
       PROGRAM-ID. OPERAZIONE-UPDATE.
       AUTHOR. NELLO.
       DATE-WRITTEN. 12/06/2024.

       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01 NOME_NOTA_SEARCH    PIC X(20).
       01 NOTA-REC.
           05 D-NOME             PIC X(20).
           05 D-DATA-CREATE      PIC X(10).
           05 FILLER             PIC X.
           05 D-NOTA             PIC X(300).

       EXEC SQL BEGIN DECLARE SECTION END-EXEC.
       01 DBNAME                PIC X(30) VALUE SPACE.
       01 USERNAME              PIC X(30) VALUE SPACE.
       01 PASSWORD              PIC X(30) VALUE SPACE.
       01 NOTA-REC_VARS.
            03 NOME             PIC X(20).
            03 DATA_CREATE      PIC X(10).
            03 NOTA             PIC X(300).
       EXEC SQL END DECLARE SECTION END-EXEC.

       EXEC SQL INCLUDE SQLCA END-EXEC.

       PROCEDURE DIVISION.

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
                 CLOSE C1
           END-EXEC.
           DISPLAY "INSERISCI IL NOME DELLA NOTA DA AGGIORNARE: ".
           ACCEPT NOME_NOTA_SEARCH.
           DISPLAY "INSERISCI LA NUOVA NOTA: ".
           ACCEPT NUOVA_NOTA.
           EXEC SQL
                UPDATE NOTA
                SET NOTA = :NUOVA_NOTA
                WHERE NOME = :NOME_NOTA_SEARCH
           END-EXEC.
           IF SQLCODE NOT = 0 THEN
               PERFORM ERROR-RUNTIME
               STOP RUN
           END-IF.
           DISPLAY "Nota aggiornata con successo".
           EXIT.
