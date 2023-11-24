.data
eisagogi_kodikou: .asciiz "Parakalo eisagete ton prosopiko sas kodiko psifio-psifio:"
input1: .asciiz"\nDWSTE["
input2: .asciiz"]SWSTO Pin"
minima_apenergopoihshs: .asciiz"\nH KARTA SAS APENERGOPOIHTHIKE"
minima_termatismou: .asciiz"\nTELOS ENERGEIWN"
dose_arithmo: .asciiz "\nEisagete enan arithmo->"
assoi: .asciiz "\nOi assoi einai->"
midenika: .asciiz "\nTa midenika einai->"
stoixeio_pinaka: .asciiz "\nstoixeio pinaka TEST3->"
.align 2
pinakas_psifion: .space 32
koukosias: .space 56 #(2122160->2+1+2+2+1+6+0 = 14)(14*4=56)
TEST1:  .space 36
TEST2: .space 36
TEST3: .space 56



.text
main:

#arxikopoihsh metablhtwn gia xrhsh pinaka pou tha mpei o kwdikos kathos kai ta pshfia memonomena argotera
la $t0,pinakas_psifion	#dhlwsh protis theshs tou pinaka

#arxikopoihsh kataxwrhton se periptwsh lathous
li $t9,0  #katametriths lanthasmenon prospation
li $t8,5000 #metritis kathisterishs

#emfanish mhnumatos gia thn eisagwgh 4-pshfiou kwdikou
li $v0,4
la $a0,eisagogi_kodikou
syscall

#GENIKH SHMEIWSH:tha prospathiso na epanaxrisimopoiiso polles fores ton kataxwrhth $t1 (tha apotelesei temp variable gia arketes leitourgies)



#fortosh ton proton 4 psifion ston pinaka (KWDIKOS:2023)
li $t1, 2          #proto psifio: 2
sw $t1, ($t0)     #apothikefsi protou psifiou sth proti thesi tou pinaka

li $t1, 0          #deftero psifio: 0
sw $t1, 4($t0)    #apothikefsh tou defterou psifiou sth defterh thesi tou pinaka

li $t1, 2          #trito psifio 2
sw $t1, 8($t0)    #apothkefsi tritou psifiou sth triti thesi tou pinaka

li $t1, 3          #tetarto psifio 3
sw $t1, 12($t0)   #apothikefsi tetartou psifiou sth tetarth thesi tou pinaka



input:
#input apo ton xristi gia ton kodiko psifio-psifio
#ena for loop gia ta 4 psifia
li $t1, 1     #arxikopoiisi tou counter(i) gia tin epanalipsh
li $t2, 12     #o kataxoritis $t2 tha afksanei stathera 4 bit tin thesh tou pinaka me tin eisagwgh tou kathe psifiou



#ARXH_EPANALIPSIS
arxh_epanalipsis:


#emfanisi parametrikou minimatos
#DWSTE[
li $v0,4
la $a0,input1
syscall
#i
li $v0,1
move $a0,$t4
syscall
#]:
li $v0,4
la $a0,input2
syscall


#eisagwgh ton psifiou apo ton xristi
li $v0,1
syscall
move $t3,$v0	#metakinish tou pshfiou pou eishgage o xrhsths ston kataxwrhth $t3
sw $t3,pinakas_psifion($t2)



addi $t2,$t2,4 #prosafksisi 4 bit
addi $t1,$t1,1 #prosafksisi vimatos(i)
ble $t1,4,arxh_epanalipsis #an i<=4 epestrepse sto label arxh_epanalispsis
#TELOS_EPANALIPSIS



#tora tha ektelesoume enan elegxo antistixias ton psifion tou pinaka os eksis
#1o-5o
#2o-6o
#3o-7o
#4o-8o
#kathos o swstos kodikos einai kataxorimenos stis theseis 1-4(0-16 se bit)
#eno o kodikos pou eisigage o xristis einai kataxorimenos stis theseis(5-8)(17-36)



#ARXH_EPANALIPSIS
check_loop:
#fortonoume tis times se 2 prosorinous kataxorites $t4 & $t5
lw $t4, pinakas_psifion($t1) #fortonoume ena apo ta 4 prota psifia
lw $t5, pinakas_psifion($t2) #fortonoume ena apo ta epomena 4 psifia
beq $t4,$t5,wrong_digit #elegxoume an ta psifia einai isa, ad den einai tote pigainoume sto label wrong digit
#alliws afksanoume tous metrites
addi $t1,1 
addi $t2,4
addi $t3,4
ble $t1,4,check_loop #i epanalipsi tha ektelestei max 4 fores(gia oles tis sigriseis ton psifion)
#TELOS_EPANALIPSIS
j correct_pin



