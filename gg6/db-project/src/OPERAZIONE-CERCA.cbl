       IDENTIFICATION DIVISION.
       PROGRAM-ID. OPERAZIONE-CERCA.
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
               DECLARE C2 CURSOR FOR
                    SELECT NOME,DATA_CREATE,NOTA 
                    FROM NOTA
                    WHERE NOME = :NOME_NOTA_SEARCH
           END-EXEC.
           EXEC SQL
                    OPEN C2
           END-EXEC.

           DISPLAY "---- --------SEARCH----- ---".
           EXEC SQL
                 FETCH C2 INTO  :NOME,:DATA_CREATE,:NOTA
           END-EXEC.
           PERFORM UNTIL SQLCODE NOT = ZERO
            MOVE NOME TO D-NOME
            MOVE DATA_CREATE TO D-DATA-CREATE
            MOVE NOTA TO D-NOTA
            EXEC SQL
                 FETCH C2 INTO  :NOME,:DATA_CREATE,:NOTA
            END-EXEC
            DISPLAY NOTA-REC
           END-PERFORM.
          
          
           EXEC SQL
                 CLOSE C2
           END-EXEC.
