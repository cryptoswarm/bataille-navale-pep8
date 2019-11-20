;---------------------------------------------------------------------
;                                                                   --
; Le program suivant peut verifie la description de bateau 
; peut placer les bateau dans la position correcte
; peut detruire un bateau 
; Si on rentre  ghC4 comme bateau 
; et qu'on rentre C4 comme coup le bateau va etre detruit et 
; le msg de fin de jeu s'affiche
;                                                                   --
;---------------------------------------------------------------------     

main:         LDX     0,i         
         STRO welMsg, d; imprimer le msg de bienvenue 
         ;CHARO '\n', i ; imprimer saut de ligne
         
         CALL    display
         CALL    msgBat
         CALL    display2


;---------------------------------------------------------------------
;                                                                   --
; Methode pour print l'espace du jeu   initialemt remplis avec '~'  --
;                                                                   --
;---------------------------------------------------------------------
display: STRO        ALPHA,d  ; afficher les lettres ABCDEFGHIJKLMNOPQR
         LDX         0,i
         STX         ix,d 


iloop:   CPX     iSize,i
         
         BRGE    findisp      ; 
         
         LDX     0,i         ; 
         STX     jx,d        ; 
         DECO    range,d
         CHARO  '|',i 

 

         
jloop:   CPX     jSize,i
         BRGE    next_ix
         ADDX    ix,d
         CHARO   tild,i
         LDX     ix,d         
         LDA     matrix,x    ; rA <- address of ln1,ln2 or ln3
         STA     ptr,d
         LDX     ptr,d
         ADDX    jx,d
         LDA     tild,i
     
         STA     0,x 
         LDX     jx,d
         ADDX    2,i ;ADDX    2,i 
        
         STX     jx,d 
         BR      jloop 

next_ix: CHARO   '|',i
         CHARO   '\n',i
         LDX     ix,d
         ADDX    2,i ;ADDX    2,i
         STX     ix,d
         LDA     range,d
         ADDA    1,i
         STA     range,d
         BR      iloop
findisp: RET0

;---------------------------------------------------------------------------
;                                                                         --
; Methode pour print l'espace du jeu  y compris les chars '>' ou 'v' qui  --
; representent la description des bateau sinon il est remplis avec '~'     --
;                                                                          --
;----------------------------------------------------------------------------




display2:CHARO '\n', i
         STRO        ALPHA,d  ; afficher les lettres ABCDEFGHIJKLMNOPQR
         LDX         0,i
         STX         ix,d 
         LDA     1,i
         STA     range,d


iloop2:   CPX     iSize,i
         
         BRGE    FeuMsg ; Si on a terminÈ l'affiuchage du tableau avec les bateaux dedans
                        ; on demande ‡  l'utilisateur d'entrer les coups. 
         
                              
         LDX     0,i         
         STX     jx,d        
         DECO    range,d
         CHARO  '|',i 
          
jloop2:   CPX     jSize,i
         BRGE    next_ix2
         ADDX    ix,d
         LDX     ix,d         
         LDA     matrix,x    ; 

         ADDA    jx,d        
         ADDA    1,i
         STA     ptr,d
         CHARO   ptr,n
         ;LDX     ptr,d

         ADDX    jx,d
         LDX     jx,d
         ADDX    2,i         
         STX     jx,d 
         BR      jloop2

next_ix2: CHARO   '|',i
         CHARO   '\n',i
         LDX     ix,d
         ADDX    2,i
         STX     ix,d
         LDA     range,d
         ADDA    1,i
         STA     range,d
         BR      iloop2

FeuMsg: CALL feuStart

;-------------------------------------------------------------------------------
;                                                                             --
; Methode pour print l'espace du jeu  y compris les chars '>' ou 'v' qui      --
; representent la description des bateau sinon il est remplis avec '~'        --
; et des 'o' dans le cas ou le coup tempe dans une position autre que '>'     --
; ou 'v' sinon le char '*' reprend la place des parties touchees des bateaux  --
;                                                                             --
;---------------------------------------------------------------------------- --      

