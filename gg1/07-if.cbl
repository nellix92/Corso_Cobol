       IDENTIFICATION DIVISION.
       PROGRAM-ID. HELLOWORLD.
       AUTHOR. NELLO.
       DATE-WRITTEN. 10/06/2024.
       DATA DIVISION.
           WORKING-STORAGE SECTION.
           01 VALORE PIC 9(3) VALUE 0.
           01 VALORE2 PIC 9(3) VALUE 0.
       PROCEDURE DIVISION.
           A000-FIRST-PARA.
           DISPLAY"INSERISCI UN VALORE: ".
           ACCEPT VALORE.
           DISPLAY"INSERISCI UN VALORE 2: ".
           ACCEPT VALORE2.
           IF VALORE >=40 then
             DISPLAY "FA CALDO...."
           else
             DISPLAY "MEGLIO..."
           END-IF
           IF VALORE >=40 AND VALORE2 >=40 then
              DISPLAY "ENTRAMBI ALTI"
           else
              DISPLAY "CONDIZIONE NON SODDISFATTA"
           END-IF
       GOBACK.