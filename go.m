function go(location)
% GO  shortcut to change directory to MATLAB home or library
%   go lib                 % cd to user library directory C:\Library\MATLAB
%   go hom                 % cd to user home directory

if ischar(location) || isstring(location)
    if strcmpi(location, 'home')
        cd(fileparts(which('startup')))
    elseif strcmpi(location, 'library') || strcmpi(location, 'lib')
        cd('C:\Library\MATLAB')
    end
end