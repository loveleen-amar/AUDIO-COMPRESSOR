clc;
clear all;
close all;
[funky,fs] = audioread('funky.wav');
l_initial = length(funky);
input_details = audioinfo('funky.wav');
X = dct(funky);
l_dct_of_intial = length(X);
[XX,ind] = sort(abs(X),'descend');
while norm(X(ind(1:i)))/norm(X) < 0.90 %Calculating The indices which take part of 99% of energy in the signal
   i = i + 1;
end
needed = i;
X(ind(needed+1:end)) = 0;
xx = idct(X);
l_reconst = length(xx);
if l_initial == l_reconst
    disp('Inital and Reconstructed have same lengths')
end;
figure;
subplot(2,1,1);
plot([funky]);
title('Plot Of Initial Audio Signal');
inp_det = input_details.BitsPerSample;
xlabel('Magnitude');
ylabel('Time');
subplot(2,1,2);
plot([xx]);
title('Plot Of Compressed Audio Signal');
bps = inp_det/2'
xlabel('Magnitude');
ylabel('Time');
figure;
plot([funky,xx]);
legend('Original','Compressed');
audiowrite('comp1.wav',xx,fs,'BitsPerSample',bps);%writing the final output to comp1.wav file
initial_file = dir('funky.wav'); 
final_file = dir('comp1.wav');
initial_file_size = initial_file.bytes;
final_file_size = final_file.bytes;
disp('Compressed By:');
disp(initial_file_size-final_file_size);
comp_perc = (((initial_file_size)-(final_file_size))/initial_file_size)*100;
disp('Compression Percentage:')
disp(comp_perc);
