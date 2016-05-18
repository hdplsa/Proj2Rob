%% Test QR encoding and decoding
%
% Please download and build the core and javase parts of zxing
% from here - http://code.google.com/p/zxing/
%
javaaddpath('./+QRcode/core-2.1.jar');
javaaddpath('./+QRcode/javase-2.1.jar');

% encode a new QR code
test_encode = QRcode.encode_qr('la la la', [32 32]);
figure;imagesc(test_encode);axis image;

% decode
message = QRcode.decode_qr(imread('./+QRcode/test_qr.jpg'));
