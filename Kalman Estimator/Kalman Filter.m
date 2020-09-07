%% Kalman Estimator Application for Denoising Random Signal
% Generating a Randomly-Disturbed Sinusoidal Signal and denoise it
% by Estimating the Original Signal value using Kalman Estimator

%% Initialization
Sig = 10;        % Signal Amplitude
Noi = 1;         % Noise Amplitude
f   = 7;         % Signal Frequency
Fs  = 500;       % Sampling Frequency
Ts  = 1/Fs;      % Periode
N   = 5;         % Signal Length
t   = 0:Ts:N-Ts; % Time Matrix 
Limx= [0 0.2];   % X-Limit Value in graph

% Generate Signal x[n]
x = Sig*cos(2*pi*f*t); 

% Generate Random Signal
i = Noi*rand(1,length(t));  %Positive Random Signal 
y = x + i;

%% Denoising with Kalman Estimator

%  Kalman Filter Parameters Initialization
w    = 2*pi*f*Ts;      % Frequency Velocity
Q    = 0.001;          % Process Noise Variance
in   = mean(i);        % Mean of Signal+Noise
X0   = [y(1) y(2)]';   % Matrix for Pre-estimation signal
P0   = Q;              % Error Estimation Covariance
X_pri = X0;            % A-priori of Signal
P_pri = P0;            % A-priori of Estimated Signal
R = 0.01;              % Measurement (Simulated) Noise Covariant

%  Kalman Equation Matrix
A = [2*cos(w) -1 ; 1 0];         
B = [1 0]';
C = [1 0];                       

%  Matrices for storing values
Length  = length(y);
xpost   = zeros(2,Length);
ppost   = zeros(2,2,Length);
xpri    = zeros(2,Length);
ppri    = zeros(2,2,Length);
Kgain   = zeros(2,Length);

%  Kalman Filter Iteration (Looping)
for k = 1 : Length
    
    % Update and Save the Estimated A-Priori X Value
    xpri(:,k) = X_pri';
    ppri(:,:,k) = P_pri';

    % Update the simulated measurement value
    Y_Pri = C*X_pri + in;
    
    % Calculate the Kalman Gain 
    K = P_pri*C'/(C*P_pri*C'+ R');  % Kalman Gain
     
    % Estimation Correction
    X_post = X_pri + K*(y(k) - Y_Pri);                % Signal Estimation  
    P_post =(eye(2)-K*C)*P_pri*(eye(2)-K*C)'+K*R*K';  % Error Covariance Optimalization
                           
    % Prediction
    X_pri = A*X_post;                 % Update signal estimation
    P_pri = A*P_post*A' + B*Q*B';     % Update Error Covariance value

    % Update and Save Posteriori X Value
    xpost(:,k) = X_post';
    ppost(:,:,k) = P_post';
    Kgain(:,k) = K;
end

x_post_plot = xpost(1,:);
x_prior_plot = xpri(1,:);
kalman_plot = Kgain(1,:);
%% Plot Signal in Time Function

figure('Name','Plot','NumberTitle','off');
plot(t,x,'k','LineWidth',1.5); hold on; 
    xlabel('Time (s)');
    xlim(Limx);ylim([-20 20])
plot(t,i); hold on;
plot(t,y, 'r');

figure
plot(t,x,'k','LineWidth',1.5);hold on;plot(t,y,'r');
    xlabel('Time (s)'); title('Original Signal + Noise (Distracted)');
plot(t,x_prior_plot,'b','LineWidth',1);
plot(t,x_post_plot,'g','LineWidth',1);
    title('Comparation');
    legend('Original Signal','Original Signal + Noise','A Priori','Posteriori')
    
figure('Name','Comparison Plot','NumberTitle','off');
subplot(2,2,1)
plot(t,x,'k','LineWidth',1.5); hold on; 
plot(t,y,'r'); hold on;
    xlabel('Time (s)');
    title('Initial & Distracted Signal');
xlim(Limx)
ylim([-15 15])

subplot(2,2,4)
plot(t,x,'k','LineWidth',1.5); hold on; 
plot(t,x_post_plot,'g','LineWidth',1);
    xlabel('Time (s)');
    title('Posteriori Estimation & Original Signal');
xlim(Limx)
ylim([-15 15])
    
subplot(2,2,2)
plot(t,x,'r'); hold on;
    xlabel('Time (s)');
plot(t,x_prior_plot,'b','LineWidth',1);;
    title('A Priori Estimation & Original Signal');
xlim(Limx)
ylim([-15 15])

subplot(2,2,3)
plot(t,x_post_plot,'r','LineWidth',1);hold on;
    xlabel('Time (s)');
plot(t,x_prior_plot,'b','LineWidth',1);;
    title('A Priori & Posteriori Estimation');
xlim(Limx)
ylim([-15 15])
