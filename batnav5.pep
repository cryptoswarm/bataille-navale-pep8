         STRO welMsg, d; imprimer le msg de bienvenue 
         CHARO '\n', i ; imprimer saut de ligne
         
         

         LDX     0,i

         LDX     ix,d        ;load dans X < ix >
         STX     ix,d        ;store dans < ix > la valeur de X

iloop:   CPX     iSize,i
         ;BRGE    fini        ; fini pour arreter le jeu
         BRGE    msgDisp      ; Si le nombre de ligne est atteint
                              ;on affiche le msg demandant d'entrer les bateaux 
         LDX     0,i         ; Initilize jx to 0
         STX     jx,d        ; jx <- 0
         
jloop:   CPX     jSize,i
         BRGE    next_ix

         LDX     ix,d         
         LDA     matrix,x    ; rA <- address of ln1,ln2 or ln3
         ADDA    jx,d
         adda    1,i
         STA     ptr,d 
         
         CHARO    ptr,n      ;avant juste pour output des chiffres, DECO    ptr,n
         
         CHARO   ' ',i
                             ; incrementer jx
         ADDX    jx,d        ; rX = rX + jx
         LDX     jx,d        ; rX <- jx
         ADDX    2,i         ; rX = rX + 2
         STX     jx,d        ; jx <- rX
         BR      jloop 

next_ix: CHARO   '\n',i
         LDX     ix,d
         ADDX    2,i
         STX     ix,d
         BR      iloop

;-----------------------------------------------------------------

;--imprimer msg demandant d'entrer les specification des bateaux--

;-----------------------------------------------------------------

msgDisp:         STRO askMsg, d 

;Boucle1:         CPX  gap, d     ; while char == gap, on repete la lecture des chars 
               ;  BREQ Boucle1
               ;  BRGE erreur               ; qui decrivent les bateaux
;erreur:         ; STRO askMsg, d             

repeat:           CALL sizeBoat
                 STRO retMsgb, d
                 CHARO boatSize, d 
                 
                 CHARO '\n', i
 
                 CALL dirBoat
                 STRO retMsgD, d
                 CHARO boatdir, d 
                 CHARO '\n', i

                 CALL colBoat
                 STRO retMsgC, d
                 CHARO boatCol, d 
                 CHARO '\n', i
                 

                 CALL rowBoat 
                 STRO retMsg, d
                 CHARO nb, d
                 CHARO '\n', i

                 CALL checkgap
                 STRO retMsgG, d
                 CHARO gap, d
                 CHARO '\n', i
                 
                 ;CHARO gap, d
                 ;CHARO \n', i
                 ;CHARI gapp, d
                 ;LDA 0,i
                 ;LDBYTEA gap, d
                 ;CPA  ', d
                 ;BREQ repeat 
                 ;BR msgDisp











fini:    stop




;---------------------------------------------------------------

;Methode verifiant si la grandeur du bateau et correcte ou non 
;---------------------------------------------------------------
sizeBoat:            CHARI	boatSize, d
                     ;CHARI carBidon, d
                     LDA 0,i
                     LDBYTEA	boatSize, d
                     
                     
                     CPA	'p', i
                     ;CPA	lettreP, d
                     BREQ	eqCharP
                     ;RET0
                     CPA	'm', i
                     ;CPA	lettreM, d
                     BREQ	eqCharm 
                     ;RET0
                     CPA	'g', i
                     ;CPA	lettreG, d   
                     BREQ	eqCharg
                     ;RET0
                     STRO        notAccep, d
                     RET0
                     
;notlet:		STRO	nletmsg, d 
		;BR	out 
eqCharP:		STRO	msgCarP, d
RET0
eqCharm:              STRO	msgCarM, d
RET0 
eqCharg:              STRO	msgCarG, d
RET0
;out:		STOP

