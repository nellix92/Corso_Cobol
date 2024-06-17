       IDENTIFICATION DIVISION.
       PROGRAM-ID. LETTURAFILE.
 
       ENVIRONMENT DIVISION.
        INPUT-OUTPUT SECTION.
        FILE-CONTROL.
       
          SELECT CLIENTI-IDX ASSIGN TO "clienti.idx"
           ORGANIZATION IS INDEXED
           ACCESS IS RANDOM
           RECORD KEY IS ID-CLIENTE-IDX.
       DATA DIVISION.
           FILE SECTION.
           FD CLIENTI-IDX.
           01 RECORD-CLIENTE-IDX.
              05 ID-CLIENTE-IDX PIC 9(1).
              05 NOME-IDX PIC X(10).
              05 COGNOME-IDX PIC X(10).
           WORKING-STORAGE SECTION.
             01 WS-EOF PIC X.

       PROCEDURE DIVISION.
           MAIN.
           OPEN I-O CLIENTI-IDX.
           MOVE 1 to ID-CLIENTE-IDX.
           MOVE "nuovo-n" to NOME-IDX.
           MOVE "nuovo-c" to COGNOME-IDX. 
           DISPLAY RECORD-CLIENTE-IDX.
           DELETE CLIENTI-IDX RECORD
              INVALID KEY DISPLAY "Chiave non esiste"
              NOT INVALID KEY DISPLAY "Record cancellato"
           END-DELETE
           CLOSE CLIENTI-IDX.
           GOBACK.
      