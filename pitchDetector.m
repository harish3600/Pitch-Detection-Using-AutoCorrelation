clear; clc;

%Read data from speech2.wav file
[y, fs]  =audioread('speech2.wav');
subplot(2,1,1);
plot(y)
title('Amplitude of Speech Signal');
ylabel('Amplitude'); xlabel('Sample Number');

%Calculating the AutoCorrelation of N samples of the signal y
x  = (y(18000 : 20000)); %Considering 2000 samples of X

Rxx = zeros(1,320);
N = 32; %Consider N overlapping samples of x

for shiftIndex = 1:320
       for k = 1:N
           Rxx(shiftIndex) = Rxx(shiftIndex) + (x(k) .* x(k+shiftIndex));
           Rxx(shiftIndex) = Rxx(shiftIndex)/N;
       end
end
Rxx;
subplot(2,1,2);
plot(Rxx)
xlim([0  330]);
title('Autocorrelation of Speech Signal');
ylabel('R_{xx}(n)'); xlabel('n');

%Calculating the pitch of the speech signal

[peaks, indices] = findpeaks(Rxx) ;%Returns indices and values of local maximma in correlation data (Rxx)
min (fs./diff(indices)); mean(fs./diff(indices)); max(fs./diff(indices)); 

[mm, peak1_ind] = min ((fs./diff(indices))); 
period=indices(peak1_ind+1)-indices(peak1_ind); %comparing the "time" between peaks 
pitch_Hz = fs/period; 

disp(sprintf('The estimated pitch of the speech signal is %.2f Hz',pitch_Hz)); 

[audioIn,fs] = audioread('speech2.ogg');
f0 = pitch(audioIn,fs);

maxf0 = max(f0);
disp(sprintf('The pitch of the speech signal (using MATLAB pitch function) is %.2f', maxf0));
