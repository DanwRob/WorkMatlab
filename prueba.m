clear all; clc; close all;
%// example 1 :
x=66;
str=dec2bin(x,8)

%// example 2 :
%// The binary representation of 86 is: '1010110'.
%// Its length is 7 (less than n).// We add to str 8 times the character '0' (on the left).
x=86;
n=15;
str=dec2bin(x,n)

%// example 3 :
x=[12;45;135]
z=dec2bin(x)