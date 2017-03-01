function [ints]=computePers(sk0,sk1,sk2,sk3,diam,filename,resfolder)
% Compute persistence
%
% This code takes the skeleta produced by the dowker.m or rips.m files, and
% produces barcodes. Requires a valid javaplex installation.

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

import edu.stanford.math.plex4.*;


if (nargin<5)
    stream=api.Plex4.createExplicitSimplexStream();
else
    stream = api.Plex4.createExplicitSimplexStream(diam); %use this for 
%     non-integer entry times; diam is upper bound on filtration times 
end

    if ~isempty(sk0)
        for v=1:size(sk0,1);
            stream.addVertex(sk0(v,1),sk0(v,2));
        end
    end

    if ~isempty(sk1)
        for e =1:size(sk1,1);
            stream.addElement(sk1(e,1:2), sk1(e,3)); 
        end
    end
    if ~isempty(sk2)
        for f=1:size(sk2,1);
            stream.addElement(sk2(f,1:3),sk2(f,4));
        end
    end

if ~isempty(sk3)
    for g=1:size(sk3,1);
        stream.addElement(sk3(g,1:4),sk3(g,5));
    end
end

stream.finalizeStream();
% compute 2 dimensions (0,1-simplices)with Z2 coeff
persistence = api.Plex4.getModularSimplicialAlgorithm(2,2);

if (nargin<=5)
    intervals = persistence.computeIntervals(stream)
    represent=persistence.computeAnnotatedIntervals(stream)
    plot_barcodes(intervals);
end

if (nargin>5)
    
intervals = persistence.computeIntervals(stream);
represent=persistence.computeAnnotatedIntervals(stream);
bars=convertJavaplexToI(intervals);
save([resfolder,'bars_',filename,'.mat'],'bars');
options.filename = [filename,'.fig'];
options.file_format='fig';
% options.filename='testsimplenet2';
options.max_filtration_value = diam;
plot_barcodes(intervals, options);
end
end


