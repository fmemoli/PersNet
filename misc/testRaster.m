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

function testRaster(cells,firingRaster)
cellX=cells(:,1);
cellY=cells(:,2);
axis ([-1,11,-1,11]);
%axis ([-1.5,1.5,-1.5,1.5]);
hold on;

incr=20;
%// The following is a trick to speed up animation. For accuracy, use (**)
active=[1:incr:size(firingRaster,2)]';
ii=1;
while (ii<=length(active))
    ff=find(firingRaster(:,active(ii))>0,1);
    if ~isempty(ff)
        active(ii)=ff;
        ii=ii+1;
    else
        active(ii)=[];
    end
end

for ii=1:length(active)
    scatter(cellX(active(ii),:),cellY(active(ii),:),100,ii,'filled')
    title(ii*incr);
    drawnow limitrate
end
drawnow
return


    

%%(**) old version. accurate but slow.
for i=1:20:size(firingRaster,2) %change to 1:20:size(...)
    active=find(firingRaster(:,i)>0); %//just plot one point at a time for faster computation
    scatter(cellX(active,:),cellY(active,:),100,i*ones(size(active)),'filled')
    title(i);
    drawnow %used for movie
end
%drawnow

%%for directly plotting place fields after loading pcells file
cellX=cells(:,1);
cellY=cells(:,2);
axis ([0,10,0,10]);
%axis ([-1.5,1.5,-1.5,1.5]);
hold on;
scatter(cellX,cellY,100,'blue','filled')
