function huhaan_tim(I)
im=I;
im=im(:,:,1);

sigmaA=8;
sigmaB=10;
sigmaMax=max([sigmaA sigmaB]);
fsz=[sigmaMax, sigmaMax];

kernelA=fspecial('gaussian', fsz, sigmaA);
kernelB=fspecial('gaussian', fsz, sigmaB);
%imA = filter2(kernelA, im);
%imB = filter2(kernelB, im);
imA = imfilter(im, kernelA, 'symmetric', 'conv');
imwrite(imA,'Process_Image\ima.jpg','jpg');
imB = imfilter(im, kernelB, 'symmetric', 'conv');
imwrite(imB,'Process_Image\imb.jpg','jpg');
R1=single(im)-single(imA);
%R1=((single(imA)./single(im))-1).*single(imB);
R2=single(imA)-single(imB);

%R1=abs(R1);
%R2=abs(R2);
%R2(R2<1)=1;

R=R1./R2;

R(isnan(R))=0;
R(isinf(R))=0;
Rf=maxfilt2(R,8);
%Rf=max(max(Rf))-Rf;

blurmap=(sigmaA*sigmaB)./((sigmaB-sigmaA)*Rf+sigmaB);
figure;
subplot(2,3,1), imshow(im), title('original')
subplot(2,3,2), imshow(uint8(imA)), title('imA')
subplot(2,3,3), imshow(uint8(imB)), title('imB')
subplot(2,3,4), imagesc(blurmap), title('blurmap')
set(gca,'xticklabel',[],'yticklabel',[])
set(gca,'xtick',[],'ytick',[]),axis image
subplot(2,3,5), imagesc(blurmap>1 & blurmap<4), title('\sigma [2:4]')
set(gca,'xticklabel',[],'yticklabel',[])
set(gca,'xtick',[],'ytick',[]),axis image
subplot(2,3,6), imagesc(blurmap>0 & blurmap<0.4), title('\sigma [0:0.5]')
set(gca,'xticklabel',[],'yticklabel',[])
set(gca,'xtick',[],'ytick',[]),axis image




