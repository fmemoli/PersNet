function C = computeCorr(wX,wY)
% Input: weight matrices of networks X and Y
% Output: cell containing all possible correspondences between X and Y.
% Each correspondence has r rows and c columns, where r = |X| and c=|Y|.

% This function is one of the components required for computing the network
% distance between two networks X and Y

% Copyright (c) 2017, Samir Chowdhury and Facundo Memoli. The Ohio State University. All rights reserved. 
%Redistribution and use in source and binary forms, with or without modification, are permitted provided that the 
%following conditions are met: 
%• Redistributions of source code must retain the above copyright notice, this list of
% conditions and the following disclaimer. 
%• Redistributions in binary form must reproduce the above copyright notice, 
% this list of conditions and the followingdisclaimer in the documentation and/or other materials provided with the distribution. 
%• Neither the name of the {organization} nor the names of its contributors may be used to endorse or promote products derived 
% from this software without specific prior writtenpermission. 
% THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, 
% INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE 
% DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, 
% SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; 
% LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, 
% STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, 
% EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

% r = 2; %// nunber of rows
% c = 3; %// number of columns

r = length(wX); %// wX is a square matrix
c = length(wY); %// wY is a square matrix

% Get all binary matrices of size r*c. There are 2^(r*c) combinations
M = dec2bin(0:2^(r*c)-1)-'0'; %// Or: M = de2bi(0:2^(r*c)-1);
M = reshape(M.',r,c,[]);

% Filter this list to obtain actual correspondences
d=size(M,3);
good=zeros(d,1);
for ii=1:d
    R=M(:,:,ii);
    good(ii)=(prod(sum(R,1)>0)*prod(sum(R,2)>0));
end
M(:, :, ~good)=[];
C=num2cell(M,[1 2]);
C=reshape(C,size(M,3),1);

end