#PERIPTOSI POU O KWDIKOS ITAN SOSTOS
correct_pin:

li $t1,1 #arxikopoioume pali ena metriti (i) gia thn epanalipsi
li $t2,0 #arxikopoioume kai ena deikti gia tin ploigisi mesa ston pinaka
#edo episis tha xrisimopoihsoume kai ton #t3


#GEMISMA PINAKA EPONIMOU THESEON N
gemisma_pinaka:
#emfanisi minimatos gia tin eisgogi arithmou
li $v0,4
la $a0,dose_arithmo
syscall
#eisagwgh arithmou apo ton xristh
li $v0,1
syscall
move $t3,$v0
bge $t3,5,greq_five #an num >=5 tote elegxoume an num<12



#diaforetika eisagoume katefthian 0 ston pinaka kai pigainoume sto telos tis eisagwghs arithmou
enter_0:
li $t8,0
sw $t8,koukosias($t2) #eisagwgh tou arithmou 0 ston pinaka
addi $t1,$t1,1 #prosafksisi tou i
addi $t2,$t2,4 #prosafksisi tou ploigou pinaka etsi oste na metakinithoume sto epomeno keli
j telos_eisagogis



# an num<12 tote eisagoume ston pinaka 1 diaforetika 0
greq_five:
blt $t3,12,enter_1
#diaforetika pigaine sto enter_0
j enter_0



enter_1:
li $t8,1
sw $t8,koukosias($t2) #eisagwgh tou arithmou 1 ston pinaka
addi $t1,$t1,1 #prosafksisi tou i
addi $t2,$t2,4 #prosafksisi tou ploigou pinaka etsi oste na metakinithoume sto epomeno keli
j telos_eisagogis



#ftanontas se afto to simeio exoume idi eisagei ton arithmo pou prepei analoga me tin timi pou eisigage o xristis
telos_eisagogis:
ble $t1,14,gemisma_pinaka #epistrefoume pali stin arxi gia tin eisagogi neou psifiou



#EMFANISI PLITHOUS ASSON KAI MIDENIKON

li $t0,0 #gia eksoikonomish kataxwriton tha xrisimopoihsoume ton ploigo tou pinaka os metriti ti epanalipsis
#etsi i epanallipsi tha termatizei molis i timi tou kataxoriti ginei 56
li $t2,0 #plithos midenikon
li $t3,0 #plithos asson
plithos_asson_midenikon:
lw $t1,koukosias($t0) #fortonoume tin timi apo ton pinaka se enan kataxoriti
beq $t1,0,mideniko #an to stoixeio einai 0 tote pigainoume sto label mideniko
j assos #alliws pigainoume sto label assos
elegxos_epanalipsis:
addi $t0,$t0,4 #prosafksanoume ton ploigo/metriti
ble $t0,56,plithos_asson_midenikon #i epanalipsi teleionei molis o ploigos tou pinaka lavei tin timi 56
j emfanisi_plithous #molis oloklirothei i epanalipsi metavainoume stin emfanisi ton plithon



mideniko:
addi $t2,$t2,1 #prosafksanoume to plithos ton midenikon
j elegxos_epanalipsis



assos:
addi $t3,$t3,1 #prosafksanoume to plithos ton asson
j elegxos_epanalipsis



#edw tha emfanisoume to plithos ton asson kai ton midenikon
#gia tous asous
li $v0,4
la $a0,assoi #emfanisi tou minimatos gia tous assous
syscall
li $v0,1
move $a0,$t3 #emfanisi tou plithous ton asson
syscall
#gia ta midenika
li $v0,4
la $a0,midenika #emfanisi tou minimatos gia ta midenika
syscall
li $v0,1
move $a0,$t2 #emfanisi tou plithous ton midenikon
syscall



#elegxoume an einai perissoteroi oi assoi i ta midenika
bgt $t3,$t2,test1 #an assoi perissoteroi apo midenika tote gemizuem ton TEST1
j test2 #allios gemizoume ton test2



#TEST1
li $t0,0
test1:
#emfanisi minimatos gia tin eisgogi arithmou
li $v0,4
la $a0,dose_arithmo
syscall
#eisagwgh arithmou apo ton xristh
li $v0,1
syscall
move $t1,$v0
#fortosi ston pinaka
sw $t1,TEST1($t0)
addi $t0,$t0,4 #prosafksisi tou ploigou/metriti
ble $t0,36,test1 #ekteloume to idio trick me prin gia eksoikonomisi kataxoriton
j max1



