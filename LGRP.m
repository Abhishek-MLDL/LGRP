function [out, VR]= LGRP(I)

% Local Gabor Rank Pattern (LGRP): A novel descriptor for face representation and recognition
% (C) Abhishek Gangwar, Akanksha Joshi
% Code URL- https://github.com/cdac-cvml/LGRP
% For Code related Queries Contact: abhishekg@cdac.in, akanksha@cdac.in
% Date of current release: Nov 2015
% (please check the URL above for more recent releases)

%%%% The software accepts an face image as input, and outputs LGRP code (LGRPs with center pixel and 4
%%%% neighbouring sample points) 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  Terms and Conditions %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%  This code is provided "as is", without any warranty, and for research purposes only.
%%%%%  By downloading the code, you agree with the terms and conditions.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  Reference   %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%% Please remember to cite following reference [1] if you make use of this code in any publication.
%%%% 	Abhishek Gangwar,  Akanksha Joshi, "Local Gabor Rank Pattern (LGRP): A novel descriptor for 
%%%%    face representation and recognition," in 7th IEEE International Workshop on Information 
%%%%    Forensics and Security (WIFS), 2015, vol., no., pp.1-6, 16-19 Nov. 2015 
%%%%	doi: 10.1109/WIFS.2015.7368581

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% I=rgb2gray(imread('F:\PIR\databases\Face\Caltech Faces\P1\Test\img001.jpg'));
load map5.mat;
% Uncomment following lines if you want to create maptable i.e. map5
% v=[5,4,3,2,1];
% map=perms(v);
% map5=sort(m2str(map));


[r,c]=size(I);
I=double(I)+rand(size(I))/100;
I1=I(2:r-1,2:c-1);%centre pixel
I2=I(1:r-2,1:c-2);%top left
I3=I(1:r-2,3:c);% Top right
I4=I(3:r,3:c);%bottom right
I5=I(3:r,1:c-2);%bottom left

%% Uncomment these lines to measure variance as mentioned in paper  
% VR=zeros(r-2,c-2);
% for i=1:r-2
%     for j=1:c-2
%         VR(i,j)=std2([I1(i,j), I2(i,j), I3(i,j), I4(i,j), I5(i,j)]);
%     end
% end

R1=I1>I2;
R2=I1>I3;
R3=I1>I4;
R4=I1>I5;
R5=I2>I3;
R6=I2>I4;
R7=I2>I5;
R8=I3>I4;
R9=I3>I5;
R10=I4>I5;

K=ones(r-2,c-2);

B1=K+R1+R2+R3+R4;
B2=K+imcomplement(R1)+R5+R6+R7;
B3=K+imcomplement(R2)+imcomplement(R5)+R8+R9;
B4=K+imcomplement(R3)+imcomplement(R6)+imcomplement(R8)+R10;
B5=K+imcomplement(R4)+imcomplement(R7)+imcomplement(R9)+imcomplement(R10);

out=B1*10000+B2*1000+B3*100+B4*10+B5;
for i=1:numel(map5)
    out(out==map5(i))=i;
end