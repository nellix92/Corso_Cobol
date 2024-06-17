       IDENTIFICATION DIVISION.
       PROGRAM-ID. CONVERTITORE-C-F.
       AUTHOR. ROBERTO.
       DATE-WRITTEN. 12/06/2024.
 
       DATA DIVISION.
           WORKING-STORAGE SECTION.
           01 SCELTA PIC X.
           01 TEMP-INGRESSO PIC 999v99.
           01 TEMP-USCITA PIC 999v99.
           01 ETICHETTA-INGRESSO PIC X(10).
           01 ETICHETTA-USCITA PIC X(10).

       PROCEDURE DIVISION.
           MAIN.
              PERFORM get-display. 
              STOP RUN.
           get-fahrenheit.
                   MOVE "Fahrenheit" TO ETICHETTA-USCITA
                   MOVE "Celsius" TO ETICHETTA-INGRESSO
                   DISPLAY "INSERISCI i gradi " ETICHETTA-INGRESSO 
                   ACCEPT TEMP-INGRESSO
                   PERFORM  calculate-fahrenheit.
                   DISPLAY "LA CONVERSIONE IN "ETICHETTA-USCITA " E' " TEMP-USCITA.
       
           get-celsius.
                    MOVE "Fahrenheit" TO ETICHETTA-INGRESSO
                    MOVE "Celsius" TO ETICHETTA-USCITA
                    DISPLAY "INSERISCI i gradi " ETICHETTA-INGRESSO 
                    ACCEPT TEMP-INGRESSO
                    PERFORM  calculate-celsius.
                    DISPLAY "LA CONVERSIONE IN "ETICHETTA-USCITA " E' " TEMP-USCITA.

           get-display.
               DISPLAY "INSERISCI F o C PER CONVERTIRE LA TEMPERATURA:".
               ACCEPT SCELTA
               IF SCELTA ="C" OR SCELTA="c" then
                  PERFORM get-celsius
               END-IF
               IF SCELTA ="F" OR SCELTA="f" then
                  PERFORM get-fahrenheit
               END-IF.

           calculate-fahrenheit.
            COMPUTE TEMP-USCITA = TEMP-INGRESSO * 9 / 5 + 32.
           calculate-celsius.
            COMPUTE TEMP-USCITA = TEMP-INGRESSO * 9 / 5 + 32.

       STOP RUN.
      