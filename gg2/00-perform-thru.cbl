       IDENTIFICATION DIVISION.
       PROGRAM-ID. PERFORM.
       AUTHOR. NELLO.
       DATE-WRITTEN. 10/06/2024.
       PROCEDURE DIVISION.
           PARAGRAFO-A.
           PERFORM DISPLAY "PARAGRAFO-A"
           END-PERFORM
           PERFORM PARAGRAFO-B THRU PARAGRAFO-D.
           
           PARAGRAFO-B.
           DISPLAY "PARAGRAFO-B",
           

           PARAGRAFO-C.
           DISPLAY "PARAGRAFO-C".
           STOP RUN.

           PARAGRAFO-D.
           DISPLAY "PARAGRAFO-D".

       STOP RUN.