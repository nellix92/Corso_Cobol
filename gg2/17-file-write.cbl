       IDENTIFICATION DIVISION.
       PROGRAM-ID. LETTURAFILE.
 
       ENVIRONMENT DIVISION.
        INPUT-OUTPUT SECTION.
        FILE-CONTROL.
          SELECT CLIENTI ASSIGN TO "clienti.dax"
           ORGANIZATION IS LINE SEQUENTIAL.

       DATA DIVISION.
           FILE SECTION.
           FD CLIENTI.
           01 RECORD-CLIENTE.
              05 NOME PIC X(10).
              05 COGNOME PIC X(10).
           WORKING-STORAGE SECTION.
             01 WS-RECORD-CLIENTE.
              05 WS-NOME PIC X(10).
              05 WS-COGNOME PIC X(10).
             01 WS-EOF PIC X.

       PROCEDURE DIVISION.
           MAIN.
           OPEN OUTPUT CLIENTI.
           PERFORM UNTIL RECORD-CLIENTE = SPACES
              DISPLAY "INSERISCI IL NOME E COGNOME DEL CLIENTE"
              ACCEPT RECORD-CLIENTE
              WRITE RECORD-CLIENTE
           END-PERFORM.
           CLOSE CLIENTI.
           OPEN EXTEND CLIENTI.
           MOVE "ciccio" TO NOME.
           MOVE "cicci" TO COGNOME.
           WRITE RECORD-CLIENTE
           END-WRITE.
           CLOSE CLIENTI.
           GOBACK.
      