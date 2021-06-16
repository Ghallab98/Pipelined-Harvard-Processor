# all numbers in hex format
# we always start by reset signal
#this is a commented line
.ORG 0  #this means the the following line would be  at address  0 , and this is the reset address
10
#you should ignore empty lines

.ORG 2  #this is the interrupt address
100

.ORG 10
in R2        #R2=19 add 19 in R2
in R3        #R3=FFFF
in R4        #R4=F320
in R1     #R1=5
NOP
NOP
NOP
#PUSH R1      #SP=FFFFFFFC,M[FFFFFFFE]=5
NOP
NOP
NOP
PUSH R2      #SP=FFFFFFFA,M[FFFFFFFC]=19
NOP
NOP
NOP
POP R1       #SP=FFFFFFFC,R1=19
NOP
NOP
NOP
POP R2       #SP=FFFFFFFE,R2=5
NOP
NOP
NOP
in R5        #R5= 10
NOP
NOP
NOP
STD R2,200(R5)   #M[210]=5
NOP
NOP
NOP
STD R1,202(R5)   #M[212]=19
NOP
NOP
NOP
in R3   #R3=19
NOP
NOP
NOP
in R4   #R4=5
NOP
NOP
NOP