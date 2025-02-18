% =============================================================================
% Project       : classAB
% Module name   : study_4_iv_common_collector
% File name     : study_4_iv_common_collector.m
% File type     : Matlab script
% Purpose       : specific study of CC circuit with emitter degeneration
% Author        : QuBi (nitrogenium@hotmail.com)
% Creation date : Tuesday, 18 February 2025
% -----------------------------------------------------------------------------
% Best viewed with space indentation (2 spaces)
% =============================================================================

% -----------------------------------------------------------------------------
% DESCRIPTION
% -----------------------------------------------------------------------------
% TODO


close all
clear all
clc

R_e = 0.47;

nPts = 500;
nTries = 10000;

delta_v = linspace(0.2, 2.0, nPts)';
I = zeros(nPts, 1);

I_test = linspace(0, 0.8, nTries)';
err = zeros(nTries, 1);

for n = 1:nPts
  for m = 1:nTries
    err(m) = abs(I_test(m) - f_NPN_exp(delta_v(n) - R_e*I_test(m)));
  end
  
  [~, argMin] = min(err);
  I(n) = I_test(argMin);
end

plot(delta_v, I)
xlabel('\DeltaV = v_{in} - v_{F} (Volts)')
ylabel('I (Amps)')
grid minor



% Simple model of the Ic/Vbe relationship
function i = f_NPN_exp(v_BE)
  i = (1e-14)*(exp(v_BE/0.026)-1);

  if (i > 1.0)
    i = 1.0;
  end
end

