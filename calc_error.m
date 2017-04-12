function [RMS] = calc_error(source, target)
    RMS = sum(power((source - target), 2));
    RMS = sqrt(mean(RMS));
end %calc_error 