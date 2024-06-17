       IDENTIFICATION DIVISION.
       PROGRAM-ID. HELLOWORLD.
       AUTHOR. NELLO.
       DATE-WRITTEN. 10/06/2024.
       DATA DIVISION.
           WORKING-STORAGE SECTION.
           01 VALORE PIC S9(3) VALUE -123.
           01 VALORE2 PIC S9(3) VALUE 123.
           01 VALORE3 PIC S9(3) VALUE 0.
           01 VALORE4 PIC X (3) VALUE "ABC".
       PROCEDURE DIVISION.
           A000-FIRST-PARA.
           IF VALORE2 is positive then
             DISPLAY "valore positivo...."
           END-IF
           IF VALORE is negative then
              DISPLAY "valore negativo"
           IF VALORE3 IS ZERO then
              DISPLAY "VALORE 3 ZERO"
           END-IF
           IF VALORE4 IS ALPHABETIC then
            DISPLAY "VALORE 4 ALPHABETIC"
           END-IF
       GOBACK.