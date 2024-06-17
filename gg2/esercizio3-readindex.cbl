       IDENTIFICATION DIVISION.
       PROGRAM-ID. LETTURAFILE.
 
       ENVIRONMENT DIVISION.
        INPUT-OUTPUT SECTION.
        FILE-CONTROL.
       
          SELECT CLIENTI-IDX ASSIGN TO "clienti.idx"
           ORGANIZATION IS INDEXED
           ACCESS IS SEQUENTIAL
           RECORD KEY IS ID-CLIENTE-IDX.
       DATA DIVISION.
           FILE SECTION.
           FD CLIENTI-IDX.
           01 RECORD-CLIENTE-IDX.
              05 ID-CLIENTE-IDX PIC 9(1).
              05 NOME-IDX PIC X(10).
              05 COGNOME-IDX PIC X(10).
              05 DATA-IDX PIC X(15).
           WORKING-STORAGE SECTION.
             01 WS-EOF PIC X.

       PROCEDURE DIVISION.
           MAIN.
           OPEN INPUT CLIENTI-IDX
    
           PERFORM UNTIL WS-EOF = 'Y'
              READ CLIENTI-IDX
               AT END MOVE 'Y' TO WS-EOF
                 NOT AT END 
                       DISPLAY ID-CLIENTE-IDX"***"NOME-IDX"***"COGNOME-IDX"***"DATA-IDX
              END-READ
           END-PERFORM.
           CLOSE CLIENTI-IDX.
           GOBACK.
      