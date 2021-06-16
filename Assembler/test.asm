# all numbers in hex format
# we always start by reset signal
# this is a commented line
.ORG 0  #this means the the following line would be  at address  0 , and this is the reset address
10
#you should ignore empty lines

.ORG 2  #this is the interrupt address
100

.ORG 10
inc R1	       #R1 =00000000 , C --> 1 , N --> 0 , Z --> 1
inc R2	       #R1= 5,add 5 on the in port,flags no change	
inc R1          #R2= 10,add 10 on the in port, flags no change