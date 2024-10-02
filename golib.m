function golib(subdir)
% GOLIB  shortcut to change directory to MATLAB user library directory
%   gohome                % cd to user library directory C:\Library\MATLAB
%   gohome subdirectory   % cd to subdirectory in user library directory
narginchk(0,1)
if nargin==0
    cd('C:\Library\MATLAB')
elseif ischar(subdir) || isStringScalar(subdir)
    subdir = convertStringsToChars(subdir);
	is_done = false;
	try
		cd([ 'C:\Library\MATLAB' filesep subdir ])
		is_done = true;
	end
	if ~is_done
		try % library directory
			cd([ 'C:\Library\MATLAB' filesep '+' subdir ])
			is_done = true;
		end
	end
	if ~is_done
		try % class directory
			cd([ 'C:\Library\MATLAB' filesep '@' subdir ])
			is_done = true;
		end
	end
	if ~is_done
		error('subdir ''%s'' was not found', subdir)
	end
	
else
    error('subdir must be a character vector')
end

% Copyright (c) 2024, Kerry S. Martin, martin@wild-wood.net