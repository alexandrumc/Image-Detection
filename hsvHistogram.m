function [l] =rgbHistogram(a,nr);
  clear A;
  clear R;
  clear G;
  clear Cmin;
  clear Cmax;
  clear dif;
  clear l;
  clear H;

  A=imread(a); %se citeste imaginie
  Cmax=max(A,[],3); %se realizeaza matricea cu valorile maxime
  Cmin=min(A,[],3); %respectiv minime ale pixelilor
  A=double(A);
  R=A(:,:,1)/255; %matricele pentru componentele rosu
  G=A(:,:,2)/255; %verde
  B=A(:,:,3)/255; %albastru

  Cmax=double(Cmax);
  Cmin=double(Cmin);
  Cmax=Cmax/255;
  Cmin=Cmin/255;
  dif=Cmax-Cmin; %se construieste matricea diferenta

  [n m]=size(R);
  H=zeros(n,m); %se initializeaza matricea H
  H=double(H); %cu ajutorul a 3 auxiliare

  H1=zeros(n,m); %cazul in care componenta maxima a unui pixel este cea rosie
  H1=double(H1);
  H1(find(Cmax==R))=1;
  H1(find(dif==0))=0;
  aux1=60*(mod((G-B)./dif,6));

  H2=zeros(n,m);% componenta maxima este cea verde
  H2=double(H2);
  H2(find(Cmax==G))=1;
  H2(find(dif==0))=0;
  aux2=60*((B-R)./dif+2);

  H3=zeros(n,m); %componenta maxima este cea albastra
  H3=double(H3);
  H3(find(Cmax==B))=1;
  H3(find(dif==0))=0;
  aux3=60*((R-G)./dif+4);

  ind=find(H2==H1 & H2!=0); %se elimina cazurile in care 2 componente pot fi
  H2(ind)=0;                %si maxime si egale
  ind=find(H3==H1 & H3!=0);
  H3(ind)=0;
  ind=find(H3==H2 & H3!=0);
  H3(ind)=0;

  H1=H1.*aux1;
  H2=H2.*aux2;
  H3=H3.*aux3;
  H=H1+H2+H3; %se obtine matricea H

  S=ones(n,m); %se construieste matricea S
  ind=find(Cmax==0);
  S(ind)=0;
  S=double(S);
  ind=find(Cmax!=0);
  S(ind)=dif(ind)./Cmax(ind);
  V=Cmax; %matricea V
  H=H/360;
  %se foloseste acelasi procedeu utilizat la functia precedenta
  %si se particularizeaza pentru intervalul 0-1
  for j=0:nr-1
    h(end+1)=length(find(j*1.01/nr<=H & H<j*1.01/nr+1.01/nr));
    f(end+1)=length(find(j*1.01/nr<=S & S<j*1.01/nr+1.01/nr));
    g(end+1)=length(find(j*1.01/nr<=V & V<j*1.01/nr+1.01/nr));
  endfor
  l=[h f g];
endfunction
