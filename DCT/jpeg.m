
I=imread('lena.tif');


fun=@(block_struct)cdt2(block_struct.data);
b=blockproc(I,[8 8],fun,'PadPartialBlocks',true);

imshow(b,[])
