clc; clear all; close all; 

%% Variable Declaration
x  = load ('AlphaRhythm_5seconds.mat');
x  = x.alpha_5seconds;
fs = 250;                 % sampling frequency 
N  = length(x);           % signal/data length
N1 = 512;                 % wavelet points 
wo = pi*sqrt(2/log2(2));  % wavelet scaling frequency 
b  = (1:N)/fs;            % time vector
ti = ((1:N1/2)/fs)*10;    % time vector for wavelet generator 
resol_level = 128;        % scaling points/resolution
decr_a = .5;               
a_init = 4;                

%% Computational Process
for i = 1:resol_level 
    a(i) = a_init/(1+i*decr_a);     % scale set
    t = abs(ti/a(i));               % wavelet scaling vector 
        % Choose one Mother Wavelet
        mw = (exp(-t.^2).*cos(wo*t))/sqrt(a(i));    % Morlet
        mw = (1-(2*(t.^2))).*exp(-t.^2);            % Mexican Hat
    wavelet = [fliplr(mw) mw];      % generate mirrored wavelet 
    ip = conv(x, mw);               % wavelet and signal convolution
    ex = fix((length(ip)-N)/2);     
    CW_Trans(:,i) = ip(1,ex+1:N+ex); 
end  

%% Graph Plotting
figure('Name','Raw Signal')
plot (b,x)
title('Alpha Rhythm 5 Seconds')
xlim([0 5])
xlabel('Time (s)') 
ylabel('Amplitude') 

% 3d Transformed Graph
figure('Name','Wavelet Transformation')
    d = fliplr(CW_Trans); 
    mesh(a,b,CW_Trans) 
        xlabel('Scale') 
        ylabel('Time (s)') 
        zlabel('CWT') 
        title('CWT with Mexican Hat Mother Wavelet') 
    rotate3d on 
