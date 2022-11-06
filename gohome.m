function gohome(subdir)
% GOHOME  shortcut to change directory to user home directory
%   gohome                % cd to user home directory
%   gohome subdirectory   % cd to subdirectory in user home directory
narginchk(0,1)
if nargin==0
    cd(fileparts(which('startup')))
elseif ischar(subdir) || isStringScalar(subdir)
    subdir = convertStringsToChars(subdir);
    cd([ fileparts(which('startup')) filesep subdir ])
else
    error('subdir must be a string or character vector')
end