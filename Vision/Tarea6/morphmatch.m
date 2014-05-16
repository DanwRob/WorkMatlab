% ------------------------------------------------------------------------
% Materia: Vision por Computadora
%
% Nombre: Dan Williams Robledo Cruz
% 
% Fecha: 2 de abril 2014
% 
% Tarea No:6
% 
% Titulo: Template Matching

function S=morphmatch(I,T,opt,g)
if(strcmp(opt,'black')==1)
    I=~I;
end
figure 
subplot 231
imshow(I)
title('Imagen original')
subplot 234
imshow(~I)
title('Imagen complemento')
eb1 = imerode(I,T);         %erosion imagen con plantilla
eb2 = imerode(~I,~T);       %erosion complemtno imagen con complemento plantilla
subplot 232
imshow(eb1)
title('Erosion Imagen original')
subplot 235
imshow(eb2)
title('Erosion Imagen complemento')
eb=eb1&eb2;                 %interseccion de erosiones
subplot 233
imshow(eb)
title('Interseccion')
imgReconst = imreconstruct(eb,~I);      %reconstruccion morphologica
[S,~] = bwboundaries(imgReconst,'noholes');

if g==1
    subplot 236
    imshow(I)
    title('Concidencias')
    hold on
    B =[S{1}];
    plot(B(:,2), B(:,1), 'y','LineWidth', 1);
else
    subplot 236
    imshow(imgReconst)
end