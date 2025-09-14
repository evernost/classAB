% =============================================================================
% Project       : classAB
% Module name   : npn
% File name     : npn.m
% Purpose       : NPN forward model
% Author        : QuBi (nitrogenium@outlook.fr)
% Creation date : Monday, 08 September 2025
% -----------------------------------------------------------------------------
% Best viewed with space indentation (2 spaces)
% =============================================================================

% =============================================================================
% DESCRIPTION
% =============================================================================
% Piecewise linear model for the BJT collector current vs base-emitter voltage.
%
% Model is not meant to be a super accurate model of a BJT but rather a simple
% non-trivial emulation that aims at exploring the role of feedback effect in 
% amplifiers etc.
%
% Model has 2 regions:
% - forward active    (     v_be >= 0.7V)
% - cutoff            (0 =< v_be <  0.7V)
%
% Reverse models, saturation, breakdown modes etc. are not implemented since 
% it's beyond the purpose of this crude model.
% Any situation outside the scope above will return i_c = 0.



% =============================================================================
% PARAMETERS
% =============================================================================
% - param.v_be_th   : threshold 'v_be' voltage (in V). Usually ~0.7V
% - param.i_th      : collector current when v_be = v_be_th (in A). Usually a few mA
% - param.g_m       : bjt transconductance (in A/V)



% =============================================================================
% MODEL
% =============================================================================
function i_c = npn(v_be, param)

  % Initialise output
  % Default collector current is 0A.
  i_c = zeros(size(v_be));
  
  % -------------------
  % CUTOFF REGION MODEL
  % v_be < v_be_th
  % -------------------
  idxCutoff = (v_be < param.v_be_th);
  i_c(idxCutoff) = v_be(idxCutoff)*param.i_th/param.v_be_th;

  % ---------------------
  % ACTIVE FORWARD REGION
  % v_be >= v_be_th
  % ---------------------
  idxActive = (v_be >= param.v_be_th);
  i_c(idxActive) = g_m*(v_be(idxCutoff) - v_be_th) + i_0;
  
end
