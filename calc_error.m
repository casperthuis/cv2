function [rms] = calc_error(source, target)
    rms = sum(power((source - target), 2));
    rms = sqrt(mean(rms));
end %calc_error 