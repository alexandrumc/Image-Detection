function [l] =rgbHistogram(a,nr);
    A=imread(a); %se citeste imaginea primita ca parametru
    clear l;
    %se realizeaza numararea vectorizata a pixelilor care au componentele 
    %in intervalele cerute
    %pentru fiecare componenta se foloseste un vector

    for j=0:nr-1
      h(end+1)=length(find(j*256/nr<=A(:,:,1) & A(:,:,1)<j*256/nr+256/nr));
      f(end+1)=length(find(j*256/nr<=A(:,:,2) & A(:,:,2)<j*256/nr+256/nr));
      g(end+1)=length(find(j*256/nr<=A(:,:,3) & A(:,:,3)<j*256/nr+256/nr));
    endfor
    %se concateneaza vectorii si se obtine histograma RGB
    l=[h f g];
endfunction
