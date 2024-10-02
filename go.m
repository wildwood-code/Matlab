function go(dest)
% GO change the directory to the home or library directory
%   GO home
%   GO library

% Kerry S. Martin, martin@wild-wood.net
if nargin<1
    dest = 'home';
end

if strcmpi(dest, 'home') || strcmpi(dest, 'user')
    ud = [getuserdir '\MATLAB']; 
    if (~strcmpi(pwd, ud))
        cd(ud)
    end
elseif strcmpi(dest, 'lib') || strcmpi(dest, 'library')
    ld = 'C:\Library\MATLAB';
    if (~strcmpi(pwd, ld))
        cd(ld)
    end
end

end


function userDir = getuserdir
%GETUSERDIR   return the user home directory.
%   USERDIR = GETUSERDIR returns the user home directory using the registry
%   on windows systems and using Java on non windows systems as a string
%
%   Example:
%      getuserdir() returns on windows
%           C:\Documents and Settings\MyName\Eigene Dateien
if ispc
    userDir = winqueryreg('HKEY_CURRENT_USER',...
        ['Software\Microsoft\Windows\CurrentVersion\' ...
         'Explorer\Shell Folders'],'Personal');
else
    userDir = char(java.lang.System.getProperty('user.home'));
end
end

% Copyright (c) 2024, Kerry S. Martin, martin@wild-wood.net