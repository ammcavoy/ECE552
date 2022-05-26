// Write your assembly program for Problem 2 (a) #1 here.

lbi r1, 100
lbi r2, 1

.label1:
sub r1, r2, r1
beqz r1, .label2
bnez r1, .label1

.label2:
halt
