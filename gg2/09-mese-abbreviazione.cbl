       IDENTIFICATION DIVISION.
       PROGRAM-ID. CONVERTITORE-C-F.
       AUTHOR. ROBERTO.
       DATE-WRITTEN. 12/06/2024.
 
       DATA DIVISION.
           WORKING-STORAGE SECTION.
           01 MESE VALUE "GenFebMarAprMagGiuLugAgoSetOttNovDic". 
               05 MESE-GRUPPO OCCURS 12 TIMES.
                   10 MESE-ABBREV PIC X(3).
                 


       PROCEDURE DIVISION.
           MAIN.
               DISPLAY "TABELLA:".
               DISPLAY "MESE(1)" MESE-GRUPPO(1).
               DISPLAY "MESE(2)" MESE-GRUPPO(2).
               DISPLAY "MESE(3)" MESE-GRUPPO(3).
               DISPLAY "MESE(12)" MESE-GRUPPO(12).
           STOP RUN.
      