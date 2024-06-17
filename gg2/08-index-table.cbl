       IDENTIFICATION DIVISION.
       PROGRAM-ID. CONVERTITORE-C-F.
       AUTHOR. ROBERTO.
       DATE-WRITTEN. 12/06/2024.
 
       DATA DIVISION.
           WORKING-STORAGE SECTION.
           01 TABELLA. 
               05 A OCCURS 3 TIMES.
                   10 B PIC A(2).
                   10 C OCCURS 2 TIMES.
                       15 D  PIC X(3).


       PROCEDURE DIVISION.
           MAIN.
               MOVE 'abcdefghilmnopqrstuvz' to TABELLA.
               DISPLAY "TABELLA:" TABELLA.
               DISPLAY "INDICI:".
               DISPLAY "A(1)" A(1)
               DISPLAY "A(2)" A(2)
               DISPLAY "A(3)" A(3)
 
               DISPLAY "C(1,1)" C(1,1)
               DISPLAY "C(1,2)" C(1,2)
               DISPLAY "C(2,1)" C(2,1)
               DISPLAY "C(2,2)" C(2,2)
               DISPLAY "C(3,1)" C(3,1)
               DISPLAY "C(3,2)" C(3,2)
           STOP RUN.
      