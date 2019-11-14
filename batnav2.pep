;@auteur: ADJELE KOSSI DAVID
;@codePermanent: ADJK06049703

Main:            LDA         0,i
                 STRO        MSG_BVNU,d
                 
                 LDX         0,i

in_loop:         CPX         jeuTabEn,i 
                 BRLE         afficher 
         
afficher:        STRO        MSG_COL,d
                 LDX         0,i
                 STX         line,d

loop_i:          CPX         18,i
                 BRGE        suite ;for(line=0;line < 324; line += 36) {
                 LDX         0,i
                 STX         column,d
                 DECO        range,d
                 CHARO       '|',i

loop_j:          CPX         36,i
                 BRGE        next_i ;for(column =0;column < 36; column += 2) {
                 ADDX        line,d

                 CHARO        mer,i ;print(~);
;TEST
                 LDX         line,d
                 LDA         jeuTab,x
                 STA         ptr,d
                 LDX         ptr,d
                 
                 ADDX        column,d 
                 LDA         mer,i    ;jeuTab[line][column] = >
                 STA         0,x 

;TEST FIN
                 LDX         column,d 
                 ADDX        2,i 
                 STX         column,d 
                 BR          loop_j ; } // fin for column

next_i:          CHARO       '|',i
                 CHARO       '\n',i
                 LDX         line,d
                ; ADDX        36,i 
                 ADDX        2,i 
                 STX         line,d
                 LDA         range,d
                 ADDA        1,i
                 STA         range,d
                 BR          loop_i ; } // fin for line

suite:           STRO        MSG_ENTR,d
while:           CHARI       g,d
                 CHARO       g,d ; TEST A EFFACER
                 CHARI       hv,d
                 CHARI       col,d
                 CHARI       r,d
                 BR          Ajour ; placer les bateaux
suite1:          LDA         1,i
                 STA         range1,d
                 CHARI       space,d
                 
                 
                 LDBYTEA     space,d
                 CPA         ' ',i
                 BREQ        while ; Tant que space est un espace la lecture continue
                 BRNE        write

;Verifie si l'entree pour la grandeur est valide
;branche while sinon
Ajour:           LDBYTEA     g,d
                 CPA         'g',i
                 BREQ        g5 ; definir grandeur case
                 CPA         'm',i
                 BREQ        g5 ; definir grandeur case G3
                 CPA         'p',i
                 BREQ        g5 ; definir grandeur case G1
                 BRNE        while ; branche while si entree grandeur invalide 
                 BR          suite1

;;Verifie si l'entree pour l'orientation est valide
;branche while sinon
g5:              LDA         0,i
                 LDBYTEA     hv,d
                 CHARO       hv,d ; A EFFACER
                 CPA         'h',i
                 BREQ        g5_1 ; A FAIRE brancher une methode avec colonne et rangee 
                 CPA         'v',i
                 BREQ        g5_1 ; A FAIRE brancher une methode avec colonne et rangee
                 BRNE        while ; branche while si entree orientation invalide

;Verifie di l'entree pour la colonne est valide
;branche while sinon
g5_1:            LDA         0,i
                 LDBYTEA     col,d
                 CHARO       col,d
                 CPA         'A',i
                 BRLT        while ; branche while si entree colonne invalide
                 BRGE        g5_2
g5_2:            CPA         'R',i
                 BRGT        while ; branche while si entree colonne invalide   
                 BRLE        g5_3

g5_3:            LDBYTEA     col,d
                 SUBA        'A',i    ; soutrait A de la valeur de la colonne dans l'accumulateur afin d'obtenir l'indice column
                 ASLA                 ; multiplie la valeur obtenue par 2 pour l'incrementation
                 STA         temp_j,d
                 DECO        temp_j,d
                 BR          g5_4

;Verifie si l'entree pour la rangee est valide
;branche while sinon
g5_4:            LDBYTEA     r,d
                 CHARO       r,d
                 CPA         49,i
                 BRLT        while ; branche si rangee < 1
                 BRGE        g5_6

g5_6:            CPA         57,i
                 BRGT        while ; branche si rangee > 9
                 BRLE        g5_7

g5_7:            LDBYTEA     r,d
                 SUBA        49,i

                 CPA         0,i
                 BREQ        a0
                 CPA         1,i
                 BREQ        a1
                 CPA         2,i
                 BREQ        a2
                 CPA         3,i
                 BREQ        a3
                 CPA         4,i
                 BREQ        a4
                 CPA         5,i
                 BREQ        a5
                 CPA         6,i
                 BREQ        a6
                 CPA         7,i
                 BREQ        a7
                 CPA         8,i
                 BREQ        a8

a0:               LDA         0,i 
                 BR          t
a1:               LDA         2,i 
                 BR          t
a2:               LDA         4,i
                 BR          t
a3:               LDA         6,i
                 BR          t
a4:               LDA         8,i
                 BR          t
a5:               LDA         10,i
                 BR          t
a6:               LDA         12,i
                 BR          t
a7:               LDA         14,i
                 BR          t
a8:               LDA         16,i
                 BR          t

t:               STA         temp_i,d
                 DECO        temp_i,d



;affiche1:        CHARO       '\n',i
;                 STRO        MSG_COL,d

placer:          LDX         0,i
                 STX         line,d
