function [main_sensor, sensor_number] = get_sensor_number(sensor_name)
% get_sensor_number  This function is part of the
% MATLAB toolbox for accessing BGC Argo float data.
%
% USAGE:
%   [main_sensor, sensor_number] = get_sensor_number(sensor_name)
%
% DESCRIPTION:
%   This function returns the name of the main sensor and, if applicable,
%   the number of the sensor. If sensor_name represents the main
%   sensor, sensor_number is an empty string, not '1'. sensor_number
%   is only defined for additional sensors, e.g. '2' for 'DOXY2'.
%
% INPUTS:
%   sensor_name : the full name of the sensor, e.g.: 'TEMP' or 'DOXY2'
%
% OUTPUTS:
%   main_sensor : the name of the main sensor, e.g. 'TEMP' or 'DOXY'
%   sensor_number : the number of the sensor returned as a string,
%                 e.g.: '2' (empty string for the main sensor)
%
% AUTHORS:
%   H. Frenzel, J. Sharp, A. Fassbender (NOAA-PMEL), N. Buzby (UW),
%   J. Plant, T. Maurer, Y. Takeshita (MBARI), D. Nicholson (WHOI),
%   and A. Gray (UW)
%
% CITATION:
%   H. Frenzel*, J. Sharp*, A. Fassbender, N. Buzby, J. Plant, T. Maurer,
%   Y. Takeshita, D. Nicholson, A. Gray, 2021. BGC-Argo-Mat: A MATLAB
%   toolbox for accessing and visualizing Biogeochemical Argo data.
%   Zenodo. https://doi.org/10.5281/zenodo.4971318.
%   (*These authors contributed equally to the code.)
%
% LICENSE: bgc_argo_mat_license.m
%
% DATE: MAY 26, 2022  (Version 1.3)

% first case: main sensor does not contain numbers,
% e.g. if sensor_name is 'DOXY' or 'DOXY2'
match = regexp(sensor_name, ...
    '(?<main>[A-Z]+(_[A-Z]+)?)(?<num>[2-9]?)$','names');
if isempty(match)
    % second case: main sensor contains numbers, e.g., 'BBP700' or 'BBP700_2'
    match = regexp(sensor_name, ...
        '(?<main>[A-Z]+(_[A-Z]+)?\d{3})(?<num>_[2-9])?$','names');
    match.num = strrep(match.num, '_', '');
end
main_sensor = match.main;
sensor_number = match.num;
