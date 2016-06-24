function [numout]=m2str(N)
[m,n]=size(N);
numout=zeros(m,1);
for i=1:m
    d=N(i, :);
    out=0;
    for j=1:numel(d)
        num= 10^(j-1) * N(i,j);
        out = out + num;
    end
        numout(i,:)=out;
end