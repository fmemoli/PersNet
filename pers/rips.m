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

function [sk0,sk1,sk2,sk3]=rips(A)
% Function to compute Rips filtration for a matrix A
% Input: square matrix A. Output: 0-3 skeleta with entry times
% Aux functions: VChooseK package can be compiled for speed, available here:
% https://www.mathworks.com/matlabcentral/fileexchange/26190-vchoosek
% Also might need a C compiler such as MinGW:
% http://www.mathworks.com/matlabcentral/fileexchange/52848-matlab-support-for-the-mingw-w64-c-c++-compiler-from-tdm-gcc

n=length(A);
diam=max(max(A));
% Build 0-skeleton
% Entry time of vertex i is just A(i,i))
eT=diag(A);
sk0=[[1:n]',eT];

% Build 1-skeleton
q=nchoosek(1:n,2); %//replace with VChooseK for faster performance on larger datasets
% Initialize sk1 with max entry time
sk1=[q,diam*ones(size(q,1),1)];
for ii=1:size(q,1)
    aI=A(q(ii,1),q(ii,:));
    aJ=A(q(ii,2),q(ii,:));
    aIJ=max(max([aI;aJ]));
    sk1(ii,end)=aIJ;
end

if (nargout>2)
% Build 2-skeleton
q=nchoosek(1:n,3); 
% Initialize sk2 with max entry time
sk2=[q,diam*ones(size(q,1),1)];
for ii=1:size(q,1)
    aI=A(q(ii,1),q(ii,:));
    aJ=A(q(ii,2),q(ii,:));
    aK=A(q(ii,3),q(ii,:));
    aIJK=max(max([aI;aJ;aK]));
    sk2(ii,end)=aIJK;
end
end

if (nargout>3)
   % Build 3-skeleton
q=nchoosek(1:n,4); 
% Initialize sk3 with max entry time
sk3=[q,diam*ones(size(q,1),1)];
for ii=1:size(q,1)
    aI=A(q(ii,1),q(ii,:));
    aJ=A(q(ii,2),q(ii,:));
    aK=A(q(ii,3),q(ii,:));
    aL=A(q(ii,4),q(ii,:));
    aIJKL=max(max([aI;aJ;aK;aL]));
    sk3(ii,end)=aIJKL;
end 
end
end
