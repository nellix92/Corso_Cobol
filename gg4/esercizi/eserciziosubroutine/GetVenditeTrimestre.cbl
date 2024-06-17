       IDENTIFICATION DIVISION.
       PROGRAM-ID. GetVenditeTrimestre.

       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
           FILE-CONTROL.
               SELECT FILE-VENDITE ASSIGN TO "Vendite-mese.trimestre.txt"
       ORGANIZATION IS LINE SEQUENTIAL.

       DATA DIVISION.
           FILE SECTION.
           FD FILE-VENDITE.
           01 VENDITE.
               05 REGIONE-NUM PIC 99.
               05 TRIMESTRE PIC 99.
               05 MESE PIC 99.
               05 IMPORTO PIC 9(5).

           WORKING-STORAGE SECTION.
           01 LETTURA-FILE PIC X.
           01 TABELLA-VENDITE.
               05 TAB-REGIONE-NUM PIC 99.
               05 TAB-TRIMESTRE PIC 99.
               05 TAB-MESE PIC 99.
               05 TAB-IMPORTO PIC 9(5).
           01 VENDITE-TRIMESTRE.
               05 TRIMESTRE-SOMME OCCURS 4 TIMES PIC 9(5) VALUE 0.

       LINKAGE SECTION.
           01 LNK-SCELTA PIC 9.

       PROCEDURE DIVISION USING LNK-SCELTA.
           OPEN INPUT FILE-VENDITE
           MOVE 'N' TO LETTURA-FILE
           PERFORM UNTIL LETTURA-FILE = 'Y'
               READ FILE-VENDITE INTO TABELLA-VENDITE
                   AT END
                       MOVE 'Y' TO LETTURA-FILE
                   NOT AT END
                       ADD TAB-IMPORTO TO TRIMESTRE-SOMME(TAB-TRIMESTRE)
               END-READ
           END-PERFORM
           CLOSE FILE-VENDITE
            EXIT PROGRAM.