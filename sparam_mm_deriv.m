% The deriviaton of the mixed-mode S-parameter conversion

syms a1 a2 a3 a4
syms b1 b2 b3 b4
syms S11 S12 S13 S14
syms S21 S22 S23 S24
syms S31 S32 S33 S34
syms S41 S42 S43 S44

syms ad1 ad2
syms bd1 bd2

ad1 = a1-a2;
bd1 = b1-b2;
ad2 = a3-a4;
bd2 = b3-b4;

BB = [S11 S12 S13 S14;S21 S22 S23 S34;S31 S32 S33 S34;S41 S42 S43 S44]*[a1;a2;a3;a4];
b1 = BB(1,1);
b2 = BB(2,1);
b3 = BB(3,1);
b4 = BB(4,1);


% strategy:
%   b = S*a
%   amixed = [ad;ac] = M*a
%   bmixed = [bd;bc] = M*b
%   a = inv(M)*[ad;ac]   b = inv(M)*[bd;bc]
%   b = S*a   ==>   inv(M)*[bd;bc] = S*inv(M)*[ad;ac]
%   [bd;bc] = M*S*inv(M)*[ad;ac]
%   bmixed = Smixed*amixed
%   Smixed = M*S*inv(M)
%
%   find the correct M to express [ad;ac] = M*a
% [ad ac] = M1*a; [bd bc] = M1*b;
M1 = [1 -1 0 0;0 0 1 -1;.5 .5 0 0;0 0 .5 .5];