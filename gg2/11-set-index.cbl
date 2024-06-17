       IDENTIFICATION DIVISION.
       PROGRAM-ID. CONVERTITORE-C-F.
       AUTHOR. ROBERTO.
       DATE-WRITTEN. 12/06/2024.
 
       DATA DIVISION.
           WORKING-STORAGE SECTION.
           01 TABELLA VALUE  'abcdefghilmnopqrstuvz'. 
               05 A OCCURS 3 TIMES INDEXED BY I.
                   10 B OCCURS 2 TIMES INDEXED BY J.
                       15 C PIC X(3).
                 


       PROCEDURE DIVISION.
           MAIN.
               DISPLAY "TABELLA:".
               SET I TO 1
               SET J TO 1
               DISPLAY C(I,J)
               
               SET I J TO 2
               DISPLAY C(I,J)

               SET I J TO 1
               SET I J UP BY 1
               DISPLAY C(I,J)


               SET I J DOWN BY 1
               DISPLAY C(I,J)
               STOP RUN.


     
