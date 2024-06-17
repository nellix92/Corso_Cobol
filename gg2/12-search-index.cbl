       IDENTIFICATION DIVISION.
       PROGRAM-ID. CONVERTITORE-C-F.
       AUTHOR. ROBERTO.
       DATE-WRITTEN. 12/06/2024.
 
       DATA DIVISION.
           WORKING-STORAGE SECTION.
           01 TABELLA VALUE  'abcdefghilmnopqrstuvz'. 
               05 A  PIC X(1) OCCURS 21 TIMES INDEXED BY I.
           01 SEARCH_LET PIC A(1)

                 


       PROCEDURE DIVISION.
           MAIN.
           MOVE "c" TO SEARCH_LET.
           DISPLAY "TABELLA:".
           SET I TO 1
           SEARCH A
             AT END DISPLAY "VALORE DI "SEARCH_LET" NON TROVATO"
             WHEN A(I) = SEARCH_LET
             DISPLAY "VALORE DI "SEARCH_LET" TROVATO"
           END-SEARCH.
           STOP RUN.


     
