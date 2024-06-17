       IDENTIFICATION DIVISION.
       PROGRAM-ID. HELLOWORLD.
       AUTHOR. NELLO.
       DATE-WRITTEN. 10/06/2024.
       DATA DIVISION.
           WORKING-STORAGE SECTION.
           01 A PIC 9(3) VALUE 0.              
           01 B PIC 9(3) VALUE 0.

       PROCEDURE DIVISION.
           A000-FIRST-PARA.
           DISPLAY"INSERISCI A: ".
           ACCEPT A.
           DISPLAY"INSERISCI B: ".
           ACCEPT B.
           IF A = B*B THEN
              DISPLAY "IL NUMERO "A " E' IL QUADRATO DI "B  
           ELSE
               DISPLAY "IL NUMERO "A " NON E' IL QUADRATO DI "B  
           END-IF
       STOP RUN. 