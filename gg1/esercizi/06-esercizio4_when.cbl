       IDENTIFICATION DIVISION.
       PROGRAM-ID. HELLOWORLD.
       AUTHOR. NELLO.
       DATE-WRITTEN. 10/06/2024.
       DATA DIVISION.
           WORKING-STORAGE SECTION.
           01 PREZZO PIC 9(6) VALUE 0.
           01 SCONTO PIC 9(6) VALUE 0.
           01 PREZZO_SCONTATO PIC 9(6) VALUE 0.

       PROCEDURE DIVISION.
           DISPLAY "INSERISCI IL PREZZO DEL PRODOTTO: ".
           ACCEPT PREZZO.

           EVALUATE TRUE
               WHEN PREZZO > 100
                   COMPUTE SCONTO = PREZZO * 0.20
               WHEN PREZZO >= 50 AND PREZZO <= 99
                   COMPUTE SCONTO = PREZZO * 0.10
               WHEN OTHER
                   COMPUTE SCONTO = PREZZO * 0.05
           END-EVALUATE

           COMPUTE PREZZO_SCONTATO = PREZZO - SCONTO.
           DISPLAY "IL PREZZO SCONTATO E': " PREZZO_SCONTATO.
       STOP RUN.
