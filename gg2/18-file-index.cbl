       IDENTIFICATION DIVISION.
       PROGRAM-ID. LETTURAFILE.
 
       ENVIRONMENT DIVISION.
        INPUT-OUTPUT SECTION.
        FILE-CONTROL.
          SELECT CLIENTI ASSIGN TO "clienti-chiave.dat"
           ORGANIZATION IS LINE SEQUENTIAL.
          SELECT CLIENTI-IDX ASSIGN TO "clienti.idx"
           ORGANIZATION IS INDEXED
           ACCESS IS SEQUENTIAL
           RECORD KEY IS ID-CLIENTE-IDX.
       DATA DIVISION.
           FILE SECTION.
           FD CLIENTI.
           01 RECORD-CLIENTE.
              05 ID-CLIENTE PIC 9(1).
              05 NOME PIC X(10).
              05 COGNOME PIC X(10).
           FD CLIENTI-IDX.
           01 RECORD-CLIENTE-IDX.
              05 ID-CLIENTE-IDX PIC 9(1).
              05 NOME-IDX PIC X(10).
              05 COGNOME-IDX PIC X(10).
           WORKING-STORAGE SECTION.
             01 WS-EOF PIC X.

       PROCEDURE DIVISION.
           MAIN.
           OPEN INPUT CLIENTI
           OPEN OUTPUT CLIENTI-IDX
           
           PERFORM UNTIL WS-EOF = 'Y'
              READ CLIENTI 
               AT END MOVE 'Y' TO WS-EOF
                 NOT AT END 
                       MOVE RECORD-CLIENTE TO RECORD-CLIENTE-IDX
                       WRITE RECORD-CLIENTE-IDX
                       INVALID KEY DISPLAY 'Invalid record' 
                       END-WRITE
              END-READ
           END-PERFORM.
           CLOSE CLIENTI.
           CLOSE CLIENTI-IDX.
           GOBACK.
      