display3:CHARO '\n', i
         STRO        ALPHA,d  ; afficher les lettres ABCDEFGHIJKLMNOPQR
         LDX         0,i
         STX         ix,d 
         LDA     1,i
         STA     range,d


iloop3:   CPX    iSize,i 
         
         BRGE    MsgKil ; Si on a terminÈ l'affiuchage du tableau avec les bateaux dedans
                        ; on demande ‡  l'utilisateur d'entrer les coups. 
         
                              
         LDX     0,i         
         STX     jx,d        
         DECO    range,d
         CHARO  '|',i 
          
jloop3:   CPX    jSize,i
         BRGE    next_ix3
         ADDX    ix,d
         LDX     ix,d         
         LDA     matrix,x    ; 

         ADDA    jx,d        
         ADDA    1,i
         STA     ptr,d
         CHARO   ptr,n
         ;LDX     ptr,d

         ADDX    jx,d
         LDX     jx,d
         ADDX    2,i         
         STX     jx,d 
         BR      jloop3

next_ix3: CHARO   '|',i 
         CHARO   '\n',i
         LDX     ix,d
         ADDX    2,i
         STX     ix,d
         LDA     range,d
         ADDA    1,i
         STA     range,d
         BR      iloop3

MsgKil:  CALL KillEnd 
         RET0


;-------------------------------------------------------------------------------
;                                                                             --
;        Methode pour print l'espace du jeu  y compris les chars 'o'          --
;---------------------------------------------------------------------------- --      

display4:CHARO '\n', i
         STRO        ALPHA,d  ; afficher les lettres ABCDEFGHIJKLMNOPQR
         LDX         0,i
         STX         ix,d 
         LDA     1,i
         STA     range,d


iloop4:   CPX    iSize,i 
         
         BRGE    return ; Si on a terminÈ l'affiuchage du tableau avec les bateaux dedans
                        ; on demande ‡  l'utilisateur d'entrer les coups. 
         
                              
         LDX     0,i         
         STX     jx,d        
         DECO    range,d
         CHARO  '|',i 
          
jloop4:   CPX    jSize,i 
         BRGE    next_ix4
         ADDX    ix,d
         LDX     ix,d         
         LDA     matrix,x    ; 

         ADDA    jx,d        
         ADDA    1,i
         STA     ptr,d
         CHARO   ptr,n
         ;LDX     ptr,d

         ADDX    jx,d
         LDX     jx,d
         ADDX    2,i         
         STX     jx,d 
         BR      jloop4

next_ix4: CHARO   '|',i 
         CHARO   '\n',i
         LDX     ix,d
         ADDX    2,i
         STX     ix,d
         LDA     range,d
         ADDA    1,i
         STA     range,d
         BR      iloop4

return:  RET0
         






;-----------------------------------------------------------------

;--imprimer msg demandant d'entrer les specification des bateaux--

;-----------------------------------------------------------------

msgBat:         STRO askMsg, d 

;Boucle1:         CPX  gap, d     ; while char == gap, on repete la lecture des chars 
               ;  BREQ Boucle1
               ;  BRGE erreur               ; qui decrivent les bateaux
;erreur:         ; STRO askMsg, d  

           

;repeat:          CALL sizeBoat
                 

getBat:          CALL getsize 
                 CALL getOri 
                 CALL getposC  ; colonne
                 CALL getposR  ; rangee
                 CALL isValid  ; Verifie si le bateau entre dans l'espace de jeu

                 ; is valid laisse son bool de retour en A
                 ;CPA  1,i 
                 ;BREQ placerB ;Si valide on procede ? placer les bateau dans l'espace de jeu
                 CALL placerB
                 CALL checkgap 
                
                 ret0 

;------------------------------------------------------------------------------------
;-----------------------la grandeur  du bateau -------------------------------------
;-------------------------------------------------------------------------------------

