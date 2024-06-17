       IDENTIFICATION DIVISION.
       PROGRAM-ID. LETTURAFILE.
       AUTHOR. ROBERTO.
       DATE-WRITTEN. 12/06/2024.

       ENVIRONMENT DIVISION.
         INPUT-OUTPUT SECTION.
         FILE-CONTROL.
          SELECT CLIENTI ASSIGN TO "clienti.dat"
           ORGANIZATION IS LINE SEQUENTIAL.

 
       DATA DIVISION.
           FILE SECTION.
           FD CLIENTI.
           01 RECORD-CLIENTE.
               05 NOME PIC X(20).
               05 COGNOME PIC X(20).   
           WORKING-STORAGE SECTION.
           01 WS-RECORD-CLIENTE.
               05 WS-NOME PIC X(20).
               05 WS-COGNOME PIC X(20).
           01 WS-EOF PIC X.
          
       PROCEDURE DIVISION.
           MAIN.
           OPEN INPUT CLIENTI.
           PERFORM UNTIL WS-EOF = 'Y'
               READ CLIENTI INTO WS-RECORD-CLIENTE
                AT END MOVE 'Y' TO WS-EOF
                 NOT AT END DISPLAY WS-RECORD-CLIENTE
               END-READ
           END-PERFORM.
           CLOSE CLIENTI. 

           GOBACK.

     
