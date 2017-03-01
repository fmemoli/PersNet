function dis = computeDis(wX,wY,R)
% Input: weight matrices of networks X and Y, and a correspondence
% Output: distortion of correspondence


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

nz=find(R); %//Find nonzero elements in R
p=npermutek(nz,2); %//Obtain pairs of elements in R; lack of symmetry means need to use npermutek
dis = zeros(size(p,1),1);
for ii=1: size(p,1)
    z1=p(ii,1); %//First element in pair
    z2=p(ii,2); %//Second element in pair
    
    [x1,y1]=ind2sub(size(R),z1); %//First element is (x1,y1)
    [x2,y2]=ind2sub(size(R),z2); %//Second element is (x2,y2)
    
    dis(ii)=abs(wX(x1,x2)-wY(y1,y2));
end

dis=max(dis);
end

    
    
    
