       IDENTIFICATION DIVISION.
       PROGRAM-ID. Main.

       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
      *Assegnazione di un file logico a un file fisico sul disco.
           SELECT FILE-VENDITE ASSIGN TO "Vendite-mese.trimestre.txt"
           ORGANIZATION IS LINE SEQUENTIAL.

       DATA DIVISION.
       FILE SECTION.
      *struttura di un file di vendite, in modo che il programma COBOL 
      *sappia come leggere e scrivere i dati in questo file.
       FD FILE-VENDITE.
       01 VENDITE.
      * Flag per il controllo della fine del file.
           05 END-OF-FILE PIC X VALUE 'N'.
           05 REGIONE-NUM PIC 99.
           05 TRIMESTRE PIC 99.
           05 MESE PIC 99.
           05 IMPORTO PIC 9(5).

       WORKING-STORAGE SECTION.
       01 SCELTA PIC 9.
       01 LINEA-REPORT.
           05 FILLER PIC X(50) VALUE ALL "-".

       PROCEDURE DIVISION.
       MAIN.
      *Ciclo principale del programma fino a quando l'utente sceglie di uscire.
           PERFORM UNTIL SCELTA = 4
               PERFORM GET-DISPLAY
               EVALUATE SCELTA
                   WHEN 1
      *Chiamo le subroutine
                       CALL 'ResetVenditeMese'
                       CALL 'GetVenditeMese'
                       CALL 'GetRecordMese'
                   WHEN 2
                       CALL 'ResetVenditeTrimestre'  
                       CALL 'GetVenditeTrimestre'
                       CALL 'GetRecordTrimestre'
                   WHEN 3
                       CALL 'ResetVenditeRegione'
                       CALL 'GetVenditeRegione'
                       CALL 'GetRecordRegione'
                   WHEN 4
                       DISPLAY "Esci dal programma"
                   WHEN OTHER
                       DISPLAY "Invalid number"
               END-EVALUATE
           END-PERFORM
           GOBACK.

       GET-DISPLAY.
           DISPLAY LINEA-REPORT.
           DISPLAY "Scegli quale report visualizzare: ".   *> Mostra il messaggio di selezione del report.
           DISPLAY "1 - Vendite totali per mese".   *> Opzione
           DISPLAY "2 - Vendite trimestrali".
           DISPLAY "3 - Vendite regionali per trimestre".
           DISPLAY "4 - Esci".
           DISPLAY LINEA-REPORT.   *> Mostra una linea di separazione.
           ACCEPT SCELTA.   *> Input della scelta dell'utente.
