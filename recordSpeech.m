clear; clc;

fs = 10000;

recorder = audiorecorder(fs, 8,1);
recordblocking(recorder,2); %recorder turned ON for 2 seconds

play(recorder)

%y - Array to store the recorded data
y = getaudiodata(recorder);
filename = 'speech2.wav';

%Write data in y to .wav file
audiowrite('speech2.wav', y, 10000);
