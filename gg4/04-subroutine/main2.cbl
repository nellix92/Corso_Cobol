       IDENTIFICATION DIVISION.
       PROGRAM-ID. MAIN.
       DATA DIVISION.
           WORKING-STORAGE SECTION.
           01 IDDENTIFICATIVO PIC 9(4) VALUE 1000.
           01 NOME PIC X(30) VALUE "PIPPO".
       PROCEDURE DIVISION.
           DISPLAY "MAIN".
           CALL "UTIL" USING BY CONTENT IDENTIFICATIVO,NOME
           DISPLAY "IDENTIFICATIVO:" IDENTIFICATIVO.
           DISPLAY "NOME:" NOME.

       STOP RUN.