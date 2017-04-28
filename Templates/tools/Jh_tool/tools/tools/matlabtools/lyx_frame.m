%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%������Ϣ%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%--1.����������������������źŽ��з�֡����

%--2.��������� x:           Nx1 speech signal vector, typically an utterance in the time domain(�����ź�ʸ��)
%Note: x is zero-padded to be of length m*l
%               windowsize:  Number of points to consider in each window of speech(����)
%               overlap:     Number of samples between two frames(��֮֡���ص��ĵ���)
%               fs:          sampling frequency(ȡ��Ƶ��)

%%--3.���������y:           mxl matrix, where each column is a frame of x (l frames in x)

%%--4.�����Ϣ�����ʱ�䣺 2006-11-4�� �����Ա��������

%%--5.�ο����׻���վ
%   

%%--6.����˼�룺 ���������������֡����֡�ƣ�ȡ��Ƶ�ʣ����źŽ��мӴ�������������֡

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%��������%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function y =lyx_frame(x,windowsize,overlap,fs)
if size(x,1)>1 & size(x,2)>1
   error('x is not Nx1 vector!');
   return
end;
if nargin<4,
   fs = 11025; % If fs isn't global, set to 11025 KHz
end;
if nargin<3,
   frameRate = windowsize/2;
end;
if nargin<2,
   if fs==22050,
      windowsize = 512; % 23.22 ms at 22.05KHz
   elseif fs==11025,
      windowsize = 256; % 23.22 ms at 11.025 KHz
   elseif fs==8000,
      windowsize = 128; % 16 ms at 8KHz
  else
      windowsize = 256;
   end;
end;
if size(x,2)>1,
   x = x'; % Convert to coulmn vector
end;
N=length(x);%length of speech signal
p=windowsize-overlap; % Increment by p samples between frames
m=windowsize;%size of per frame
l = ceil((N-m+p)/p); % Number of frames in y
x = [x;zeros(m+(l-1)*p-N,1)]; % Zero-pad to fit in m*l matrix
y = zeros(m,l); % Declare space for y
for c=1:l
   y(:,c)=x(1+(c-1)*p:(c-1)*p+m).*hamming(m);%x is multiplied by hamming(m) and divided into l parts,the result is y
end;