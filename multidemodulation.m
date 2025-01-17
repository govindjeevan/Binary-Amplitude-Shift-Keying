clc;
clear all;
close all;


x=[ 1 0 2 1 0 2 1];                                    % Binary Information
bp=.000001;                                                    % bit period
disp(' Multiamplitude information at Trans mitter :');
%disp(x);

%XX representation of transmitting multilevel information as digital signal XXX
bit=[]; 
for n=1:1:length(x)
    if x(n)==1;
       se=ones(1,100);
    elseif x(n)==0;
        se=zeros(1,100);
    else
        se(1:1,1:100)=2;
    end
     bit=[bit se];

end
t1=bp/100:bp/100:100*length(x)*(bp/100);
%subplot(3,1,1);
%plot(t1,bit,'lineWidth',2.5);grid on;
%axis([ 0 bp*length(x) -.5 3.0]);
%ylabel('amplitude(volt)');
%xlabel(' time(sec)');
%title('transmitting information as digital signal');



%XXXXXXXXXXXXXXXXXXXXXXX Binary-ASK modulation XXXXXXXXXXXXXXXXXXXXXXXXXXX%
A1=10;                      % Amplitude of carrier signal for information 1
A2=5;                       % Amplitude of carrier signal for information 0
A3=12;                      % Amplitude of carrier signal for information 2
br=1/bp;                                                         % bit rate
f=br*10;                                                 % carrier frequency 
t2=bp/99:bp/99:bp;                 
ss=length(t2);
m=[];
for (i=1:1:length(x))
    if (x(i)==1)
        y=A1*cos(2*pi*f*t2);
    elseif (x(i)==0)
        y=A2*cos(2*pi*f*t2);
    else
        y=A3*cos(2*pi*f*t2);
    end
    m=[m y];
end
t3=bp/99:bp/99:bp*length(x);
subplot(3,1,1);
plot(t3,m);
xlabel('time(sec)');
ylabel('amplitude(volt)');
title('waveform for binary ASK modulation coresponding binary information');


%XXXXXXXXXXXXXXXXXXXX Binary ASK demodulation XXXXXXXXXXXXXXXXXXXXXXXXXXXXX
mn=[];
for n=ss:ss:length(m)
  t=bp/99:bp/99:bp;
  y=cos(2*pi*f*t);                                        % carrier siignal 
  mm=y.*m((n-(ss-1)):n);
  t4=bp/99:bp/99:bp;
  z=trapz(t4,mm)                                              % intregation 
  zz=round((3*z/bp))                                     
  if(zz>15)                                  % logic level = (A1+A2)/2=7.5
    a=2;
  elseif(zz>7)
    a=1;
  else
    a=0;
  end
  mn=[mn a];
end
disp(' Binary information at Reciver :');
disp(mn);


%XXXXX Representation of binary information as digital signal which achived 
%after ASK demodulation XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
bit=[];
for n=1:length(mn);
    if mn(n)==1;
       se=ones(1,100);
    elseif mn(n)==0;
        se=zeros(1,100);
    else
        se(1:1,1:100)=2;
    end
     bit=[bit se];

end
t4=bp/100:bp/100:100*length(mn)*(bp/100);
subplot(3,1,3)
plot(t4,bit,'LineWidth',2.5);grid on;
axis([ 0 bp*length(mn) -.5 3.0]);
ylabel('amplitude(volt)');
xlabel(' time(sec)');
title('recived information as digital signal after multilevel ASK demodulation');

