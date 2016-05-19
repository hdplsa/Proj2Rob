javaaddpath('./+QRcode/core-2.1.jar');
javaaddpath('./+QRcode/javase-2.1.jar');

qr = QRcode.encode_qr('5',[32*20 32*20]);
imagesc(qr); colormap gray

