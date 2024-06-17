       IDENTIFICATION DIVISION.
       PROGRAM-ID. HELLOWORLD.
       AUTHOR. ROBERTO.
       DATE-WRITTEN. 12/06/2024.

       DATA DIVISION.
           WORKING-STORAGE SECTION.
           01 COMMISSIONI PIC 999 VALUE ZERO.
               88 SOTTO-QUOTA VALUE 0 THRU 10.
               88 QUOTA VALUE 11 THRU 30.
               88 SOPRA-QUOTA VALUE 31 THRU 99.

         
       PROCEDURE DIVISION.
           A000-FIRST-PARA.
           DISPLAY "INSERISCI UN NUMERO"
           ACCEPT COMMISSIONI
           EVALUATE TRUE
           WHEN SOTTO-QUOTA
            DISPLAY "LE commisisoni sono al 10%"
           WHEN QUOTA
            DISPLAY "LE commisisoni sono tra l'11 ed il 30 %"
           WHEN SOPRA-QUOTA
            DISPLAY "LE commisisoni sono tra il 31% ed il 99%"
           WHEN other
            DISPLAY "LE Commisisone sono troppe"
           END-EVALUATE
           GOBACK.
      