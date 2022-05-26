// Write your assembly program for Problem 1 (a) #2 here.
// Write your assembly program for Problem 1 (a) #1 here.
//SEQ Rd, Rs, Rt 
//if (Rs <= Rt) then Rd = 1 else Rd = 0

lbi r4, 0

lbi r1, 5

lbi r2, 10
st r2, r4, 0
ld r5, r4, 0
SEQ r3, r5, r1
//should return a 0, since r5 > r1
halt