; Char to compare
lettreP:              .BYTE 'p'
lettreM:              .BYTE 'm'
lettreG:              .BYTE 'g'
;chr:		.BLOCK 1
boatSize:		.BYTE 1

; Is a letter message
msgCarP:		.ASCII "le char entre est p\n\x00"
msgCarM:              .ASCII "le char entre est m\n\x00"
msgCarG:              .ASCII "le char entre est g\n\x00"
; Is not a letter message
notAccep:	.ASCII "lettre ou char diffrent de ce qui est demandé\n\x00"
;---------------------------------------------------------------------------
;--Methode vérifiant si l'orientation du bateau entré est correcte ou non --

;---------------------------------------------------------------------------

dirBoat:            CHARI	boatdir, d
                     ;CHARI carBidon, d
                     LDA 0,i
                     LDBYTEA	boatdir, d
                     
                     
                     CPA	'v', i
                     ;CPA	lettreP, d
                     BREQ	eqCharV
                     ;RET0
                     CPA	'h', i
                     ;CPA	lettreM, d
                     BREQ	eqCharH 
                     ;RET0
                     
                     STRO        dirNAcep, d 
                     RET0
                     
;notlet:		STRO	nletmsg, d 
		;BR	out 
eqCharV:		STRO	msgCarV, d
RET0
eqCharH:              STRO	msgCarH, d
RET0 

;out:		STOP

; Char to compare
lettreV:              .BYTE 'v'
lettreH:              .BYTE 'h'

;chr:		.BLOCK 1
boatdir:		.BYTE 1 

; Is a letter message
msgCarV:		.ASCII "le char entre est v\n\x00"
msgCarH:              .ASCII "le char entre est h\n\x00"

; Is not a letter message
dirNAcep:	.ASCII "lettre ou char diffrent de ce qui est demandé\n\x00" 
;-----------------------------------------------------------------------------------
;--Methode vérifiant si la lettre designant la colonne  entré est correcte ou non --

;-----------------------------------------------------------------------------------
colBoat:             CHARI	boatCol, d
                     LDA 0,i
                     LDBYTEA	boatCol, d
                     
                     
                     CPA	'A', i
                     ;CPA	lettreA, d
                     BRLT	underA  ; inferieur à A
                     ;RET0
                     CPA	'R', i
                     ;CPA	lettreZ, d
                     BRLE	peOreqR 
                     ;RET0
                     
                     STRO        notaLet, d
                     RET0
                     
;notlet:		STRO	nletmsg, d 
		;BR	out 
underA:		STRO	msgpeA, d
RET0
peOreqR:              STRO	msgPeR, d
RET0 


;out:		STOP

; Char to compare
lettreA:              .BYTE 'A'
lettreZ:              .BYTE 'Q'

;chr:		.BLOCK 1
boatCol:		.BYTE 1 

; Is a letter message
msgpeA:		.ASCII "le char entre est inferieur à A\n\x00"
msgPeR:                .ASCII "le char entre est petit ou egal  R\n\x00"

; Is not a letter message
         
notaLet:	.ASCII "lettre n'est pas entre A et Q \n\x00"


;------------------------------------------------------------
;Methode verifiant si la rangee est entre  min =1 et max=9
;------------------------------------------------------------

rowBoat:              CHARI	nb, d
                      LDA 0,i
                      LDBYTEA	nb, d
                      CPA	'1', i
		BRLT	ltmin
		
                      CPA	'9', i
		BRLE	gtmax
		STRO	outbmsg, d
                      RET0
		
ltmin:		STRO	ltmnmsg, d
                      RET0
		
gtmax:		STRO	gtmxmsg, d
                      RET0

min:		.BYTE '0'
max:		.BYTE '9'
nb:		.BLOCK 2


; In bounds message; msg va etre affiché si le nm de rangés est: 1<=nb=<9
outbmsg:		.ASCII   "nombre de rangee est incorrecte\x00"
; Lower than min message
ltmnmsg:	            .ASCII  "plus petit que 1\x00"
; Higher than max message
gtmxmsg:	            .ASCII  "nombre de rangee est petit ou egale 9 !\x00"
carBidon: .BLOCK 1

