function [p]= evaluate(a,w,b,nr)
  % se foloseste aproape in totalitatea codul din functia preprocess
  % se obtine numarul total de imagini si numarul de imagini evaluate corect
  corect=0;
  a1=fullfile(a,'cats');
  if (strcmp(b,"RGB")==1)
    img=dir(fullfile(a1,'*.jpg'));
    da=length(img);
    for j=1:length(img)
      A=imread(fullfile(a1,img(j).name));
      for i=0:nr-1
        h(end+1)=length(find(i*256/nr<=A(:,:,1) & A(:,:,1)<i*256/nr+256/nr));
        f(end+1)=length(find(i*256/nr<=A(:,:,2) & A(:,:,2)<i*256/nr+256/nr));
        g(end+1)=length(find(i*256/nr<=A(:,:,3) & A(:,:,3)<i*256/nr+256/nr));
      end
      l=[h f g];
      l=[l 1];
      clear h;
      clear f;
      clear g;
      wt=w';
      y=dot(wt,l);
      if (y>=0)
        corect++;
      end
    end

    a2=fullfile(a,'not_cats');
    img=dir(fullfile(a2,'*.jpg'));
    nu=length(img);
    clear l;
    clear h;
    clear f;
    clear g;
    for j=1:length(img)
      A=imread(fullfile(a2,img(j).name));
      for i=0:nr-1
        h(end+1)=length(find(i*256/nr<=A(:,:,1) & A(:,:,1)<i*256/nr+256/nr));
        f(end+1)=length(find(i*256/nr<=A(:,:,2) & A(:,:,2)<i*256/nr+256/nr));
        g(end+1)=length(find(i*256/nr<=A(:,:,3) & A(:,:,3)<i*256/nr+256/nr));
      end
      l=[h f g];
      l=[l 1];
      y=dot(wt,l);
      if (y<0)
        corect++;
      endif
      clear h;
      clear f;
      clear g;
    end
    total=da+nu;
    p=double(corect/total)*100;  %se face raportul si se obtine acuratetea

  else
    img=dir(fullfile(a1,'*.jpg'));
    da=length(img);
    for j=1:length(img)
      A=imread(fullfile(a1,img(j).name));
      Cmax=max(A,[],3);
      Cmin=min(A,[],3);
      A=double(A);
      R=A(:,:,1)/255;
      G=A(:,:,2)/255;
      B=A(:,:,3)/255;
      Cmax=double(Cmax);
      Cmin=double(Cmin);
      Cmax=Cmax/255;
      Cmin=Cmin/255;
      dif=Cmax-Cmin;
      [n m]=size(R);
      H=zeros(n,m);
      H=double(H);
      H1=zeros(n,m);
      H1=double(H1);
      H1(find(Cmax==R))=1;
      H1(find(dif==0))=0;
      aux1=60*(mod((G-B)./dif,6));
      H2=zeros(n,m);
      H2=double(H2);
      H2(find(Cmax==G))=1;
      H2(find(dif==0))=0;
      aux2=60*((B-R)./dif+2);
      H3=zeros(n,m);
      H3=double(H3);
      H3(find(Cmax==B))=1;
      H3(find(dif==0))=0;
      aux3=60*((R-G)./dif+4);
      ind=find(H2==H1 & H2!=0);
      H2(ind)=0;
      ind=find(H3==H1 & H3!=0);
      H3(ind)=0;
      ind=find(H3==H2 & H3!=0);
      H3(ind)=0;
      H1=H1.*aux1;
      H2=H2.*aux2;
      H3=H3.*aux3;
      H=H1+H2+H3;
      S=ones(n,m);
      ind=find(Cmax==0);
      S(ind)=0;
      S=double(S);
      ind=find(Cmax!=0);
      S(ind)=dif(ind)./Cmax(ind);
      V=Cmax;
      H=H/360;
      for i=0:nr-1
        h(end+1)=length(find(i*1.01/nr<=H & H<i*1.01/nr+1.01/nr));
        f(end+1)=length(find(i*1.01/nr<=S & S<i*1.01/nr+1.01/nr));
        g(end+1)=length(find(i*1.01/nr<=V & V<i*1.01/nr+1.01/nr));
      endfor
      l=[h f g];
      l=[l 1];
      wt=w';
      y=dot(wt,l);
      if (y>=0)
        corect++;
      endif
      clear h;
      clear f;
      clear g;
    end

    a2=fullfile(a,'not_cats');
    img=dir(fullfile(a2,'*.jpg'));
    nu=length(img);
    clear l;
    clear h;
    clear f;
    clear g;
    for j=1:length(img)
      A=imread(fullfile(a2,img(j).name));
      Cmax=max(A,[],3);
      Cmin=min(A,[],3);
      A=double(A);
      R=A(:,:,1)/255;
      G=A(:,:,2)/255;
      B=A(:,:,3)/255;
      Cmax=double(Cmax);
      Cmin=double(Cmin);
      Cmax=Cmax/255;
      Cmin=Cmin/255;
      dif=Cmax-Cmin;
      [n m]=size(R);
      H=zeros(n,m);
      H=double(H);
      H1=zeros(n,m);
      H1=double(H1);
      H1(find(Cmax==R))=1;
      H1(find(dif==0))=0;
      aux1=60*(mod((G-B)./dif,6));
      H2=zeros(n,m);
      H2=double(H2);
      H2(find(Cmax==G))=1;
      H2(find(dif==0))=0;
      aux2=60*((B-R)./dif+2);
      H3=zeros(n,m);
      H3=double(H3);
      H3(find(Cmax==B))=1;
      H3(find(dif==0))=0;
      aux3=60*((R-G)./dif+4);
      ind=find(H2==H1 & H2!=0);
      H2(ind)=0;
      ind=find(H3==H1 & H3!=0);
      H3(ind)=0;
      ind=find(H3==H2 & H3!=0);
      H3(ind)=0;
      H1=H1.*aux1;
      H2=H2.*aux2;
      H3=H3.*aux3;
      H=H1+H2+H3;
      S=ones(n,m);
      ind=find(Cmax==0);
      S(ind)=0;
      S=double(S);
      ind=find(Cmax!=0);
      S(ind)=dif(ind)./Cmax(ind);
      V=Cmax;
      H=H/360;
      for i=0:nr-1
        h(end+1)=length(find(i*1.01/nr<=H & H<i*1.01/nr+1.01/nr));
        f(end+1)=length(find(i*1.01/nr<=S & S<i*1.01/nr+1.01/nr));
        g(end+1)=length(find(i*1.01/nr<=V & V<i*1.01/nr+1.01/nr));
      endfor
      l=[h f g];
      l=[l 1];
      clear h;
      clear f;
      clear g;
      y=dot(wt,l);
      if (y<0)
        corect++;
      endif
    end
    corect--;
    total=da+nu;
    p=double(corect/total)*100; %se face raportul si se calculeaza acuratetea
  end
endfunction
