       IDENTIFICATION DIVISION.
       PROGRAM-ID. UTIL.
       DATA DIVISION.
       LINKAGE SECTION.
           01 IDENTIFICATIVO PIC 9(4).
           01 NOME PIC X(15).
       PROCEDURE DIVISION USING IDENTIFICATIVO,NOME.
           DISPLAY "UTIL".
           MOVE 1111 TO IDENTIFICATIVO.
           DISPLAY "NOME: "NOME.
       EXIT PROGRAM.