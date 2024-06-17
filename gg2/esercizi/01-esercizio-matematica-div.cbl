       IDENTIFICATION DIVISION.
       PROGRAM-ID. PERFORM.
       AUTHOR. NELLO.
       DATE-WRITTEN. 10/06/2024.
       DATA DIVISION.
           WORKING-STORAGE SECTION.
           01 WS-NUMBER        PIC S9(9) VALUE 0.
           01 WS-MAX           PIC S9(9) VALUE 0.
           01 WS-MIN           PIC S9(9) VALUE 0.
           01 WS-FIRST-NUMBER  PIC X VALUE 'Y'.
           01 WS-SUM           PIC S9(9) VALUE 0.
           01 WS-COUNT         PIC 9(9)  VALUE 0.
           01 WS-AVERAGE       PIC S9(9)V9(2) VALUE 0.
           01 WS-END-OF-INPUT  PIC X     VALUE 'N'.

              PROCEDURE DIVISION.
       
       MAIN-PROCEDURE.
           PERFORM INITIALIZE-VARIABLES
           PERFORM READ-NUMBERS-UNTIL-ZERO
           PERFORM DISPLAY-RESULTS
           STOP RUN.

       INITIALIZE-VARIABLES.
           MOVE 0 TO WS-NUMBER
           MOVE 'Y' TO WS-FIRST-NUMBER
           MOVE 0 TO WS-SUM
           MOVE 0 TO WS-COUNT
           MOVE 'N' TO WS-END-OF-INPUT
           MOVE 0 TO WS-MAX
           MOVE 0 TO WS-MIN.

       READ-NUMBERS-UNTIL-ZERO.
           PERFORM UNTIL WS-END-OF-INPUT = 'Y'
               DISPLAY "Inserisci un numero (0 per terminare):"
               ACCEPT WS-NUMBER

               IF WS-NUMBER = 0
                   MOVE 'Y' TO WS-END-OF-INPUT
               ELSE
                   PERFORM PROCESS-NUMBER
               END-IF
           END-PERFORM.

       PROCESS-NUMBER.
           IF WS-FIRST-NUMBER = 'Y'
               MOVE WS-NUMBER TO WS-MAX
               MOVE WS-NUMBER TO WS-MIN
               MOVE 'N' TO WS-FIRST-NUMBER
           ELSE
               IF WS-NUMBER > WS-MAX
                   MOVE WS-NUMBER TO WS-MAX
               END-IF

               IF WS-NUMBER < WS-MIN
                   MOVE WS-NUMBER TO WS-MIN
               END-IF
           END-IF

           ADD WS-NUMBER TO WS-SUM
           ADD 1 TO WS-COUNT.

       DISPLAY-RESULTS.
           IF WS-COUNT > 0
               COMPUTE WS-AVERAGE = WS-SUM / WS-COUNT
               DISPLAY "Valore massimo inserito: " WS-MAX
               DISPLAY "Valore minimo inserito: " WS-MIN
               DISPLAY "Somma dei valori inseriti: " WS-SUM
               DISPLAY "Media dei valori inseriti: " WS-AVERAGE
           ELSE
               DISPLAY "Nessun valore valido inserito."
           END-IF.