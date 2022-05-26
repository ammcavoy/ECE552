// Write your assembly program for Problem 2 (a) #2 here.

lbi r1, 25

.label1:
bnez r1, .label6
 

.label2:
beqz r1, .label1

.label3:
bnez r1, .label5

.label4:
halt

.label5:
bnez r1, .label4

.label6:
bnez r1, .label2