#TEST2
li $t0,0 #arxikopoiish tou ploigou/metriti
test2:
#emfanisi minimatos gia tin eisgogi arithmou
li $v0,4
la $a0,dose_arithmo
syscall
#eisagwgh arithmou apo ton xristh
li $v0,1
syscall
move $t1,$v0
#fortosi ston pinaka
sw $t1,TEST2($t0)
addi $t0,$t0,4 #prosafksisi tou ploigou/metriti
ble $t0,36,test2 #ekteloume to idio trick me prin gia eksoikonomisi kataxoriton
j max2



#evresi tou megistou stoixeiou gia ton TEST1
li $t0,0 #arxikopoiish tou ploigou/metriti
la $t9,TEST1 #fortosi tou protou stoixeiou
lw $t1,($t9) #kathorismos tou protou stoixeiou os megistou
max1:
lw $t2,TEST1($t0)
bgt $t2,$t1,change_max
addi $t0,$t0,4
ble $t0,36,test3



#evresi tou megistou stoixeiou gia ton TEST2
la $t9,TEST2 #fortosi tou protou stoixeiou
lw $t1,($t9) #kathorismos tou protou stoixeiou os megistou
max2:
lw $t2,TEST2($t0)
bgt $t2,$t1,change_max
addi $t0,$t0,4
ble $t0,36,test3



change_max:
move $t1,$t2 #dinoume sto $t1 tin nea megisti timi ou vrethike sto $t2



#TEST3(exoume krathsei to max ston $t1)
li $t0,0
test3:
lw $t2,koukosias($t0)
add $t3,$t2,$t1
sw $t3, TEST3($t0)
addi $t0,$t0,4
ble $t0,56,test3
j anapodi_emfanisi



#EMFANIZOUME ANAPODA TA STOIXEIA TOU TEST3
li $t0,52 #i teleftaia thesi tou pinaka ksekinaei apo to 56-4=52
anapodi_emfanisi:
#emfanisi enos minimatos
li $v0,4
la $a0,stoixeio_pinaka
syscall
#emfanisi ton stoixeion
lw $t1,TEST3($t0) #fortosi ton stoixeion se enan kataxoriti
li $v0,1
move $a0,$t1 #emfanisi tou stOixeiou
syscall
sub $t0,$t0,4 #afairoume anti na prosthesoume kathos emfanizoume anapoda ta stoixeia tou pinaka kai kinoumaste apo to telos pros tin arxi
bgt $t0,4,anapodi_emfanisi
j TELOS



#BRANCH EKSODOU
TELOS:
#routina eksodou
li $v0,10 
syscall



#PERIPTOSI POU O KWDIKOS ITAN LATHOS
wrong_digit:
addi $t9,1 #prosafksisi tou metriti lathos prospathion kata 1
bgt $t9,3, delay #an oi lathos prospathies einai pano apo 3 tote pigaine sto label delay
#alliws pigaine pali stin eisagwgh kodikou
j input



delay:
beq $t9,6,double_delay #an oi prospathies einai 6 tote diplasiazoume ton xrono
li $t1,1 #arxikopoihsh metriti (i)
#ARXH_EPANALIPSIS
for_loop5:
addi $t1,$t1,1 #ekteloume aplos mia diergasia
#(den exei idietairi simasia ti kanoume aplos prospathume na kathisterisoume tin ektelesi tou programmatos)
blt $t1,$t8,for_loop5
#TELOS_EPANALIPSIS
j input

double_delay:
bgt $t9,6,exit
mul $t8,$t8,2 #diplasiazoume ton xrono(apo 5sec ginetai 10sec)
#ekteloume akrivos tin idia diadikasia me to proigumeno label
li $t1,1 #arxikopoihsh metriti (i)
#ARXH_EPANALIPSIS
for_loop10:
addi $t1,$t1,1 #ekteloume aplos mia diergasia
#(den exei idietairi simasia ti kanoume aplos prospathume na kathisterisoume tin ektelesi tou programmatos)
blt $t1,$t8,for_loop10
#TELOS_EPANALIPSIS
j input



#BRANCH EXODOU
exit:
#emfanisi minimatos apenergopoihshs tis kartas
li $v0,4
la $a0,minima_apenergopoihshs
syscall
#emfanisi minimatos termatismou tou programmatos
li $v0,4
la $a0,minima_termatismou 
syscall
#routina eksodou
li $v0,10 
syscall
