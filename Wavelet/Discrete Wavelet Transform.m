close all;clear;clc;

f   = 10;        % Signal Frequency
Fs  = 1000;      % Sampling Frequency
Ts  = 1/Fs;      % Period (T)
N   = 1;         % Signal Length
t   = 0:Ts:N-Ts; % Time Matrix

%% Generate Signal x[n]
x = sin(2*pi*f*t); 

%% Generate White Noise
i = awgn(x,10,'measured');
y = x + i;

%% Komputasi DWT Level 3 DB4
[baris,kolom] = size (y); 
waveletFunction = 'db3';
for j=1:kolom
    [A3,D1,D2,D3] = DB4_Lv3(y,waveletFunction);
end

%% Plot DWT Level 3 DB4
figure; title('DWT level 3 - Daubechies4');
subplot(4,1,1); plot(y, 'g'); hold on;plot(A3,'k', 'LineWidth',1.5);
    title ('A3'); legend('Noisy Signal','Denoised with Lv3')
subplot(4,1,2);plot(D1)
    title ('D1')
subplot(4,1,3);plot(D2)
    title ('D2')
subplot(4,1,4);plot(D3)
    title ('D3')

%% DWT Level 4 DB4 Computation
[baris,kolom] = size (y); 
waveletFunction = 'db4';
for j=1:kolom
    [A4,D1,D2,D3,D4] = DB4_Lv4(y,waveletFunction);
end

%% Plot DWT Level 4 DB4
figure; title('DWT level 4 - Daubechies4')
subplot(5,1,1); plot(y, 'g'); hold on;plot(A4,'k', 'LineWidth',1.5);
    title ('A4'); legend('Noisy Signal','Denoised with Lv3')
subplot(5,1,2);plot(D1)
    title ('D1')
subplot(5,1,3);plot(D2)
    title ('D2')
subplot(5,1,4);plot(D3)
    title ('D3')
subplot(5,1,5);plot(D4)
    title ('D4')

% Plot Comparison
figure;
subplot(3,1,1)
    plot(x,'k', 'LineWidth',1.5); hold on; plot(A3, 'r');
    xlabel('Time (ms)'); ylabel('Amplitude');ylim([-2 2]);
    title ('DWT Level 3'); 
    legend('Original Signal','Denoised with Lv3')
subplot(3,1,2)
    plot(x,'k', 'LineWidth',1.5); hold on; plot(A4, 'b');
    xlabel('Time (ms)'); ylabel('Amplitude');ylim([-2 2]);
    title ('DWT Level 4'); 
    legend('Original Signal','Denoised with Lv4')
subplot(3,1,3)
    plot(x,'k', 'LineWidth',1.5); hold on; plot(A3, 'r');plot(A4, 'b');
    xlabel('Time (ms)'); ylabel('Amplitude');ylim([-2 2]);
    title ('Comparison'); 
    legend('Original Signal','Denoised with Lv3','Denoised with Lv4')
