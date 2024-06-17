       IDENTIFICATION DIVISION.
       PROGRAM-ID. HELLOWORLD.
       AUTHOR. ROBERTO.
       DATE-WRITTEN. 12/06/2024.

       DATA DIVISION.
           WORKING-STORAGE SECTION.
           01 NUMERO PIC 99 VALUE ZERO.
           01 TIPO PIC X(20).
         
         
       PROCEDURE DIVISION.
           A000-FIRST-PARA.
           DISPLAY "INSERISCI UN NUMERO"
           ACCEPT NUMERO
           EVALUATE NUMERO
            WHEN 1 MOVE "Numero 1" to TIPO
            WHEN 2 MOVE "Numero 2" to TIPO
            WHEN 3 MOVE "Numero 3" to TIPO
            WHEN 4 MOVE "Numero 4" to TIPO
            WHEN 5 MOVE "Numero 5" to TIPO
            WHEN 6 MOVE "Numero 6" to TIPO
            WHEN OTHER MOVE "Numero Sconosciuto" to TIPO
           END-EVALUATE
           DISPLAY "Hai inserito:"TIPO
           GOBACK.
      