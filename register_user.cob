      ****************************************************************         
      * The purpose of this file is to handle the registration of    *
      * users in a terminal prompt.                                  *
      *                                                              *
      ****************************************************************
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
       01 user.
           05 full-name.
               10 first-name     PIC X(20).
               10 family-name    PIC X(20).
           05 the-address.
               10 line-1         PIC X(20).
               10 line-2         PIC X(20).
               10 line-3         PIC X(20).
           05 email-address      PIC X(30).
           05 phone-number       PIC 9(10). 
       
       WORKING-STORAGE SECTION.
       77 file-status            PIC XX VALUE SPACES.
       77 REDEFINES file-status  PIC XX.
           88 file-access-ok     VALUE "00".
       01 yn-reply               PIC X.
           88 y-reply            VALUES 'Y', 'y'.
           88 n-reply            VALUES 'N', 'n'.

       PROCEDURE DIVISION.
       form-beginning.
       ask-name.
           DISPLAY "first name" LINE 1 END-DISPLAY
           ACCEPT first-name LINE 2 END-ACCEPT

           DISPLAY "family name" LINE 1 COLUMN 21 END-DISPLAY
           ACCEPT family-name LINE 2 COLUMN 21 END-ACCEPT
           .
           
       ask-address.
           DISPLAY "address (3 lignes)" LINE 4 COLUMN 1 END-DISPLAY
           ACCEPT line-1 OF the-address LINE 5 COLUMN 1 END-ACCEPT
           ACCEPT line-2 OF the-address LINE 6 COLUMN 1 END-ACCEPT
           ACCEPT line-3 OF the-address LINE 7 COLUMN 1 END-ACCEPT
           .

       ask-email.
           DISPLAY "email" LINE 9 COLUMN 1 END-DISPLAY
           ACCEPT email-address LINE 10 COLUMN 1 END-ACCEPT
           .
           
       ask-phone.
           DISPLAY "phone number" LINE 12 COLUMN 1 END-DISPLAY
           ACCEPT phone-number LINE 13 COLUMN 1 END-ACCEPT
           .

       ask-for-validation.
           DISPLAY "Validate? (y/n)" LINE 15 END-DISPLAY
           ACCEPT yn-reply LINE 16 END-ACCEPT
           IF n-reply THEN PERFORM form-beginning.
           DISPLAY "Record written." LINE 17 END-DISPLAY.

       register-in-file.
           OPEN I-O users-file
           WRITE user
           CLOSE users-file
           .

       end-of-program.
           STOP RUN.

