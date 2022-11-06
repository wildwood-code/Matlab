function [tf, idx, s] = find_samatch(sa, field, value)
% FIND_SAMATCH find first field matching value in struct array
%   [tf, idx, s] = FIND_SAMATCH(sa, field, value)
%     sa    = struct array to search
%     field = name of the field in struct array
%     value = comparison value (string or char array)
%     tf    = true/false result: true = matched, false otherwise
%     idx   = index into struct array of first matched struct
%     s     = struct that had field match value

narginchk(3,3)
N = length(sa);
if ~isfield(sa,field)
    error('%s is not a field of the struct array', field)
end
[names{1:N}] = sa.(field);
if ischar(value) || isstring(value)
    fi = strcmpi(value,names);
else
    error('value must be a string or a char array')
end
if any(fi)
  tf = true;
  idx = find(fi,1);
  s = sa(idx);
else
 tf = false;
 idx = 0;
 s = [];
end
