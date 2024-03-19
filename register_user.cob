      ******************************************************************         
      * Handles the registration of users in a terminal prompt         *
      ******************************************************************

       IDENTIFICATION DIVISION.
       PROGRAM-ID. register-user.

       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
           SELECT users-file ASSIGN TO "users.dat"
               ORGANIZATION IS INDEXED
               ACCESS MODE IS RANDOM
               RECORD KEY IS phone-number
               FILE STATUS IS file-status.

       DATA DIVISION.
       FILE SECTION.
       FD users-file.
       COPY "user.cpy".

       WORKING-STORAGE SECTION.
       77 file-status            PIC XX VALUE SPACES.
       77 REDEFINES file-status  PIC XX.
           88 file-access-ok     VALUE "00".
       01 yn-reply               PIC X.
           88 y-reply            VALUES 'Y', 'y'.
           88 n-reply            VALUES 'N', 'n'.

       SCREEN SECTION.
       01 form BLANK SCREEN.
           03           VALUE "FIRST NAME:".
           03 COL  + 2,    PIC A(20) TO first-name.
           03 LINE + 1, VALUE "FAMILY NAME:".
           03 COL  + 2,    PIC A(20) TO family-name.
           03 LINE + 1, VALUE "ADDRESS:".
           03 LINE + 1,    PIC X(20) TO line-1 OF the-address.
           03 LINE + 1,    PIC X(20) TO line-2 OF the-address.
           03 LINE + 1,    PIC X(20) TO line-3 OF the-address.
           03 LINE + 1, VALUE "EMAIL:".
           03 COL  + 2,    PIC X(30) TO email-address.
           03 LINE + 1, VALUE "PHONE:".
           03 COL  + 2,    PIC 9(10) TO phone-number.

       PROCEDURE DIVISION.
       form-beginning section.
           DISPLAY ' ' WITH BLANK SCREEN.
           DISPLAY form.
           ACCEPT form.
       
       ask-for-validation.
           DISPLAY "Validate? (y/n)" AT 0101 WITH BLANK SCREEN.
           ACCEPT yn-reply AT 0201.
           IF n-reply THEN PERFORM form-beginning.
           DISPLAY "Record written." AT 0301.
       
       register-in-file.
           OPEN I-O users-file
           WRITE user
           CLOSE users-file.

       end-of-program.
           STOP RUN.
