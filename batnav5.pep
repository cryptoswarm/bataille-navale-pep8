         STRO welMsg, d; imprimer le msg de bienvenue 
         CHARO '\n', i ; imprimer saut de ligne
         
         
;Matrice 3 x 4 
         LDX     0,i

;display
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

msgDisp:         STRO askMsg1, d 
                 STRO askMsg2, d 
                 STRO askMsg3, d 
                 STRO askMsg4, d

                 CALL sizeBoat
                 STRO retMsg, d 
                 CALL rowCheck
                 ;CALL main 
                 STRO retMsg, d 











fini:    stop




;Methode verifiant si la rangee est entre  min =1 et max=9

rowCheck:             CHARI	nb, d
                      CHARI carBidon, d
                      ;LDBYTEA	nb, d
                      LDA	nb, d
		CPA	min, d
                      ;CPA	1', i
		BRLT	ltmin
		CPA	max, d 
                      ;CPA	9', i
		BRGT	gtmax
		STRO	inbmsg, d
                      RET0
		;BR	out
ltmin:		STRO	ltmnmsg, d
                      RET0
		;BR	out 
gtmax:		STRO	gtmxmsg, d
;out:		STOP
                      RET0

min:		.BYTE '0'
;min:		.BYTE 0x01
;min:		.WORD 31
max:		.BYTE '9'
;max:		.BYTE 0x09
;max:		.WORD 39
nb:		.BLOCK 2
;nb:		.BYTE 0'

; In bounds message; msg va etre affiché si le nm de rangés est: 1<=nb=<9
inbmsg:		.ASCII   "nombre de rangee est correcte\x00"
; Lower than min message
ltmnmsg:	            .ASCII  "plus petit que 1\x00"
; Higher than max message
gtmxmsg:	            .ASCII  "nombre de rangee est plus grand que 9 !\x00"
carBidon: .BLOCK 1

;Methode verifiant si la grandeur du bateau et correcte ou non 
sizeBoat:             CHARI	nb, d









		

;-----------------------------------------------------------------
;Declaration, reservation espace memoire et  initialisation 
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
jSize:   .equate 36       ;36 parceque la matrice contien 18 lignes


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

welMsg: .ASCII "Bienvenue au jeu de bataille navale! \n\x00"

askMsg1: .ASCII "Entrer la description et la position des bateaux \n\x00"
askMsg2: .ASCII "selon le format suivant, separes par des espaces: \n\x00"
askMsg3: .ASCII "taille[p/m/g] orientation[h/v] colonne[A-R] rangée[1-9] \n\x00"
askMsg4: .ASCII "ex: ghC4 mvM2 phK9 \n\x00" 
retMsg: .ASCII "Je suis de retour\n\x00" 
         

.end








