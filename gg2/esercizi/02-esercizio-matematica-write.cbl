       IDENTIFICATION DIVISION.
       PROGRAM-ID. PERFORM.
       AUTHOR. NELLO.
       DATE-WRITTEN. 10/06/2024.

       ENVIRONMENT DIVISION.
        INPUT-OUTPUT SECTION.
        FILE-CONTROL.
          SELECT OPERAZIONE ASSIGN TO "matematica.dax"
           ORGANIZATION IS LINE SEQUENTIAL.
       DATA DIVISION.
           FILE SECTION.
           FD OPERAZIONE.
           01 OPERAZIONE-RECORD.
               05 TYPEOPERATION PIC X(6).
               05 RISULTATO PIC S9(3).
           WORKING-STORAGE SECTION.
           01 WS-NUMBER        PIC S9(3) VALUE 0.
           01 WS-MAX           PIC S9(3) VALUE 0.
           01 WS-MIN           PIC S9(3) VALUE 0.
           01 WS-FIRST-NUMBER  PIC X VALUE 'Y'.
           01 WS-SUM           PIC S9(3) VALUE 0.
           01 WS-COUNT         PIC 9(3)  VALUE 0.
           01 WS-AVERAGE       PIC S9(3) VALUE 0.
           01 WS-END-OF-INPUT  PIC X     VALUE 'N'.

       PROCEDURE DIVISION.
           MAIN.
           OPEN OUTPUT OPERAZIONE.
           PERFORM UNTIL WS-END-OF-INPUT = 'Y'
               DISPLAY "Inserisci un numero (0 per terminare):"
               ACCEPT WS-NUMBER

               IF WS-NUMBER = 0
                   MOVE 'Y' TO WS-END-OF-INPUT
               ELSE
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
                   ADD 1 TO WS-COUNT
               END-IF
           END-PERFORM

           IF WS-COUNT > 0
               COMPUTE WS-AVERAGE = WS-SUM / WS-COUNT
               MOVE "SUM: " TO TYPEOPERATION. 
               MOVE WS-SUM TO RISULTATO. 
               WRITE OPERAZIONE-RECORD
               END-WRITE.
               MOVE "MAX: " TO TYPEOPERATION.
               MOVE WS-MAX TO RISULTATO. 
               WRITE OPERAZIONE-RECORD
               END-WRITE.
               MOVE "MIN: " TO TYPEOPERATION.
               MOVE WS-MIN TO RISULTATO. 
               WRITE OPERAZIONE-RECORD
               END-WRITE.
               MOVE "MEAN: " TO TYPEOPERATION.
               MOVE WS-AVERAGE TO RISULTATO. 
               WRITE OPERAZIONE-RECORD
               END-WRITE.
           CLOSE OPERAZIONE.
           STOP RUN.