       IDENTIFICATION DIVISION.
       PROGRAM-ID. GetRecordTrimestre.

       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
           FILE-CONTROL.
               SELECT FILE-TRIMESTRE ASSIGN TO "Vendite-trimestre.txt"
               ORGANIZATION IS LINE SEQUENTIAL.

       DATA DIVISION.
           FILE SECTION.
           FD FILE-TRIMESTRE.
           01 RECORD-TRIMESTRE.
               05 RECORD-TRIMESTRE-NUMERO PIC X(10).
               05 RECORD-TRIMESTRE-SOMMA PIC X(10).

           WORKING-STORAGE SECTION.
           01 VENDITE-TRIMESTRE.
               05 TRIMESTRE-SOMME OCCURS 4 TIMES PIC 9(5) VALUE 0.
           01 INDICE-TRIMESTRE PIC 99.

       LINKAGE SECTION.
           01 LNK-SCELTA PIC 9.

       PROCEDURE DIVISION USING LNK-SCELTA.
           OPEN OUTPUT FILE-TRIMESTRE
           PERFORM VARYING INDICE-TRIMESTRE FROM 1 BY 1
               UNTIL INDICE-TRIMESTRE > 4
               MOVE INDICE-TRIMESTRE TO RECORD-TRIMESTRE-NUMERO
               MOVE TRIMESTRE-SOMME(INDICE-TRIMESTRE) TO RECORD-TRIMESTRE-SOMMA
               WRITE RECORD-TRIMESTRE
           END-PERFORM
           CLOSE FILE-TRIMESTRE
            EXIT PROGRAM.