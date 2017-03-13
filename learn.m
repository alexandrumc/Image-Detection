function [w] =learn(X,t);
  %se completeaza matricea X cu o coloana de "1"
  [a b]=size(X);
  X(:,b+1)=1;
  X=double(X);
  [a b]=size(X);
  %se initializeaza matricele Q si R pentru descompunerea QR
  Q=zeros(a,b);
  R=zeros(b);
  Q=double(Q);
  R=double(R);
  %se foloseste algoritmul Gram-Schmidt pentru a obtinerea Q R
  for j=1:b
    for i=1:j-1
      R(i,j)=Q(:,i)' *X(:,j);
    endfor
    s=zeros(a,1);
    s=double(s);
    for i=1:j-1
      s=s+R(i,j) * Q(:,i);
    endfor
    aux=X(:,j)-s;
    R(j,j)=norm(aux,2);
    Q(:,j)=aux/R(j,j);
  endfor

  v=Q'*t; %se reduce problema la rezolvarea unui sistem superior triunghiular
  [a b]=size(R);
  w=zeros(a,1);
  %se foloseste algoritmul de rezolvarea al SST
  for i=a:-1:1
    s=v(i);
    if (i<a)
      for k=i+1:a
        s=s-R(i,k)*w(k);
      endfor
    endif
    w(i)=s/R(i,i);
  endfor
endfunction
