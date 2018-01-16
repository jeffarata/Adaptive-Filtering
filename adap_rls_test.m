% Jeff Arata
% 1/8/18

% This script tests out the RLS adaptive filtering algorithm in the 
% function adap_rls.

clear;
clc;

[x, fs] = audioread('oboe.wav');
t_end = length(x)/fs;
t = 0:1/fs:t_end-1/fs;

M = 128;
cutoff = (fs/4)/(fs/2);
b_headphone = fir1(M, cutoff);
x = filter(b_headphone, 1, x+0.1*randn(length(x),1));      % Our input signal affected by filter h
d = zeros(length(x), 1);

lambda = 1;             % Forgetting factor
delta = 0.005;

tic
[e, h_out] = adap_rls( x, d, M+1, lambda, delta );
toc

figure(2)
subplot(3, 1, 1)
plot(t, x)
axis([0 1.1 -1.5 1.5])
title('Input Signal, Ambient Noise Through Headphones')
subplot(3,1,2)
plot(t, d, 'g')
axis([0 1.1 -1.5 1.5])
subplot(3,1,3)
title('Desired Signal, Silence within Headphones')
plot(t, e, 'r')
axis([0 1.1 -1.5 1.5])
title('Error Between Desired Signal and Adaptive Filter Output of Ambient Noise')
xlabel('Time in Seconds')