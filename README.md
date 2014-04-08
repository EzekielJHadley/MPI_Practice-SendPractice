MPI_Practice-SendPractice
============================

This simple program is a step above a simple HelloWorld in using MPI. The point was to practice the use of 
MPI's send and recieve functions to send information from one node on the supercomputer to another. In this
program the even numbered nodes send a number to the odd number nodes and then listen for the odd number
nodes to respond back. Then they check that they had communicated.