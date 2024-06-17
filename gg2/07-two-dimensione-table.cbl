       IDENTIFICATION DIVISION.
       PROGRAM-ID. CONVERTITORE-C-F.
       AUTHOR. ROBERTO.
       DATE-WRITTEN. 12/06/2024.
 
       DATA DIVISION.
           WORKING-STORAGE SECTION.
           01 TABELLA. 
               05 CONTENUTO OCCURS 2 TIMES.
                   10 CAMPO-A PIC A(10) VALUE "TEST".
                   10 CAMPO-B OCCURS 2 TIMES.
                       15 CAMPO-C  PIC X(6) VALUE " SOTTO".


       PROCEDURE DIVISION.
           MAIN.
               DISPLAY "TABELLA A DIMENSIONE DUE:" TABELLA.
           STOP RUN.
      