;------------------------------------------------------------
;Methode verifiant si le char est un espace 
;------------------------------------------------------------

checkgap:             CHARI	gap, d
                 
                      LDA 0,i
                      LDBYTEA	gap, d
                     
                      CPA	' ', i
                      ;BREQ        boucle1 

;boucle1:      	CALL       repeat, i           
                      BREQ	isGap
	           STRO	msgNotG, d 
                      RET0
		
;isGap:		STRO	msgGap, d
isGap:		CALL	repeat, i 
                      RET0

gap:		.BYTE 1


; msg va etre affiché si le char est un espace
msgGap:		.ASCII   "char est un ' ' \x00"
;  msg va etre affiché si le char n'est un espace
msgNotG:	            .ASCII  "char est different de ' ' \x00"		

;-------------------------------------------------------------------------
;------  Declaration, reservation espace memoire et  initialisation ------
;-------------------------------------------------------------------------
; Current line Index
lnIndex: .WORD 0

;Max line address = line start + 8
maxLnAdr:.WORD 0

nbLu:    .block 2

matrix:  .ADDRSS ln1         ; #2h
         .ADDRSS ln2         ; #2h
         .ADDRSS ln3         ; #2h
         .ADDRSS ln4         ;avant existe pas
         .ADDRSS ln5
         .ADDRSS ln6
         .ADDRSS ln7
         .ADDRSS ln8
         .ADDRSS ln9
         .ADDRSS ln10

totSize: .equate 48       ;CHANGER avant equate 24 pour 3x4 | critere pour taille de matrice (x2)

iSize:   .equate 20       ;18 parceque la matrice contien 9 lignes
jSize:   .equate 38       ;36 parceque la matrice contien 18 lignes


ptr:     .BLOCK 2            

ln1:     .WORD ' '
         .WORD 'A'
         .WORD 'B'
         .WORD 'C'            
         .WORD 'D'
         .WORD 'E'
         .WORD 'F'
         .WORD 'G'
         .WORD 'H'
         .WORD 'I'            
         .WORD 'G'
         .WORD 'K'
         .WORD 'L'
         .WORD 'M'
         .WORD 'N'            
         .WORD 'O'
         .WORD 'P'
         .WORD 'Q'
         .WORD 'R'


ln2:     .WORD '1'
         .WORD '~'
         .WORD '~'
         .WORD '~'             
         .WORD '~'
         .WORD '~'
         .WORD '~'
         .WORD '~'
         .WORD '~'             
         .WORD '~'
         .WORD '~'
         .WORD '~'
         .WORD '~'             
         .WORD '~'
         .WORD '~'
         .WORD '~'
         .WORD '~'
         .WORD '~'             
         .WORD '~'
         

ln3:     .WORD '2'
         .WORD '~'
         .WORD '~'
         .WORD '~'             
         .WORD '~'
         .WORD '~'
         .WORD '~'
         .WORD '~'
         .WORD '~'             
         .WORD '~'
         .WORD '~'
         .WORD '~'
         .WORD '~'             
         .WORD '~'
         .WORD '~'
         .WORD '~'
         .WORD '~'
         .WORD '~'             
         .WORD '~'

ln4:     .WORD '3'
         .WORD '~'
         .WORD '~'
         .WORD '~'             
         .WORD '~'
         .WORD '~'
         .WORD '~'
         .WORD '~'
         .WORD '~'             
         .WORD '~'
         .WORD '~'
         .WORD '~'
         .WORD '~'             
         .WORD '~'
         .WORD '~'
         .WORD '~'
         .WORD '~'
         .WORD '~'             
         .WORD '~'

