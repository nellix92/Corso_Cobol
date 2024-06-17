       IDENTIFICATION DIVISION.
       PROGRAM-ID. HELLOWORLD.
       AUTHOR. ROBERTO.
       DATE-WRITTEN. 12/06/2024.

       DATA DIVISION.
           WORKING-STORAGE SECTION.
           01 NUMERO PIC 99 VALUE ZERO.
           01 CLIENTE-VIP PIC X.
           01 UNITA PIC 9(3).
           01 SCONTO PIC 9(2)v9(2).

            

         
       PROCEDURE DIVISION.
           A000-FIRST-PARA.
           DISPLAY "INSERISCI UN NUMERO DEL VENDUTO"
           ACCEPT UNITA
           DISPLAY "E'  UN CLIENTE VIP(S/N)?"
           ACCEPT CLIENTE-VIP
           EVALUATE UNITA ALSO CLIENTE-VIP
           WHEN 1 THRU 20 ALSO "S"
            MOVE .20 TO SCONTO
           WHEN 21 THRU 50 ALSO "S"
            MOVE .25 TO SCONTO
           WHEN  GREATER THAN 50 ALSO "S"
            MOVE .30 TO SCONTO
           END-EVALUATE
           DISPLAY "Lo Sconto è "SCONTO
           GOBACK.
      