       IDENTIFICATION DIVISION.
       PROGRAM-ID. ReportMenu.

       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
           SELECT Vendite ASSIGN TO 'Vendite-mese.trimestre.txt'
           ORGANIZATION IS LINE SEQUENTIAL.

       DATA DIVISION.
       FILE SECTION.
       FD  Vendite.
       01  SalesRecord.
           05  REGION-NUMBER          PIC 99.
           05  QUARTER-NUMBER         PIC 99.
           05  MONTH-NUMBER           PIC 99.
           05  SALES-AMOUNT           PIC 9(5).

       WORKING-STORAGE SECTION.
       01  WS-USER-CHOICE             PIC 9.
       01  WS-REGION-CHOICE           PIC 99.
       01  WS-QUARTER-CHOICE          PIC 99.
       01  WS-EOF                     PIC X VALUE 'N'.
           88  EOF-YES                VALUE 'Y'.
           88  EOF-NO                 VALUE 'N'.
       01  WS-MONTH-TOTALS.
           05  MONTH-AMOUNT OCCURS 12 TIMES PIC 9(8) VALUE 0.
       01  WS-QUARTER-TOTALS.
           05  QUARTER-AMOUNT OCCURS 4 TIMES PIC 9(8) VALUE 0.
       01  WS-REGIONAL-QUARTER-AMOUNTS.
           05  REGION-AMOUNTS OCCURS 4 TIMES PIC 9(8) VALUE 0.
           05  QUARTER-AMOUNTS OCCURS 4 TIMES PIC 9(8) VALUE 0.
       01  WS-REGION-NUMBER           PIC 99.
       01  WS-QUARTER-NUMBER          PIC 99.
       01  WS-MONTH-NUMBER            PIC 99.
       01  WS-SALES-AMOUNT            PIC 9(5).

       PROCEDURE DIVISION.
       MAIN-PARA.
           PERFORM UNTIL WS-USER-CHOICE = 4
               PERFORM DISPLAY-MENU
               ACCEPT WS-USER-CHOICE
               EVALUATE WS-USER-CHOICE
                   WHEN 1
                       PERFORM VENDITE-TOTALI-MENSILI
                   WHEN 2
                       PERFORM VENDITE-TRIMESTRALI
                   WHEN 3
                       PERFORM SCEGLI-REGIONE-TRIMESTRE
                       PERFORM VENDITE-REGIONALI-TRIMESTRALI
                   WHEN 4
                       PERFORM FINE
                   WHEN OTHER
                       DISPLAY 'Scelta non valida. Riprova.'
               END-EVALUATE
           END-PERFORM
           STOP RUN.

       DISPLAY-MENU.
           DISPLAY 'Scegli il tipo di report da visualizzare:'
           DISPLAY '1) Vendite Totali (di tutte le regioni) per mese'
           DISPLAY '2) Vendite Trimestrali (di tutte le regioni)'
           DISPLAY '3) Vendite Regionali -> Trimestrali'
           DISPLAY '4) Esci'.

       SCEGLI-REGIONE-TRIMESTRE.
           DISPLAY 'Inserisci il numero della regione (01-04):'
           ACCEPT WS-REGION-CHOICE
           DISPLAY 'Inserisci il numero del trimestre (01-04):'
           ACCEPT WS-QUARTER-CHOICE.

       VENDITE-TOTALI-MENSILI.
           PERFORM INIT-MONTH-TOTALS
           MOVE 'N' TO WS-EOF
           OPEN INPUT Vendite
           PERFORM UNTIL EOF-YES
               READ Vendite INTO SalesRecord
                   AT END SET EOF-YES TO TRUE
               NOT AT END
                   MOVE MONTH-NUMBER TO WS-MONTH-NUMBER
                   ADD SALES-AMOUNT TO MONTH-AMOUNT(WS-MONTH-NUMBER)
               END-READ
           END-PERFORM
           CLOSE Vendite
           DISPLAY 'Vendite Totali per Mese:'
           PERFORM DISPLAY-MONTH-TOTALS.

       VENDITE-TRIMESTRALI.
           PERFORM INIT-QUARTER-TOTALS
           MOVE 'N' TO WS-EOF
           OPEN INPUT Vendite
           PERFORM UNTIL EOF-YES
               READ Vendite INTO SalesRecord
                   AT END SET EOF-YES TO TRUE
               NOT AT END
                   MOVE QUARTER-NUMBER TO WS-QUARTER-NUMBER
                   ADD SALES-AMOUNT TO QUARTER-AMOUNT(WS-QUARTER-NUMBER)
               END-READ
           END-PERFORM
           CLOSE Vendite
           DISPLAY 'Vendite Trimestrali:'
           PERFORM DISPLAY-QUARTER-TOTALS.

       VENDITE-REGIONALI-TRIMESTRALI.
           PERFORM INIT-REGIONAL-QUARTER-TOTALS
           MOVE 'N' TO WS-EOF
           OPEN INPUT Vendite
           PERFORM UNTIL EOF-YES
               READ Vendite INTO SalesRecord
                   AT END SET EOF-YES TO TRUE
               NOT AT END
                   MOVE REGION-NUMBER TO WS-REGION-NUMBER
                   MOVE QUARTER-NUMBER TO WS-QUARTER-NUMBER
                   IF WS-REGION-NUMBER = WS-REGION-CHOICE AND
                      WS-QUARTER-NUMBER = WS-QUARTER-CHOICE                     
                       ADD SALES-AMOUNT TO QUARTER-AMOUNTS(WS-QUARTER-NUMBER)
                   END-IF
               END-READ
           END-PERFORM
           CLOSE Vendite
           DISPLAY 'Vendite Regionali Trimestrali:'
           DISPLAY 'Regione ' WS-REGION-CHOICE ' Trimestre ' WS-QUARTER-CHOICE ': ' 
               REGION-AMOUNTS(WS-REGION-CHOICE)
               QUARTER-AMOUNTS(WS-QUARTER-CHOICE).

       INIT-MONTH-TOTALS.
           PERFORM VARYING WS-MONTH-NUMBER FROM 1 BY 1 UNTIL WS-MONTH-NUMBER > 12
               MOVE 0 TO MONTH-AMOUNT(WS-MONTH-NUMBER)
           END-PERFORM.

       DISPLAY-MONTH-TOTALS.
           PERFORM VARYING WS-MONTH-NUMBER FROM 1 BY 1 UNTIL WS-MONTH-NUMBER > 12
               DISPLAY 'Mese ' WS-MONTH-NUMBER ': ' MONTH-AMOUNT(WS-MONTH-NUMBER)
           END-PERFORM.

       INIT-QUARTER-TOTALS.
           PERFORM VARYING WS-QUARTER-NUMBER FROM 1 BY 1 UNTIL WS-QUARTER-NUMBER > 4
               MOVE 0 TO QUARTER-AMOUNT(WS-QUARTER-NUMBER)
           END-PERFORM.

       DISPLAY-QUARTER-TOTALS.
           PERFORM VARYING WS-QUARTER-NUMBER FROM 1 BY 1 UNTIL WS-QUARTER-NUMBER > 4
               DISPLAY 'Trimestre ' WS-QUARTER-NUMBER ': ' QUARTER-AMOUNT(WS-QUARTER-NUMBER)
           END-PERFORM.

       INIT-REGIONAL-QUARTER-TOTALS.
           PERFORM VARYING WS-REGION-NUMBER FROM 1 BY 1 UNTIL WS-REGION-NUMBER > 4
               MOVE 0 TO REGION-AMOUNTS(WS-REGION-NUMBER)
               PERFORM VARYING WS-QUARTER-NUMBER FROM 1 BY 1 UNTIL WS-QUARTER-NUMBER > 4
                   MOVE 0 TO QUARTER-AMOUNTS(WS-QUARTER-NUMBER)
               END-PERFORM
           END-PERFORM.

       FINE.
           DISPLAY 'Uscita dal programma.'
           STOP RUN.