getsize:         CHARI boatSize, d 
                 LDBYTEA boatSize, d 
                 CPA   'g', i
                 BREQ casSize1    ; cas ou le bateau est grand 
                 CPA   'm', i
                 BREQ casSize2   ; cas ou le bateau est moyen 
                 CPA   'p', i
                 BREQ casSize3  ; cas ou le bateau est petit
                 
                 BR    msgBat   ; brancher si le bateau ni grand, ni moyen ni petit.
                  
casSize1:        LDA   5,i
                 CPA   5,i
                 BREQ finCasSz 
casSize2:        LDA   3,i
                 CPA   3,i
                 BREQ finCasSz
casSize3:        LDA   1,i
finCasSz:        STA sizeT,d
                 STA  size,d   ; la grandeur du bateau 
                  
                 ;DECO sizeT, d  
                 RET0

;-------------------------------------------------------------------------------------
;---------------------------l'orientation du bateau ----------------------------------
;-------------------------------------------------------------------------------------
getOri:          CHARI orient,d
                 LDBYTEA orient,d   ; orientation du bateau 
                 STA dir, d   ; direction du bateau 
                 CPA   'h', i
                 BREQ finOrien  ; retour a la methode 
                 CPA   'v', i
                 BREQ finOrien ; si char = 'v' 
                 BR   msgBat  ;  si char != 'v' ou 'h'
finOrien:        RET0 ; retour a la methode

;--------------------------------------------------------------------------------------
;-----------------------------la position du bateau : colonne -------------------------
;--------------------------------------------------------------------------------------
getposC:        CHARI   boatCol,d   ; obteni la colonne du bateau 
                LDBYTEA boatCol,d
                        
                CPA	'A', i
                    
                BRLT	msgBat  ; Si inferieur ? A : msg d'erreur 
                     
                CPA	'R', i
                    
                BRGT   msgBat  ; Si grand que R : msg d'erreur 


                 SUBA  'A', i   ; Enlever 'A' du boatCol 
                 ;ASLA           ; here i get my position at y
                 STA   col, d   ; Colonne du bateau  col = boatCol -'A'
                 ;CHARO col, d
                 ;DECO  col, d
                 RET0

                 
