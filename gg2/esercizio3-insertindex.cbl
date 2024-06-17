       IDENTIFICATION DIVISION.
       PROGRAM-ID. SCRITTURAFILE.
 
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
           WORKING-STORAGE SECTION.
           01 WS-ID-CLIENTE PIC 9(1) VALUE 1.
           01 WS-NOME PIC X(10).
           01 WS-COGNOME PIC X(10).
           01 WS-INPUT PIC X(2).
           01 WS-EOF PIC X.
           

       PROCEDURE DIVISION.
           MAIN.
           OPEN OUTPUT CLIENTI-IDX

           PERFORM INSERTNAME UNTIL WS-INPUT = 'n'.
           CLOSE CLIENTI-IDX.
           GOBACK.


           
           INSERTNAME.
        
           DISPLAY "INSERISCI NOME: "WITH NO ADVANCING.
           ACCEPT WS-NOME.
           DISPLAY "INSERISCI COGNOME: "WITH NO ADVANCING.
           ACCEPT WS-COGNOME.
           DISPLAY "VUI AGGIUNGERNE UN ALTRO?(y/n): "WITH NO ADVANCING.
           ACCEPT WS-INPUT.

           MOVE WS-ID-CLIENTE TO ID-CLIENTE-IDX.
           MOVE WS-NOME TO NOME-IDX.
           MOVE WS-COGNOME TO COGNOME-IDX.
           ADD 1 TO WS-ID-CLIENTE.
           WRITE RECORD-CLIENTE-IDX
           END-WRITE.
           

           

           
      