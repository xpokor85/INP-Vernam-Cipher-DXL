; Vernamova sifra na architekture DLX
; Martin Pokorný xpokor85

        .data 0x04          ; zacatek data segmentu v pameti
login:  .asciiz "xpokor85"  ; <-- nahradte vasim loginem
cipher: .space 9 ; sem ukladejte sifrovane znaky (za posledni nezapomente dat 0)

        .align 2            ; dale zarovnavej na ctverice (2^2) bajtu
laddr:  .word login         ; 4B adresa vstupniho textu (pro vypis)
caddr:  .word cipher        ; 4B adresa sifrovaneho retezce (pro vypis)

        .text 0x40          ; adresa zacatku programu v pameti
        .global main        ; 

main:   
	addui r11, r0, 112        ; p #70 112    ; r11 bude registr na p
	addui r13, r0, 111        ;o #6f  111	     ; r13 bude registr na o
	xor r9, r9, r9
jump:             
	lb r19, login+0(r9)
	sleui r27, r19, 57
	bnez r27, end
	nop
	nop
	addu r19, r19, r11
	sleui r27,r19, 219
	bnez r27, sub97
	nop
	nop
	subui r19, r19, 122
	j cnt
	nop
	nop
sub97:	
	subui r19, r19, 97
cnt:
	sb cipher+0(r9), r19
	addui r9, r9, 1  ; r9 bude ukládat index zpracovávaného znaménka       
	
	lb r19, login+0(r9)
	sleui r27, r19, 57
	bnez r27,end
	nop
	nop
	sub r19, r19, r13
	slei r27, r19, 0
	bnez r27, a122
	nop
	nop
	addui r19, r19, 96

back:	sb cipher+0(r9), r19
	addui r9, r9, 1  
	j jump
	nop
	nop

a122:	
	addui r19, r19, 122
	j back
	nop
	nop

end:    sb cipher+0(r9), r0
	addi r14, r0, caddr ; <-- pro vypis sifry nahradte laddr adresou caddr
        trap 5  ; vypis textoveho retezce (jeho adresa se ocekava v r14)
        trap 0  ; ukonceni simulace