;--------------------------------------------------------------------------------------
;-----------------------------la position du bateau :  rangee  ------------------------
;--------------------------------------------------------------------------------------

               
getposR:         CHARI boatRow, d ;DECI boatRow, d ;CHARI boatRow, d  ;DECI boatRow, d       ; obtenir la rangee du bateau 
                 
                 ;LDA 0,i
                 ;LDA boatRow, d
                 LDBYTEA  boatRow, d
                 ;CPA	1, i 
                 CPA	49, i     
                 BRLT	msgBat  ; Si < 1 erreur 
		
                 ;CPA	9, i
                 CPA	57, i
		 
                 BRGT	msgBat  ; Si > 9 erreur 
                 ;SUBA 48,i
                 SUBA 48,i
                 STA rowtemp, d


                 SUBA  1, i  ; on commence ?  0
                 ;ADDA  1, i
                 ;ASLA
                 STA   row, d  ; Store res dans variable row
                 
                 CHARO '\n', i
                 LDA row, d
                 ;DECO row, d
             
                 
                 LDX nbCol, i ; number of colom  =18 ;LDX  18,i  ;
                 
                 BRGE commence ; if(nb2 < 0){

                 LDA row,d ; maybe it is iSize,d
                 
                 ;LDA rowtemp,d
                 NEGA ;
                 STA row,d ; A = nb1 = -nb1;
                 
                 
              

commence:        LDA 0,i ; A = 0;
addition:        ADDA row,d ; do{ A += nb1; ADDA rowtemp, d ; ADDA col, d ;
                 SUBX 1,i ; X--;
                 BRNE addition ; } while(X != 0);
                 ;ASLA 
fini:            STA res1,d ; res1 = A;
                 LDA col,d
                 ADDA res1,d
                 ASLA
                 STA pos,d
                 STA postem, d ; position de bateau 
                 
                 ;CHARO 'z',i
                 ;DECO pos,d     ; position du bateau bateau[rangee][colonne] = pos
                 CHARO '\n', i 
                ; STRO "nbColone*row = \x00", i 
                 ;DECO res1,d ; cout << res;
                 ;DECO postem, d 

                  

                
                 RET0


;--------------------------------------------------------------------------------------
;-----------------------------Validation du position de bateau   ---------------------
;--------------------------------------------------------------------------------------

         
isValid:         LDA size, d
                 CPA 5, i
                 BREQ sizeg
                 CPA 3,i
                 BREQ sizem
                 ;-------------------------------------
                 ;----       SIZE grand       ---------
                 ;-------------------------------------
                 
sizeg:           lDA dir,d
                 CPA 'h', i
             
                 BREQ batgh
                 CPA 'v', i
                 BREQ batgv  ; bateau grand vertical 
batgh:           lDA col, d
                 CPA 13, i
                 BRGT noplacg ; go to the next and chexk if it is a gap via checkgap method
                 CALL placerB

noplacg:         CALL checkgap

batgv:           lDA row, d
                 CPA 4, i
                 BRGT noplcgv ;ne pas placer bateau grand vertical a la rangee 7 
                 CALL placerB
noplcgv:         CALL checkgap

                 ;-------------------------------------
                 ;----       SIZE medium     ----------
                 ;-------------------------------------


sizem:           lDA dir,d
                 CPA 'h', i
                 BREQ batmh
                 CPA 'v', i
                 BREQ batmv

batmh:           lDA col, d      ; bateau moyeb horizontal
                 CPA 15, i
                 BRGT noplacem   ;checkgap placeB
                 CALL placerB
                 
noplacem:        CALL checkgap




batmv:           lDA row, d    ; bateau moyeb Vertical
                 CPA 7, i
                 BRGT noplcmv ;ne pas placer bateau moyen  vertical a la rangee 7 
                 CALL placerB
noplcmv:         CALL checkgap ; 
 
                ; CPA ; Verifier si la  position des bateaux est a l'interieur de la matrix 
                ; RET0


;---------------------------------------------------------------------------------------
;----------------Methode verifiant si le char est un espace -----------------------------
;----------------------------------------------------------------------------------------

checkgap:             CHARI	gap, d
                 
                      LDA 0,i
                      LDBYTEA	gap, d
                     
                      CPA	' ', i         
                      BREQ	isGap 
	         ; if it is diffrent than a ' ' go to print bateau method	
                      CALL  display2    ;printBat 
                      ;RET0
		
isGap:		CALL	getBat  ; Ex: ghC4 si apres on trouve espace on passe a 
                                          ; la lecture de 2eme bateau sinon 
                                          ; on affiche le bateau dans le cas ou il est valide

                      RET0



;--------------------------------------------------------------------------------------
;-----------------------------mettre a jour le tableau   ------------------------------
;--------------------------------------------------------------------------------------


        
placerB:         LDX matrix,d   ;ldx matrix,i
                 ADDX pos,d
                 STX pos,d
               ;--------------
                 ;deco pos,i
                 
               ;--------------
                 ;LDX pos,d    ; position du bateau xy = (pos 'col' - 'A' + long*(rang-1))*2 
                 ;LDA orient,d  ; maybe it is d
                 LDA dir,d
                 CPA 'h',i
                 BRNE placerVB   ; Si different de h donc c'est vertical 
                 


                 LDA size,d
                 STA size,d
loopPlac:        CPA 0,i
                 BREQ finlpPl
                 LDA '>',i
                 
                 ;STA matrix,x 
                 STA pos,n
                 ADDX 2,i
                 STX pos,d
                 ;ADDX 1,i
                 LDA size,d
               ; STA sizetem, d 
                 SUBA 1,i
                 STA size,d
                 BR loopPlac






placerVB:        LDA size,d
                 STA size,d

                 
                 ;STA matrix,x 
                 ;ADDX 18, i
               
                 
                 
                 

loopPlcV:        CPA 0,i 
                 BREQ finlpPl
                 LDA 'V',i
                 
                 ;STA matrix,x 
                 STA pos,n
                 ;ADDX 2,i
                 ADDX 36, i
                 STX pos,d
                 ;ADDX 1,i
                 LDA size,d
               ; STA sizetem, d 
                 SUBA 1,i
                 STA size,d
                 BR loopPlcV

finlpPl:         RET0  ; fin de loop placer bateau

           ;-----------------------------------------------------------
           ;-------   A partir de cet endroit                    ------
           ;-------   le traitement des coups entres  commence   ------            
           ;-------   les coups a entrer              -----------------
           ;-----------------------------------------------------------

                 

                 

                 


;----------------------------------------------------------------------------
;------------------ les coups a entrer  ------------------------------------ 
;----------------------------------------------------------------------------


            
feuStart:   STRO  MsgFeu, d

    
fireSet:    CALL getColF
            CALL getRowF
            ;CALL isValidF
            CALL placeFeu
            CALL feugap
            ;CALL isValdF ; verifier si le coup est valide
            ;ValdFeu   ; faut valider les coups
            ;CALL addnbF
            ;CALL destroy 
            ;CALL display3

;--------------------------------------------------------------------------------------
;-----------------------------la position du feu : colonne -------------------------
;--------------------------------------------------------------------------------------
getColF:        CHARI   FeuColt,d 
                LDBYTEA FeuColt,d
                        
                CPA	'A', i
                    
                BRLT	feuStart  ; Si inferieur ? A : msg d'erreur 
                     
                CPA	'R', i
                    
                BRGT   feuStart  ; Si grand que R : msg d'erreur 


                 SUBA  'A', i   ; Enlever 'A' du boatCol 
                ; ASLA           ; here i get my position at y
                 STA   colFeu, d   ; Colonne du bateau  col = boatCol -'A'
                 ;CHARO colFeu, d
                 ;DECO  colFeu, d
                 RET0

;--------------------------------------------------------------------------------------
;-----------------------------la position du feu :  rangee  ---------------------------
;--------------------------------------------------------------------------------------

               
getRowF:         CHARI FeuRowt, d ;DECI boatRow, d ;CHARI boatRow, d  ;DECI boatRow, d       ; obtenir la rangee du bateau 
                 
                 ;LDA 0,i
                 LDBYTEA  FeuRowt, d
                 ;CPA	1, i 
                 CPA	49, i     
                 BRLT	feuStart  ; Si < 1 erreur 
		
                 ;CPA	9, i
                 CPA	57, i
		 
                 BRGT	feuStart  ; Si > 9 erreur 
                 ;SUBA 48,i
                 SUBA 48,i
                 STA rowFeu, d 


                 ;SUBA  1, i  ; on commence ?  0
                 SUBA  1, i
                 ;ASLA
                 STA   rowFeu, d  ; Store res dans variable row
                 
                 ;CHARO '\n', i
                 LDA  rowFeu, d
                 ;DECO rowFeu, d


;-------------------------------------------------------------------------------------
;-------------------Trouver la position du feu dans le tableau   ----------------------
;-------------------en se basant sur la rangee du feu et la colonne du feu -------------
;-------------------------------------------------------------------------------------

                 LDX nbCol, i ; number of colom  =18 ;LDX  18,i  ;
                 
                 BRGE start ; if(nb2 < 0){

                 LDA row,d ; maybe it is iSize,d
                 
                 ;LDA rowtemp,d
                 NEGA ;
                 STA row,d ; A = nb1 = -nb1;
                 

start:           LDA 0,i ; A = 0; 
add:             ADDA rowFeu,d ; do{ A += nb1; ADDA rowtemp, d ; ADDA col, d ; 
                 SUBX 1,i ; X--;
                 BRNE add ; } while(X != 0);
                 ;ASLA 
end:             STA ress1,d ; res1 = A; 
                 LDA colFeu,d
                 ADDA ress1,d
                 ASLA
                 STA posFeu,d  ; position de feu 
                 ;CHARO 'z',i
                 ;DECO posFeu,d  ; position de feu
                 ;CHARO '\n', i 
              
                 ;DECO ress1,d ; cout << res; 

                 RET0




                 



;---------------------------------------------------------------------------------------
;----------------Methode verifiant si le char est un espace -----------------------------
;----------------------------------------------------------------------------------------

feugap:               CHARI	gapFeu, d
                 
                      LDA 0,i
                      LDBYTEA	gapFeu, d
                     
                      CPA	' ', i         
                      BREQ	isGapF 
	         ; if it is diffrent than a ' ' go to print bateau method	
                      CALL  display3 ;destroy;printBat 
                      ;RET0
		
isGapF:		CALL   fireSet   ;addnbF ; incrementer les coups
;CALL 	fireSet ;CALL fireSet 
;isGap:		CALL	repeat, i 
                      RET0
;--------------------------------------------------------------------------------------
;----------------------------- Methode stockant les position des coups ----------------
;--------------------------------------------------------------------------------------
                    ;  LDA nbCoup, d
                    ;  ADD
;addnbF


;--------------------------------------------------------------------------------------
;----------------------------- placer feu et destroy les bateau   ---------------------
;--------------------------------------------------------------------------------------

placeFeu:        LDA   postem,d
;destroy:         
                 
                 CPA   posFeu, d
                 BREQ  change
                 BR    fnohit              ;sinon branche vers methode ou feu ne touche pas
                 ;BR printo 
                 RET0
                 


                 ;RET0

                 



change:          LDX matrix,d
                 ADDX postem, d ;ADDX posFeu,d    ; ADDX pos, d  position bateau 
                 STX postem, d ;STX  posFeu,d    ; STX pos, d position de bateau 
              
                 LDA dir,d
                 CPA 'h',i
                 BRNE placeVB   ; Si different de h donc c'est vertical 
                 


                 
                 LDA sizeT,d 
                 STA sizeT,d 
lopPlac:         CPA 0,i ;trying to print coups
                 BREQ endlpPl
                 
                 LDA postem, s
                 ;CPA posFeu , i
                 ;BREQ printS 

                 LDA '*',i     ; print star
                   
                 ;LDA '>',i
                 ;LDA 
                 
                 ;STA matrix,x 
                 STA postem,n
                 ADDX 2,i
                 STX postem,d
                 ;ADDX 1,i
                 LDA sizeT,d 
               ; STA sizetem, d 
                 SUBA 1,i
                 STA sizeT,d 
                 BR lopPlac






placeVB:         LDA sizeT,d     ; cas ou le bateau est vertical 
                 STA sizeT,d

                 
                 ;STA matrix,x 
                 ;ADDX 18, i
               
                 
                 
                 

lopPlcV:         CPA 0,i  ; boucle bateau vertical 
                 BREQ endlpPl
                 ;LDA 'V',i
                 LDA '*',i 
                 ;STA matrix,x 
                 STA postem,n
                 ;ADDX 2,i
                 ADDX 36, i
                 STX postem,d
                 ;ADDX 1,i
                 LDA sizeT,d 
               ; STA sizetem, d 
                 SUBA 1,i
                 STA sizeT,d
                 BR lopPlcV

endlpPl:         RET0



;--------------------------------------------------------------------------------------
;----------------------------- placer feu qui ne touche pas      ---------------------
;--------------------------------------------------------------------------------------



fnohit:          LDA   posFeu, d ;postem,d
        
                 
          
                 LDX matrix,d
                 ADDX posFeu, d ;ADDX posFeu,d    ; ADDX pos, d  position bateau 
                 STX posFeu, d ;STX  posFeu,d    ; STX pos, d position de bateau 
              
               
                 LDA posFeu, s
            

                 LDA 'o',i     ; print star
                   
                 STA posFeu,n 

         ;--------------------------------------
         ;-- le coup ne touche pas            --
         ;-- on va verifie s'il ya espace     --
         ;-- s'il ya espace on verifie le     --
         ;-- le nouveau coup                  --
         ;-- sinon on demande de rentrer      --
         ;-- d'autre coups vu que les         --
         ;-- les bateau ne sont pas detruits  --
         ;--------------------------------------

                 CALL display4     
                 CALL fgapN ; le coup ne touche pas 




        
                 RET0









;---------------------------------------------------------------------------------------
;----------------Methode verifiant si le char est un espace  apres ----------------------
;---------------- que le coup ne touche pas                           -------------------
;----------------------------------------------------------------------------------------

fgapN:                CHARI	gapFeu, d   
                 
                      LDA 0,i
                      LDBYTEA	gapFeu, d
                     
                      CPA	' ', i         
                      BREQ	isspace
	         ; if it is diffrent than a ' ' go to print bateau method	
                      CALL  feuStart ; demander d'entrer d'autre coups 
                      ;RET0
		
isspace:		CALL   fireSet   ;addnbF ; incrementer les coups 
;CALL 	fireSet ;CALL fireSet 
;isGap:		CALL	repeat, i 
                      RET0





;CALL display3 ;affiche 

;affiche:         CALL display3  ; fin de loop placer bateau 

                 

                 
;STOP
; Si a la positionbateau[rangFeu][ColFeu] on a un char '~' 
;donc postion bateau[rangFeu][ColFeu] = 'o'
;Sinon si :

;positionbateau[rangFeu][ColFeu] == '>' ou positionbateau[rangFeu][ColFeu]=='v'{

;positionbateau[rangFeu][ColFeu] = '*'

;CALL destroyBateau (postion bateau, rang, colo+1)
;CALL destroyBateau (postion bateau, rang, colo-1)
;CALL destroyBateau (postion bateau, rang+1, colo)
;CALL destroyBateau (postion bateau, rang-1, colo)





;--------------------------------------------------------------------------------------
;-----------------------------Validation du position de bateau   ---------------------
;--------------------------------------------------------------------------------------

         
;isValid:         LDA  
                ; CPA ; Verifier si la  position des bateaux est a l'interieur de la matrix 
                ; RET0


;---------------------------------------------------------------------------------------
;----------------Imprimer -----------------------------
;----------------------------------------------------------------------------------------


                 

KillEnd: STRO MsgEnd, d
         
         CHARI Anychar, d ; si on rentre '\n' on continue sinon on arrete le programme
         ;LDA 0,i
         LDBYTEA Anychar, d
         ;STA Anychar, d;LDA 0,i
          
         CPA '\n', i
         BREQ gomain 

         
         ;LDA carVide, d 
         
         CALL END
         
         
gomain:          LDA 0, i 
                 STA range, d 
                 CALL main
         
END:     STRO realEnd, d ;sinon le programme s'arrete


STOP
        

                       
 
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
         ;.ADDRSS ln10

ln1:              .BLOCK 36 ; #2d18a 
ln2:              .BLOCK 36 ; #2d18a 
ln3:              .BLOCK 36 ; #2d18a 
ln4:              .BLOCK 36 ; #2d18a 
ln5:              .BLOCK 36 ; #2d18a 
ln6:              .BLOCK 36 ; #2d18a 
ln7:              .BLOCK 36 ; #2d18a 
ln8:              .BLOCK 36 ; #2d18a 
ln9:              .BLOCK 36 ; #2d18a 


;totSize: .equate 48       ;CHANGER avant equate 24 pour 3x4 | critere pour taille de matrice (x2)

;iSize:   .BYTE 9       ;18 parceque la matrice contien 9 lignes
iSize:   .equate 18

nbRow: .equate 9
nbCol: .equate 18


jSize:   .equate 36       ;36 parceque la matrice contien 18 Colonne 
;jSize:   .BYTE 18  ; was 36
res1:    .BLOCK 2
res2:    .BLOCK 2
pos:     .BLOCK 2    ; position de bateau = [col- 'A' + nbColonne*(range-1)]*2
postem:  .BLOCK 2

ress1:    .BLOCK 2
posFeu:   .BLOCK 2  ; la position du feu 


ptr:     .BLOCk 2 

             .BLOCK 18 ; #2d18a 

ALPHA:        .ASCII "  ABCDEFGHIJKLMNOPQR\n\x00"           

tild:         .EQUATE 0x007E   ; char ~
carVert:      .EQUATE 0x0076   ; char v
carHori:      .EQUATE 0x003E   ; char > 
emptyO:       .EQUATE 0x006F   ; char o , si aucune partie de boat n'est touche»
tempCol:      .BLOCK 2
tempRow:      .BLOCK 2
rowtemp:      .BLOCK 2

sizeT: .BLOCK 2  ; temporaire

col:       .WORD 0  ; la colonne du bateau 
dir:       .WORD 0  ; direction du bateau 
row:       .WORD 0  ; la rangee du bateau 
orient:    .BYTE 1  ; l'orientation du bateau 
size:	.BYTE 1  ; la grandeur du bateau 
sizetem:  .BYTE 1 
boatdir:  .BYTE 1
boatRow:  .BLOCK 2
boatSize: .BYTE 1 
boatCol:  .BYTE 1 
gap:      .BYTE 1
gapFeu:  .BYTE 1  ; espace entre chaque coup
var:     .BLOCK 1
colFeu:  .WORD 0 ; colonne du coup entr»
rowFeu:  .WORD 0 ; rangee du coup entr»
FeuColt: .WORD 0 ; colonne du coup entr» temporaire 
FeuRowt: .WORD 0 ; rangee du coup entr» temporaire 
Anychar: .BLOCK 2
nbCoup: .BLOCK 2
carVide: .BLOCK 2



 
                
                   
    
     
                   
        
         

ix:      .BLOCK  2           ; #2d  reserv» 2 octet ? ix initialis» ? 0 // rangee ou line 
 
jx:      .BLOCK  2           ; #2d  reserv» 2 octet ? jx initialis» ? 0  // colonne 
range:   .WORD  1            ; nbr de rangee a imprimer 
rantemp:   .WORD  1  

temp:    .block  2           ;reserv» 2 octet ? temp
;temp:    .block  1           ;reserv» 2 octet ? temp
gapp:    .WORD ' '

welMsg:  .ASCII "Bienvenue au jeu de bataille navale! \n\x00"

askMsg:  .ASCII "Entrer la description et la position des bateaux \n"
         .ASCII "selon le format suivant, separes par des espaces: \n"
         .ASCII "taille[p/m/g] orientation[h/v] colonne[A-R] rang»e[1-9] \n"
         .ASCII "ex: ghC4 mvM2 phK9 \n\x00" 


MsgFeu: .ASCII "Feu ? volont»!\n"
        .ASCII "(entrer les coups ? tirer: colonne [A-R] rang»e [1-9])\n"
        .ASCII "ex: A3 I5 M3 \n\x00"

MsgEnd: .ASCII "Vous avez anÈanti la flotte! \n"
        .ASCII     "Appuyer sur <Enter> pour jouer ‡ nouveau ou \n"
        .ASCII      "n'importe quelle autre saisie pour quitter. \n" 
        .ASCII     "blabla \n\x00"
realEnd:.ASCII     "Au revoir! \n\x00"

.end








