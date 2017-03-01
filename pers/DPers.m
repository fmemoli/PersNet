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


%% code to compute bottleneck distances from precomputed skeleta
% functions used: pulltruncatedsk, javaplex, distBarcode, bottleneck,
% writemyfile, convertJavaplexToI,skel2Intervals

mainfolder=[pwd,'/Hippo25/allBarcodes/'];
res_folder=[pwd,'/Hippo25/res_bottleneck/'];
cd(mainfolder);
mkdir(res_folder);

dire=dir('bars*.mat');
numFiles=length(dire);
p=nchoosek(1:numFiles,2);

for i=1:length(p) %edit this to 1:length(p)
  import edu.stanford.math.plex4.*;

    x=p(i,1);
    y=p(i,2);
    
    ni = sprintf('res_%d_%d.mat',x,y);
    fi = [res_folder '/' ni];%change slash depending on local/terminal
    
    if ~exist(fi,'file')

    intA=load(dire(x).name);
    intA=intA.bars;
    intB=load(dire(y).name);
    intB=intB.bars;
    
    
    [f,~,~] = distBarcode(intA{1},intB{1});
    [~,~,cm] = bottleneck(f);
    bottleneck_distance_dim0 = cm;
    [f,~,~] = distBarcode(intA{2},intB{2});
    [~,~,cm] = bottleneck(f);
    bottleneck_distance_dim1=cm;
       
intervalsA=[];
interalsB=[];
intervalsA_dim0=[];
intervalsA_dim1=[];
intervalsB_dim0=[];
intervalsB_dim1=[];
    fprintf('result %d vs %d = %f\n',x,y,bottleneck_distance_dim0)
    fprintf('result %d vs %d = %f\n',x,y,bottleneck_distance_dim1)

    res = struct('x',x,'y',y,'dim0_bdist',bottleneck_distance_dim0,'dim1_bdist',bottleneck_distance_dim1,'name_x',dire(x).name,'name_y',dire(y).name);
 
    writemyfile(fi,res)
    end
end

    
