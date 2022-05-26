// Write your assembly program for Problem 1 (a) #1 here.
//SEQ Rd, Rs, Rt 
//if (Rs <= Rt) then Rd = 1 else Rd = 0

lbi r1, 5
lbi r2, 5
SEQ r3, r1, r2
//should return a 1 since r1 == r2
halt
