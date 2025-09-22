% =============================================================================
% Project       : classAB
% Module name   : transfer_curve
% File name     : transfer_curve.m
% Purpose       : transfer curve for the class AB amplifier
% Author        : QuBi (nitrogenium@outlook.fr)
% Creation date : Monday, 22 September 2025
% -----------------------------------------------------------------------------
% Best viewed with space indentation (2 spaces)
% =============================================================================

% =============================================================================
% DESCRIPTION
% =============================================================================
% Description is TODO.
% Just be patient.


close all
clear all
clc


% =============================================================================
% SETTINGS
% =============================================================================

% BJT settings
bjtParam.v_be_th = 0.7;
bjtParam.i_th = 5e-3;
bjtParam.g_m = 100;

% Simulation points
nPts = 500;

V_bias = 1.6;
delta_V = linspace(-0.5, 0.5, nPts)';
R_e = 4;
R_load = 32;

% =============================================================================
% MAIN
% =============================================================================



% From KVL:
% I_s = npn(V_bias/2 - delta_V - R_e*I_s)
% I_s = npn(a + b*I_s)
% With:
% - a = V_bias/2 - delta_V
% - b = -R_e

[I_s_active, I_s_cutoff, ~] = fp_npn(V_bias/2 - delta_V, -R_e, bjtParam);
[I_d_active, I_d_cutoff, ~] = fp_npn(V_bias/2 + delta_V, -R_e, bjtParam);

plot(...
  delta_V, I_s_active, 'b', ...
  delta_V, I_s_cutoff, 'b-.', ...
  delta_V, -I_d_active, 'r', ...
  delta_V, -I_d_cutoff, 'r-.' ...
)
grid on
xlabel('\DeltaV = V_O - V_I')
legend('I_S (active)', 'I_S (cutoff)', 'I_D (active)', 'I_D (cutoff)')