loop_i1:         CPX         18,i
                 BRGE        suite1 ;for(line=0;line < 324; line += 36) { 
                 LDX         0,i
                 STX         column,d
                 
                 

loop_j1:         CPX         36,i
                 BRGE        next_i1 ;for(column =0;column < 36; column += 2) {
                 ADDX        line,d

                 LDA         line,d
                 CPA         temp_i,d
                 BREQ        n
                 BRNE        s
n:               LDA         column,d
                 CPA         temp_j,d
                 BREQ        a
                 BRNE        s 
a:               LDBYTEA     hv,d
                 CPA         'h',i
                 BREQ        b
                 CPA         'v',i
                 BREQ        c

b:               LDX         line,d
                 LDA         jeuTab,x
                 STA         ptr,d
                 LDX         ptr,d
                 
                 ADDX        column,d 
                 LDA         hori,i    ;jeuTab[line][column] = >
                 STA         0,x 

                 BR          s
c:               LDX         line,d
                 LDA         jeuTab,x
                 STA         ptr,d
                 LDX         ptr,d
                 
                 ADDX        column,d 
                 LDA         verti,i    ;jeuTab[line][column] = >
                 STA         0,x 
                 BR          s


s:               LDX         column,d 
                 ADDX        2,i 
                 STX         column,d 
                 BR          loop_j1 ; } // fin for column

next_i1:         LDX         line,d
                 ADDX        2,i 
                 STX         line,d
                 BR          loop_i1 ; } // fin fo 
;AFFICHAGE

write:           CHARO       '\n',i
                 LDX         0,i 
                 STX         line,d        
wloopi:          CPX          18,i    

                 BRGE         Fin         ; for(x=0; x<tablen; x += 2) { 
                 
                 LDX         line,d
                 ASLX
                 lDX         jeuTab,x
                 ADDX        36,i
                 STX         column,d
                 SUBX        36,i

                 DECO        range2,d
                 CHARO       '|',i

wloop_j:         CPX         column,i
                 BRGE        wnext_i ;for(column =0;column < 36; column += 2) { 
                

                 CHARO        0,x ;print(~);
                 ADDX        2,i 
                 
                 BR          wloop_j ; } // fin for column

wnext_i:          CHARO       '|',i
                 CHARO       '\n',i
                 LDA        line,d
                 ADDA        1,i 
                 STA        line,d
                 LDA         range2,d
                 ADDA        1,i
                 STA         range2,d
                 BR          wloopi ; } // fin for line



        
Fin:             STOP        ; exit();
;Déclaration des variable

MSG_BVNU:        .ASCII "Bienvenue au jeu de bataille navale!\n\n\x00"
MSG_ENTR:        .ASCII "Entrer la description et la position des bateaux\n"
                 .ASCII "selon le format suivant, séparés par des espaces:\n"
                 .ASCII "taille[p/m/g] orientation[h/v] colonne[A-R] rangée[1-9]\n"
                 .ASCII "ex: ghC4 mvM2 phK9\n\x00"
MSG_TIR:         .ASCII "Feu à volonté!\n"
                 .ASCII "(entrer les coups à tirer: colonne [A-R] rangée [1-9])\n"
                 .ASCII "ex: A3 I5 M3\n\x00"
MSG_WIN:         .ASCII "Vous avez anéanti la flotte!\n"
                 .ASCII "Appuyer sur <Enter> pour jouer à nouveau ou\n"
                 .ASCII "n'importe quelle autre saisie pour quitter.\n\x00"
MSG_FIN:         .ASCII "Au revoir!\x00"
MSG_COL:         .ASCII "  ABCDEFGHIJKLMNOPQR\n\x00" 


;VARIABLES GLOBALES
jeuTabEn:        .EQUATE 324 ;taille du tableau en octets
ptr:             .BLOCK 2    ;#2h

jeuTab:          .ADDRSS j1 ;#2h
                 .ADDRSS j2 ;#2h
                 .ADDRSS j3 ;#2h
                 .ADDRSS j4 ;#2h
                 .ADDRSS j5 ;#2h
                 .ADDRSS j6 ;#2h
                 .ADDRSS j7 ;#2h
                 .ADDRSS j8 ;#2h
                 .ADDRSS j9 ;#2d

j1:              .BLOCK 36 ; #2d18a 
j2:              .BLOCK 36 ; #2d18a 
j3:              .BLOCK 36 ; #2d18a 
j4:              .BLOCK 36 ; #2d18a 
j5:              .BLOCK 36 ; #2d18a 
j6:              .BLOCK 36 ; #2d18a
j7:              .BLOCK 36 ; #2d18a 
j8:              .BLOCK 36 ; #2d18a 
j9:              .BLOCK 36 ; #2d18a

line:            .BLOCK 2 ;#2d itérateur line pour tri
column:          .BLOCK 2 ;#2d itérateur column pour tri
range:           .WORD  1
range1:          .WORD  1
range2:          .WORD  1
temp_i:          .BLOCK 2
temp_j:          .BLOCK 2
mer:             .EQUATE 0x007E
etoile:          .EQUATE 0x002A
hori:            .EQUATE 0x003E
verti:           .EQUATE 0x0076
null:            .EQUATE 0x006F

g:               .BYTE  0 ; Grandeur
hv:              .BYTE  0 ; ORIENTATION
col:             .BYTE  0 ; Colonne
r:               .BYTE  0 ; rangee
space:           .BYTE  0 
nbCase:          .BYTE  0 ; Grandeur case

                 .END