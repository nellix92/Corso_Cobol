       IDENTIFICATION DIVISION.
       PROGRAM-ID. ADDFIELDDATA.
 
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
           01 WS-ID-CLIENTE PIC 9(1) VALUE 1.
           01 WS-NOME PIC X(10).
           01 WS-COGNOME PIC X(10).
           01 WS-DATA PIC X(20).
           01 WS-INPUT PIC X(2).
           01 WS-EOF PIC X.
           01 COUNTER PIC 9(2) VALUE ZERO.
           

       PROCEDURE DIVISION.
           MAIN.
           OPEN I-O CLIENTI-IDX
           PERFORM ADDFIELD.
           CLOSE CLIENTI-IDX.
   
               



           ADDFIELD.
           PERFORM UNTIL WS-EOF = 'Y'
              READ CLIENTI-IDX
               AT END MOVE 'Y' TO WS-EOF
                 NOT AT END 
                       
                       MOVE FUNCTION CURRENT-DATE to DATA-IDX 
                       REWRITE RECORD-CLIENTE-IDX
                       end-rewrite
           
              END-READ          
           END-PERFORM.
          

           

           