function golib(subdir)
% GOLIB  shortcut to change directory to MATLAB user library directory
%   gohome                % cd to user library directory C:\Library\MATLAB
%   gohome subdirectory   % cd to subdirectory in user library directory
narginchk(0,1)
if nargin==0
    cd('C:\Library\MATLAB')
elseif ischar(subdir) || isStringScalar(subdir)
    subdir = convertStringsToChars(subdir);
    cd([ 'C:\Library\MATLAB' filesep subdir ])
else
    error('subdir must be a character vector')
end