ln5:     .WORD '4'
         .WORD '~'
         .WORD '~'
         .WORD '~'             
         .WORD '~'
         .WORD '~'
         .WORD '~'
         .WORD '~'
         .WORD '~'             
         .WORD '~'
         .WORD '~'
         .WORD '~'
         .WORD '~'             
         .WORD '~'
         .WORD '~'
         .WORD '~'
         .WORD '~'
         .WORD '~'             
         .WORD '~'

ln6:     .WORD '5'
         .WORD '~'
         .WORD '~'
         .WORD '~'             
         .WORD '~'
         .WORD '~'
         .WORD '~'
         .WORD '~'
         .WORD '~'             
         .WORD '~'
         .WORD '~'
         .WORD '~'
         .WORD '~'             
         .WORD '~'
         .WORD '~'
         .WORD '~'
         .WORD '~'
         .WORD '~'             
         .WORD '~'

ln7:     .WORD '6'
         .WORD '~'
         .WORD '~'
         .WORD '~'             
         .WORD '~'
         .WORD '~'
         .WORD '~'
         .WORD '~'
         .WORD '~'             
         .WORD '~'
         .WORD '~'
         .WORD '~'
         .WORD '~'             
         .WORD '~'
         .WORD '~'
         .WORD '~'
         .WORD '~'
         .WORD '~'             
         .WORD '~'

ln8:     .WORD '7'
         .WORD '~'
         .WORD '~'
         .WORD '~'             
         .WORD '~'
         .WORD '~'
         .WORD '~'
         .WORD '~'
         .WORD '~'             
         .WORD '~'
         .WORD '~'
         .WORD '~'
         .WORD '~'             
         .WORD '~'
         .WORD '~'
         .WORD '~'
         .WORD '~'
         .WORD '~'             
         .WORD '~'

ln9:     .WORD '8'
         .WORD '~'
         .WORD '~'
         .WORD '~'             
         .WORD '~'
         .WORD '~'
         .WORD '~'
         .WORD '~'
         .WORD '~'             
         .WORD '~'
         .WORD '~'
         .WORD '~'
         .WORD '~'             
         .WORD '~'
         .WORD '~'
         .WORD '~'
         .WORD '~'
         .WORD '~'             
         .WORD '~'

ln10:    .WORD '9'
         .WORD '~'
         .WORD '~'
         .WORD '~'             
         .WORD '~'
         .WORD '~'
         .WORD '~'
         .WORD '~'
         .WORD '~'             
         .WORD '~'
         .WORD '~'
         .WORD '~'
         .WORD '~'             
         .WORD '~'
         .WORD '~'
         .WORD '~'
         .WORD '~'
         .WORD '~'             
         .WORD '~'

ix:      .BLOCK  2           ; #2d ; reservé 2 octet à ix initialisé à 0
;ix:      .BLOCK  1 
jx:      .BLOCK  2           ; #2d; reservé 2 octet à jx initialisé à 0
;jx:      .BLOCK  1
temp:    .block  2           ;reservé 2 octet à temp
;temp:    .block  1           ;reservé 2 octet à temp
gapp:    .WORD ' '

welMsg: .ASCII "Bienvenue au jeu de bataille navale! \n\x00"

askMsg: .ASCII "Entrer la description et la position des bateaux \n"
         .ASCII "selon le format suivant, separes par des espaces: \n"
         .ASCII "taille[p/m/g] orientation[h/v] colonne[A-R] rangée[1-9] \n"
         .ASCII "ex: ghC4 mvM2 phK9 \n\x00" 
retMsg: .ASCII "Je suis de retour\n\x00" 
retMsgb: .ASCII "Je suis de retour apres verif de grandeur boat\n\x00"
retMsgD: .ASCII "Je suis de retour apres verif de l'orientation boat\n\x00"
retMsgC: .ASCII "Je suis de retour apres verif de la colonne boat\n\x00"
retMsgG: .ASCII "Je suis de retour apres verif du char ' ' \n\x00"


         

.end








