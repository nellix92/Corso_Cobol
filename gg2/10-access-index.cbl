       IDENTIFICATION DIVISION.
       PROGRAM-ID. CONVERTITORE-C-F.
       AUTHOR. ROBERTO.
       DATE-WRITTEN. 12/06/2024.
 
       DATA DIVISION.
           WORKING-STORAGE SECTION.
           01 TABELLA VALUE  'abcdefghilmnopqrstuvz'. 
               05 A OCCURS 3 TIMES INDEXED BY I.
                   10 B OCCURS 2 TIMES INDEXED BY J.
                       15 C PIC X(3)
                 


       PROCEDURE DIVISION.
           MAIN.
               DISPLAY "TABELLA:".
               PERFORM PARAGRAFO-A VARYING I FROM 1 BY 1 UNTIL I > 3
               STOP RUN.


           PARAGRAFO-A.
           PERFORM PARAGRAFO-B VARYING J FROM 1 BY 1 UNTIL J>2.

           PARAGRAFO-B.
           DISPLAY C(I,J)
