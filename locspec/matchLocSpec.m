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

function [ R,c ] = matchLocSpec( wX, wY )


nX  =length(wX);
nY  =length(wY);

C = zeros(nX,nY);

% computer C
for i=1:nX
    sinXi = wX(i,:);
    soutXi = wX(:,i)';

    for j=1:nY
            sinYj = wY(j,:);
            soutYj = wY(:,j)';
            
            dij_in = L2_distance(sinXi,sinYj);
            aij_in = max(min(dij_in,[],2));
            aji_in = max(min(dij_in,[],1));
            
            dij_out = L2_distance(soutXi,soutYj);
            aij_out = max(min(dij_out,[],2));
            aji_out = max(min(dij_out,[],1));
            
            cin = max(aij_in,aji_in);
            cout = max(aij_out,aji_out);
            
            C(i,j) = max(cin,cout);
    end
end


% match
if min([nX,nY]) >1
[R,c] = bap5(C);
else
    c = max(C);
    if nX == 1
        R = ones(1,nY);
    end
    if nY ==1
        R = ones(nX,1);
    end
end

