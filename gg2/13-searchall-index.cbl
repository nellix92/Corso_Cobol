       IDENTIFICATION DIVISION.
       PROGRAM-ID. CONVERTITORE-C-F.
       AUTHOR. ROBERTO.
       DATE-WRITTEN. 12/06/2024.
 
       DATA DIVISION.
           WORKING-STORAGE SECTION.
           01 TABELLA VALUE  '10abc11def12ghi13lmn14opq15rst16uvz'. 
               05 A OCCURS 10 TIMES ASCENDING KEY IS NUM INDEXED BY I.
               10 NUM PIC 9(2).
               10 NOME PIC A(3).

                 


       PROCEDURE DIVISION.
           MAIN.
           DISPLAY "TABELLA:"
           SEARCH ALL A
             AT END DISPLAY "VALORE DI NON TROVATO"
             WHEN NUM(I) = 13
             DISPLAY "VALORE DI TROVATO"
             DISPLAY NUM(I)
             DISPLAY NOME(I)
           END-SEARCH.
           STOP RUN.


     
