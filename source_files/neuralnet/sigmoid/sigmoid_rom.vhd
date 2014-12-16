--=============================================================================
--    This file is part of FPGA_NEURAL-Network.
--
--    FPGA_NEURAL-Network is free software: you can redistribute it and/or 
--    modify it under the terms of the GNU General Public License as published 
--    by the Free Software Foundation, either version 3 of the License, or
--    (at your option) any later version.
--
--    FPGA_NEURAL-Network is distributed in the hope that it will be useful,
--    but WITHOUT ANY WARRANTY; without even the implied warranty of
--    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
--    GNU General Public License for more details.
--
--    You should have received a copy of the GNU General Public License
--    along with FPGA_NEURAL-Network.  
--		if not, see <http://www.gnu.org/licenses/>.

--=============================================================================
--	FILE NAME			: SIGMOID_ROM.vhd
--	PROJECT				: FPGA_NEURAL-Network
--	ENTITY				: SIGMOID_ROM
--	ARCHITECTURE		: rtl
--=============================================================================
--	AUTORS(s)			: Agostini, N;
--	DEPARTMENT      	: Electrical Engineering (UFRGS)
--	DATE					: Dec 14, 2014
--=============================================================================
--	Description:
--	
--=============================================================================

library ieee;
	use ieee.std_logic_1164.all;
	use ieee.numeric_std.all; -- is the to unsigned really required????
	use work.fixed_pkg.all; -- ieee_proposed for compatibility version
	use work.NN_TYPES_pkg.all;
	use work.SIGMOID_ROM_pkg.all;

--=============================================================================
-- Entity declaration for SIGMOID_ROM
--=============================================================================
entity SIGMOID_ROM is 
	port (
		clk				:	in std_logic;
		X_VALUE 			: 	in std_logic_vector ((NUMBER_OF_BITS-1) downto 0);
		Y_VALUE			: 	out CONSTRAINED_SFIXED
	);
end SIGMOID_ROM;

--=============================================================================
-- architecture declaration
--=============================================================================
architecture RTL of SIGMOID_ROM is
-- Constants

			
			-- This constant has 1024 values
			constant TAN_SIG : TAN_SIG_VECTOR := (
				to_sfixed(-0.9951,1,L_SIZE),
				to_sfixed(-0.9950,1,L_SIZE),
				to_sfixed(-0.9949,1,L_SIZE),
				to_sfixed(-0.9949,1,L_SIZE),
				to_sfixed(-0.9948,1,L_SIZE),
				to_sfixed(-0.9948,1,L_SIZE),
				to_sfixed(-0.9947,1,L_SIZE),
				to_sfixed(-0.9946,1,L_SIZE),
				to_sfixed(-0.9946,1,L_SIZE),
				to_sfixed(-0.9945,1,L_SIZE),
				to_sfixed(-0.9944,1,L_SIZE),
				to_sfixed(-0.9944,1,L_SIZE),
				to_sfixed(-0.9943,1,L_SIZE),
				to_sfixed(-0.9942,1,L_SIZE),
				to_sfixed(-0.9942,1,L_SIZE),
				to_sfixed(-0.9941,1,L_SIZE),
				to_sfixed(-0.9940,1,L_SIZE),
				to_sfixed(-0.9940,1,L_SIZE),
				to_sfixed(-0.9939,1,L_SIZE),
				to_sfixed(-0.9938,1,L_SIZE),
				to_sfixed(-0.9938,1,L_SIZE),
				to_sfixed(-0.9937,1,L_SIZE),
				to_sfixed(-0.9936,1,L_SIZE),
				to_sfixed(-0.9935,1,L_SIZE),
				to_sfixed(-0.9935,1,L_SIZE),
				to_sfixed(-0.9934,1,L_SIZE),
				to_sfixed(-0.9933,1,L_SIZE),
				to_sfixed(-0.9932,1,L_SIZE),
				to_sfixed(-0.9931,1,L_SIZE),
				to_sfixed(-0.9931,1,L_SIZE),
				to_sfixed(-0.9930,1,L_SIZE),
				to_sfixed(-0.9929,1,L_SIZE),
				to_sfixed(-0.9928,1,L_SIZE),
				to_sfixed(-0.9927,1,L_SIZE),
				to_sfixed(-0.9926,1,L_SIZE),
				to_sfixed(-0.9926,1,L_SIZE),
				to_sfixed(-0.9925,1,L_SIZE),
				to_sfixed(-0.9924,1,L_SIZE),
				to_sfixed(-0.9923,1,L_SIZE),
				to_sfixed(-0.9922,1,L_SIZE),
				to_sfixed(-0.9921,1,L_SIZE),
				to_sfixed(-0.9920,1,L_SIZE),
				to_sfixed(-0.9919,1,L_SIZE),
				to_sfixed(-0.9918,1,L_SIZE),
				to_sfixed(-0.9917,1,L_SIZE),
				to_sfixed(-0.9916,1,L_SIZE),
				to_sfixed(-0.9915,1,L_SIZE),
				to_sfixed(-0.9914,1,L_SIZE),
				to_sfixed(-0.9913,1,L_SIZE),
				to_sfixed(-0.9912,1,L_SIZE),
				to_sfixed(-0.9911,1,L_SIZE),
				to_sfixed(-0.9910,1,L_SIZE),
				to_sfixed(-0.9909,1,L_SIZE),
				to_sfixed(-0.9908,1,L_SIZE),
				to_sfixed(-0.9907,1,L_SIZE),
				to_sfixed(-0.9906,1,L_SIZE),
				to_sfixed(-0.9905,1,L_SIZE),
				to_sfixed(-0.9904,1,L_SIZE),
				to_sfixed(-0.9903,1,L_SIZE),
				to_sfixed(-0.9902,1,L_SIZE),
				to_sfixed(-0.9900,1,L_SIZE),
				to_sfixed(-0.9899,1,L_SIZE),
				to_sfixed(-0.9898,1,L_SIZE),
				to_sfixed(-0.9897,1,L_SIZE),
				to_sfixed(-0.9896,1,L_SIZE),
				to_sfixed(-0.9894,1,L_SIZE),
				to_sfixed(-0.9893,1,L_SIZE),
				to_sfixed(-0.9892,1,L_SIZE),
				to_sfixed(-0.9891,1,L_SIZE),
				to_sfixed(-0.9889,1,L_SIZE),
				to_sfixed(-0.9888,1,L_SIZE),
				to_sfixed(-0.9887,1,L_SIZE),
				to_sfixed(-0.9885,1,L_SIZE),
				to_sfixed(-0.9884,1,L_SIZE),
				to_sfixed(-0.9883,1,L_SIZE),
				to_sfixed(-0.9881,1,L_SIZE),
				to_sfixed(-0.9880,1,L_SIZE),
				to_sfixed(-0.9879,1,L_SIZE),
				to_sfixed(-0.9877,1,L_SIZE),
				to_sfixed(-0.9876,1,L_SIZE),
				to_sfixed(-0.9874,1,L_SIZE),
				to_sfixed(-0.9873,1,L_SIZE),
				to_sfixed(-0.9871,1,L_SIZE),
				to_sfixed(-0.9870,1,L_SIZE),
				to_sfixed(-0.9868,1,L_SIZE),
				to_sfixed(-0.9867,1,L_SIZE),
				to_sfixed(-0.9865,1,L_SIZE),
				to_sfixed(-0.9864,1,L_SIZE),
				to_sfixed(-0.9862,1,L_SIZE),
				to_sfixed(-0.9860,1,L_SIZE),
				to_sfixed(-0.9859,1,L_SIZE),
				to_sfixed(-0.9857,1,L_SIZE),
				to_sfixed(-0.9855,1,L_SIZE),
				to_sfixed(-0.9854,1,L_SIZE),
				to_sfixed(-0.9852,1,L_SIZE),
				to_sfixed(-0.9850,1,L_SIZE),
				to_sfixed(-0.9848,1,L_SIZE),
				to_sfixed(-0.9847,1,L_SIZE),
				to_sfixed(-0.9845,1,L_SIZE),
				to_sfixed(-0.9843,1,L_SIZE),
				to_sfixed(-0.9841,1,L_SIZE),
				to_sfixed(-0.9839,1,L_SIZE),
				to_sfixed(-0.9838,1,L_SIZE),
				to_sfixed(-0.9836,1,L_SIZE),
				to_sfixed(-0.9834,1,L_SIZE),
				to_sfixed(-0.9832,1,L_SIZE),
				to_sfixed(-0.9830,1,L_SIZE),
				to_sfixed(-0.9828,1,L_SIZE),
				to_sfixed(-0.9826,1,L_SIZE),
				to_sfixed(-0.9824,1,L_SIZE),
				to_sfixed(-0.9822,1,L_SIZE),
				to_sfixed(-0.9820,1,L_SIZE),
				to_sfixed(-0.9817,1,L_SIZE),
				to_sfixed(-0.9815,1,L_SIZE),
				to_sfixed(-0.9813,1,L_SIZE),
				to_sfixed(-0.9811,1,L_SIZE),
				to_sfixed(-0.9809,1,L_SIZE),
				to_sfixed(-0.9807,1,L_SIZE),
				to_sfixed(-0.9804,1,L_SIZE),
				to_sfixed(-0.9802,1,L_SIZE),
				to_sfixed(-0.9800,1,L_SIZE),
				to_sfixed(-0.9797,1,L_SIZE),
				to_sfixed(-0.9795,1,L_SIZE),
				to_sfixed(-0.9793,1,L_SIZE),
				to_sfixed(-0.9790,1,L_SIZE),
				to_sfixed(-0.9788,1,L_SIZE),
				to_sfixed(-0.9785,1,L_SIZE),
				to_sfixed(-0.9783,1,L_SIZE),
				to_sfixed(-0.9780,1,L_SIZE),
				to_sfixed(-0.9778,1,L_SIZE),
				to_sfixed(-0.9775,1,L_SIZE),
				to_sfixed(-0.9772,1,L_SIZE),
				to_sfixed(-0.9770,1,L_SIZE),
				to_sfixed(-0.9767,1,L_SIZE),
				to_sfixed(-0.9764,1,L_SIZE),
				to_sfixed(-0.9762,1,L_SIZE),
				to_sfixed(-0.9759,1,L_SIZE),
				to_sfixed(-0.9756,1,L_SIZE),
				to_sfixed(-0.9753,1,L_SIZE),
				to_sfixed(-0.9750,1,L_SIZE),
				to_sfixed(-0.9748,1,L_SIZE),
				to_sfixed(-0.9745,1,L_SIZE),
				to_sfixed(-0.9742,1,L_SIZE),
				to_sfixed(-0.9739,1,L_SIZE),
				to_sfixed(-0.9736,1,L_SIZE),
				to_sfixed(-0.9732,1,L_SIZE),
				to_sfixed(-0.9729,1,L_SIZE),
				to_sfixed(-0.9726,1,L_SIZE),
				to_sfixed(-0.9723,1,L_SIZE),
				to_sfixed(-0.9720,1,L_SIZE),
				to_sfixed(-0.9717,1,L_SIZE),
				to_sfixed(-0.9713,1,L_SIZE),
				to_sfixed(-0.9710,1,L_SIZE),
				to_sfixed(-0.9707,1,L_SIZE),
				to_sfixed(-0.9703,1,L_SIZE),
				to_sfixed(-0.9700,1,L_SIZE),
				to_sfixed(-0.9696,1,L_SIZE),
				to_sfixed(-0.9693,1,L_SIZE),
				to_sfixed(-0.9689,1,L_SIZE),
				to_sfixed(-0.9686,1,L_SIZE),
				to_sfixed(-0.9682,1,L_SIZE),
				to_sfixed(-0.9678,1,L_SIZE),
				to_sfixed(-0.9674,1,L_SIZE),
				to_sfixed(-0.9671,1,L_SIZE),
				to_sfixed(-0.9667,1,L_SIZE),
				to_sfixed(-0.9663,1,L_SIZE),
				to_sfixed(-0.9659,1,L_SIZE),
				to_sfixed(-0.9655,1,L_SIZE),
				to_sfixed(-0.9651,1,L_SIZE),
				to_sfixed(-0.9647,1,L_SIZE),
				to_sfixed(-0.9643,1,L_SIZE),
				to_sfixed(-0.9639,1,L_SIZE),
				to_sfixed(-0.9635,1,L_SIZE),
				to_sfixed(-0.9630,1,L_SIZE),
				to_sfixed(-0.9626,1,L_SIZE),
				to_sfixed(-0.9622,1,L_SIZE),
				to_sfixed(-0.9618,1,L_SIZE),
				to_sfixed(-0.9613,1,L_SIZE),
				to_sfixed(-0.9609,1,L_SIZE),
				to_sfixed(-0.9604,1,L_SIZE),
				to_sfixed(-0.9600,1,L_SIZE),
				to_sfixed(-0.9595,1,L_SIZE),
				to_sfixed(-0.9590,1,L_SIZE),
				to_sfixed(-0.9585,1,L_SIZE),
				to_sfixed(-0.9581,1,L_SIZE),
				to_sfixed(-0.9576,1,L_SIZE),
				to_sfixed(-0.9571,1,L_SIZE),
				to_sfixed(-0.9566,1,L_SIZE),
				to_sfixed(-0.9561,1,L_SIZE),
				to_sfixed(-0.9556,1,L_SIZE),
				to_sfixed(-0.9551,1,L_SIZE),
				to_sfixed(-0.9546,1,L_SIZE),
				to_sfixed(-0.9540,1,L_SIZE),
				to_sfixed(-0.9535,1,L_SIZE),
				to_sfixed(-0.9530,1,L_SIZE),
				to_sfixed(-0.9524,1,L_SIZE),
				to_sfixed(-0.9519,1,L_SIZE),
				to_sfixed(-0.9513,1,L_SIZE),
				to_sfixed(-0.9508,1,L_SIZE),
				to_sfixed(-0.9502,1,L_SIZE),
				to_sfixed(-0.9496,1,L_SIZE),
				to_sfixed(-0.9491,1,L_SIZE),
				to_sfixed(-0.9485,1,L_SIZE),
				to_sfixed(-0.9479,1,L_SIZE),
				to_sfixed(-0.9473,1,L_SIZE),
				to_sfixed(-0.9467,1,L_SIZE),
				to_sfixed(-0.9461,1,L_SIZE),
				to_sfixed(-0.9455,1,L_SIZE),
				to_sfixed(-0.9448,1,L_SIZE),
				to_sfixed(-0.9442,1,L_SIZE),
				to_sfixed(-0.9436,1,L_SIZE),
				to_sfixed(-0.9429,1,L_SIZE),
				to_sfixed(-0.9423,1,L_SIZE),
				to_sfixed(-0.9416,1,L_SIZE),
				to_sfixed(-0.9409,1,L_SIZE),
				to_sfixed(-0.9403,1,L_SIZE),
				to_sfixed(-0.9396,1,L_SIZE),
				to_sfixed(-0.9389,1,L_SIZE),
				to_sfixed(-0.9382,1,L_SIZE),
				to_sfixed(-0.9375,1,L_SIZE),
				to_sfixed(-0.9368,1,L_SIZE),
				to_sfixed(-0.9360,1,L_SIZE),
				to_sfixed(-0.9353,1,L_SIZE),
				to_sfixed(-0.9346,1,L_SIZE),
				to_sfixed(-0.9338,1,L_SIZE),
				to_sfixed(-0.9331,1,L_SIZE),
				to_sfixed(-0.9323,1,L_SIZE),
				to_sfixed(-0.9315,1,L_SIZE),
				to_sfixed(-0.9308,1,L_SIZE),
				to_sfixed(-0.9300,1,L_SIZE),
				to_sfixed(-0.9292,1,L_SIZE),
				to_sfixed(-0.9284,1,L_SIZE),
				to_sfixed(-0.9276,1,L_SIZE),
				to_sfixed(-0.9267,1,L_SIZE),
				to_sfixed(-0.9259,1,L_SIZE),
				to_sfixed(-0.9251,1,L_SIZE),
				to_sfixed(-0.9242,1,L_SIZE),
				to_sfixed(-0.9234,1,L_SIZE),
				to_sfixed(-0.9225,1,L_SIZE),
				to_sfixed(-0.9216,1,L_SIZE),
				to_sfixed(-0.9207,1,L_SIZE),
				to_sfixed(-0.9198,1,L_SIZE),
				to_sfixed(-0.9189,1,L_SIZE),
				to_sfixed(-0.9180,1,L_SIZE),
				to_sfixed(-0.9171,1,L_SIZE),
				to_sfixed(-0.9161,1,L_SIZE),
				to_sfixed(-0.9152,1,L_SIZE),
				to_sfixed(-0.9142,1,L_SIZE),
				to_sfixed(-0.9133,1,L_SIZE),
				to_sfixed(-0.9123,1,L_SIZE),
				to_sfixed(-0.9113,1,L_SIZE),
				to_sfixed(-0.9103,1,L_SIZE),
				to_sfixed(-0.9093,1,L_SIZE),
				to_sfixed(-0.9083,1,L_SIZE),
				to_sfixed(-0.9072,1,L_SIZE),
				to_sfixed(-0.9062,1,L_SIZE),
				to_sfixed(-0.9051,1,L_SIZE),
				to_sfixed(-0.9041,1,L_SIZE),
				to_sfixed(-0.9030,1,L_SIZE),
				to_sfixed(-0.9019,1,L_SIZE),
				to_sfixed(-0.9008,1,L_SIZE),
				to_sfixed(-0.8997,1,L_SIZE),
				to_sfixed(-0.8986,1,L_SIZE),
				to_sfixed(-0.8975,1,L_SIZE),
				to_sfixed(-0.8963,1,L_SIZE),
				to_sfixed(-0.8952,1,L_SIZE),
				to_sfixed(-0.8940,1,L_SIZE),
				to_sfixed(-0.8928,1,L_SIZE),
				to_sfixed(-0.8916,1,L_SIZE),
				to_sfixed(-0.8904,1,L_SIZE),
				to_sfixed(-0.8892,1,L_SIZE),
				to_sfixed(-0.8879,1,L_SIZE),
				to_sfixed(-0.8867,1,L_SIZE),
				to_sfixed(-0.8854,1,L_SIZE),
				to_sfixed(-0.8842,1,L_SIZE),
				to_sfixed(-0.8829,1,L_SIZE),
				to_sfixed(-0.8816,1,L_SIZE),
				to_sfixed(-0.8803,1,L_SIZE),
				to_sfixed(-0.8789,1,L_SIZE),
				to_sfixed(-0.8776,1,L_SIZE),
				to_sfixed(-0.8762,1,L_SIZE),
				to_sfixed(-0.8749,1,L_SIZE),
				to_sfixed(-0.8735,1,L_SIZE),
				to_sfixed(-0.8721,1,L_SIZE),
				to_sfixed(-0.8707,1,L_SIZE),
				to_sfixed(-0.8693,1,L_SIZE),
				to_sfixed(-0.8678,1,L_SIZE),
				to_sfixed(-0.8664,1,L_SIZE),
				to_sfixed(-0.8649,1,L_SIZE),
				to_sfixed(-0.8634,1,L_SIZE),
				to_sfixed(-0.8619,1,L_SIZE),
				to_sfixed(-0.8604,1,L_SIZE),
				to_sfixed(-0.8589,1,L_SIZE),
				to_sfixed(-0.8573,1,L_SIZE),
				to_sfixed(-0.8558,1,L_SIZE),
				to_sfixed(-0.8542,1,L_SIZE),
				to_sfixed(-0.8526,1,L_SIZE),
				to_sfixed(-0.8510,1,L_SIZE),
				to_sfixed(-0.8494,1,L_SIZE),
				to_sfixed(-0.8477,1,L_SIZE),
				to_sfixed(-0.8461,1,L_SIZE),
				to_sfixed(-0.8444,1,L_SIZE),
				to_sfixed(-0.8427,1,L_SIZE),
				to_sfixed(-0.8410,1,L_SIZE),
				to_sfixed(-0.8393,1,L_SIZE),
				to_sfixed(-0.8375,1,L_SIZE),
				to_sfixed(-0.8358,1,L_SIZE),
				to_sfixed(-0.8340,1,L_SIZE),
				to_sfixed(-0.8322,1,L_SIZE),
				to_sfixed(-0.8304,1,L_SIZE),
				to_sfixed(-0.8286,1,L_SIZE),
				to_sfixed(-0.8267,1,L_SIZE),
				to_sfixed(-0.8249,1,L_SIZE),
				to_sfixed(-0.8230,1,L_SIZE),
				to_sfixed(-0.8211,1,L_SIZE),
				to_sfixed(-0.8192,1,L_SIZE),
				to_sfixed(-0.8172,1,L_SIZE),
				to_sfixed(-0.8153,1,L_SIZE),
				to_sfixed(-0.8133,1,L_SIZE),
				to_sfixed(-0.8113,1,L_SIZE),
				to_sfixed(-0.8093,1,L_SIZE),
				to_sfixed(-0.8073,1,L_SIZE),
				to_sfixed(-0.8052,1,L_SIZE),
				to_sfixed(-0.8031,1,L_SIZE),
				to_sfixed(-0.8011,1,L_SIZE),
				to_sfixed(-0.7990,1,L_SIZE),
				to_sfixed(-0.7968,1,L_SIZE),
				to_sfixed(-0.7947,1,L_SIZE),
				to_sfixed(-0.7925,1,L_SIZE),
				to_sfixed(-0.7903,1,L_SIZE),
				to_sfixed(-0.7881,1,L_SIZE),
				to_sfixed(-0.7859,1,L_SIZE),
				to_sfixed(-0.7836,1,L_SIZE),
				to_sfixed(-0.7814,1,L_SIZE),
				to_sfixed(-0.7791,1,L_SIZE),
				to_sfixed(-0.7767,1,L_SIZE),
				to_sfixed(-0.7744,1,L_SIZE),
				to_sfixed(-0.7721,1,L_SIZE),
				to_sfixed(-0.7697,1,L_SIZE),
				to_sfixed(-0.7673,1,L_SIZE),
				to_sfixed(-0.7649,1,L_SIZE),
				to_sfixed(-0.7624,1,L_SIZE),
				to_sfixed(-0.7599,1,L_SIZE),
				to_sfixed(-0.7575,1,L_SIZE),
				to_sfixed(-0.7550,1,L_SIZE),
				to_sfixed(-0.7524,1,L_SIZE),
				to_sfixed(-0.7499,1,L_SIZE),
				to_sfixed(-0.7473,1,L_SIZE),
				to_sfixed(-0.7447,1,L_SIZE),
				to_sfixed(-0.7421,1,L_SIZE),
				to_sfixed(-0.7394,1,L_SIZE),
				to_sfixed(-0.7368,1,L_SIZE),
				to_sfixed(-0.7341,1,L_SIZE),
				to_sfixed(-0.7314,1,L_SIZE),
				to_sfixed(-0.7286,1,L_SIZE),
				to_sfixed(-0.7259,1,L_SIZE),
				to_sfixed(-0.7231,1,L_SIZE),
				to_sfixed(-0.7203,1,L_SIZE),
				to_sfixed(-0.7174,1,L_SIZE),
				to_sfixed(-0.7146,1,L_SIZE),
				to_sfixed(-0.7117,1,L_SIZE),
				to_sfixed(-0.7088,1,L_SIZE),
				to_sfixed(-0.7059,1,L_SIZE),
				to_sfixed(-0.7029,1,L_SIZE),
				to_sfixed(-0.6999,1,L_SIZE),
				to_sfixed(-0.6969,1,L_SIZE),
				to_sfixed(-0.6939,1,L_SIZE),
				to_sfixed(-0.6909,1,L_SIZE),
				to_sfixed(-0.6878,1,L_SIZE),
				to_sfixed(-0.6847,1,L_SIZE),
				to_sfixed(-0.6816,1,L_SIZE),
				to_sfixed(-0.6784,1,L_SIZE),
				to_sfixed(-0.6752,1,L_SIZE),
				to_sfixed(-0.6720,1,L_SIZE),
				to_sfixed(-0.6688,1,L_SIZE),
				to_sfixed(-0.6656,1,L_SIZE),
				to_sfixed(-0.6623,1,L_SIZE),
				to_sfixed(-0.6590,1,L_SIZE),
				to_sfixed(-0.6557,1,L_SIZE),
				to_sfixed(-0.6523,1,L_SIZE),
				to_sfixed(-0.6489,1,L_SIZE),
				to_sfixed(-0.6455,1,L_SIZE),
				to_sfixed(-0.6421,1,L_SIZE),
				to_sfixed(-0.6386,1,L_SIZE),
				to_sfixed(-0.6351,1,L_SIZE),
				to_sfixed(-0.6316,1,L_SIZE),
				to_sfixed(-0.6281,1,L_SIZE),
				to_sfixed(-0.6245,1,L_SIZE),
				to_sfixed(-0.6210,1,L_SIZE),
				to_sfixed(-0.6173,1,L_SIZE),
				to_sfixed(-0.6137,1,L_SIZE),
				to_sfixed(-0.6100,1,L_SIZE),
				to_sfixed(-0.6063,1,L_SIZE),
				to_sfixed(-0.6026,1,L_SIZE),
				to_sfixed(-0.5989,1,L_SIZE),
				to_sfixed(-0.5951,1,L_SIZE),
				to_sfixed(-0.5913,1,L_SIZE),
				to_sfixed(-0.5875,1,L_SIZE),
				to_sfixed(-0.5836,1,L_SIZE),
				to_sfixed(-0.5798,1,L_SIZE),
				to_sfixed(-0.5759,1,L_SIZE),
				to_sfixed(-0.5719,1,L_SIZE),
				to_sfixed(-0.5680,1,L_SIZE),
				to_sfixed(-0.5640,1,L_SIZE),
				to_sfixed(-0.5600,1,L_SIZE),
				to_sfixed(-0.5560,1,L_SIZE),
				to_sfixed(-0.5519,1,L_SIZE),
				to_sfixed(-0.5478,1,L_SIZE),
				to_sfixed(-0.5437,1,L_SIZE),
				to_sfixed(-0.5395,1,L_SIZE),
				to_sfixed(-0.5354,1,L_SIZE),
				to_sfixed(-0.5312,1,L_SIZE),
				to_sfixed(-0.5270,1,L_SIZE),
				to_sfixed(-0.5227,1,L_SIZE),
				to_sfixed(-0.5185,1,L_SIZE),
				to_sfixed(-0.5142,1,L_SIZE),
				to_sfixed(-0.5098,1,L_SIZE),
				to_sfixed(-0.5055,1,L_SIZE),
				to_sfixed(-0.5011,1,L_SIZE),
				to_sfixed(-0.4967,1,L_SIZE),
				to_sfixed(-0.4923,1,L_SIZE),
				to_sfixed(-0.4878,1,L_SIZE),
				to_sfixed(-0.4833,1,L_SIZE),
				to_sfixed(-0.4788,1,L_SIZE),
				to_sfixed(-0.4743,1,L_SIZE),
				to_sfixed(-0.4698,1,L_SIZE),
				to_sfixed(-0.4652,1,L_SIZE),
				to_sfixed(-0.4606,1,L_SIZE),
				to_sfixed(-0.4560,1,L_SIZE),
				to_sfixed(-0.4513,1,L_SIZE),
				to_sfixed(-0.4466,1,L_SIZE),
				to_sfixed(-0.4419,1,L_SIZE),
				to_sfixed(-0.4372,1,L_SIZE),
				to_sfixed(-0.4324,1,L_SIZE),
				to_sfixed(-0.4277,1,L_SIZE),
				to_sfixed(-0.4229,1,L_SIZE),
				to_sfixed(-0.4180,1,L_SIZE),
				to_sfixed(-0.4132,1,L_SIZE),
				to_sfixed(-0.4083,1,L_SIZE),
				to_sfixed(-0.4034,1,L_SIZE),
				to_sfixed(-0.3985,1,L_SIZE),
				to_sfixed(-0.3936,1,L_SIZE),
				to_sfixed(-0.3886,1,L_SIZE),
				to_sfixed(-0.3836,1,L_SIZE),
				to_sfixed(-0.3786,1,L_SIZE),
				to_sfixed(-0.3736,1,L_SIZE),
				to_sfixed(-0.3685,1,L_SIZE),
				to_sfixed(-0.3635,1,L_SIZE),
				to_sfixed(-0.3584,1,L_SIZE),
				to_sfixed(-0.3532,1,L_SIZE),
				to_sfixed(-0.3481,1,L_SIZE),
				to_sfixed(-0.3429,1,L_SIZE),
				to_sfixed(-0.3378,1,L_SIZE),
				to_sfixed(-0.3326,1,L_SIZE),
				to_sfixed(-0.3273,1,L_SIZE),
				to_sfixed(-0.3221,1,L_SIZE),
				to_sfixed(-0.3168,1,L_SIZE),
				to_sfixed(-0.3116,1,L_SIZE),
				to_sfixed(-0.3063,1,L_SIZE),
				to_sfixed(-0.3009,1,L_SIZE),
				to_sfixed(-0.2956,1,L_SIZE),
				to_sfixed(-0.2902,1,L_SIZE),
				to_sfixed(-0.2849,1,L_SIZE),
				to_sfixed(-0.2795,1,L_SIZE),
				to_sfixed(-0.2741,1,L_SIZE),
				to_sfixed(-0.2686,1,L_SIZE),
				to_sfixed(-0.2632,1,L_SIZE),
				to_sfixed(-0.2577,1,L_SIZE),
				to_sfixed(-0.2522,1,L_SIZE),
				to_sfixed(-0.2468,1,L_SIZE),
				to_sfixed(-0.2412,1,L_SIZE),
				to_sfixed(-0.2357,1,L_SIZE),
				to_sfixed(-0.2302,1,L_SIZE),
				to_sfixed(-0.2246,1,L_SIZE),
				to_sfixed(-0.2190,1,L_SIZE),
				to_sfixed(-0.2135,1,L_SIZE),
				to_sfixed(-0.2079,1,L_SIZE),
				to_sfixed(-0.2023,1,L_SIZE),
				to_sfixed(-0.1966,1,L_SIZE),
				to_sfixed(-0.1910,1,L_SIZE),
				to_sfixed(-0.1853,1,L_SIZE),
				to_sfixed(-0.1797,1,L_SIZE),
				to_sfixed(-0.1740,1,L_SIZE),
				to_sfixed(-0.1683,1,L_SIZE),
				to_sfixed(-0.1626,1,L_SIZE),
				to_sfixed(-0.1569,1,L_SIZE),
				to_sfixed(-0.1512,1,L_SIZE),
				to_sfixed(-0.1454,1,L_SIZE),
				to_sfixed(-0.1397,1,L_SIZE),
				to_sfixed(-0.1340,1,L_SIZE),
				to_sfixed(-0.1282,1,L_SIZE),
				to_sfixed(-0.1224,1,L_SIZE),
				to_sfixed(-0.1167,1,L_SIZE),
				to_sfixed(-0.1109,1,L_SIZE),
				to_sfixed(-0.1051,1,L_SIZE),
				to_sfixed(-0.0993,1,L_SIZE),
				to_sfixed(-0.0935,1,L_SIZE),
				to_sfixed(-0.0877,1,L_SIZE),
				to_sfixed(-0.0818,1,L_SIZE),
				to_sfixed(-0.0760,1,L_SIZE),
				to_sfixed(-0.0702,1,L_SIZE),
				to_sfixed(-0.0644,1,L_SIZE),
				to_sfixed(-0.0585,1,L_SIZE),
				to_sfixed(-0.0527,1,L_SIZE),
				to_sfixed(-0.0468,1,L_SIZE),
				to_sfixed(-0.0410,1,L_SIZE),
				to_sfixed(-0.0351,1,L_SIZE),
				to_sfixed(-0.0293,1,L_SIZE),
				to_sfixed(-0.0234,1,L_SIZE),
				to_sfixed(-0.0176,1,L_SIZE),
				to_sfixed(-0.0117,1,L_SIZE),
				to_sfixed(-0.0059,1,L_SIZE),
				to_sfixed(0.0000,1,L_SIZE),
				to_sfixed(0.0059,1,L_SIZE),
				to_sfixed(0.0117,1,L_SIZE),
				to_sfixed(0.0176,1,L_SIZE),
				to_sfixed(0.0234,1,L_SIZE),
				to_sfixed(0.0293,1,L_SIZE),
				to_sfixed(0.0351,1,L_SIZE),
				to_sfixed(0.0410,1,L_SIZE),
				to_sfixed(0.0468,1,L_SIZE),
				to_sfixed(0.0527,1,L_SIZE),
				to_sfixed(0.0585,1,L_SIZE),
				to_sfixed(0.0644,1,L_SIZE),
				to_sfixed(0.0702,1,L_SIZE),
				to_sfixed(0.0760,1,L_SIZE),
				to_sfixed(0.0818,1,L_SIZE),
				to_sfixed(0.0877,1,L_SIZE),
				to_sfixed(0.0935,1,L_SIZE),
				to_sfixed(0.0993,1,L_SIZE),
				to_sfixed(0.1051,1,L_SIZE),
				to_sfixed(0.1109,1,L_SIZE),
				to_sfixed(0.1167,1,L_SIZE),
				to_sfixed(0.1224,1,L_SIZE),
				to_sfixed(0.1282,1,L_SIZE),
				to_sfixed(0.1340,1,L_SIZE),
				to_sfixed(0.1397,1,L_SIZE),
				to_sfixed(0.1454,1,L_SIZE),
				to_sfixed(0.1512,1,L_SIZE),
				to_sfixed(0.1569,1,L_SIZE),
				to_sfixed(0.1626,1,L_SIZE),
				to_sfixed(0.1683,1,L_SIZE),
				to_sfixed(0.1740,1,L_SIZE),
				to_sfixed(0.1797,1,L_SIZE),
				to_sfixed(0.1853,1,L_SIZE),
				to_sfixed(0.1910,1,L_SIZE),
				to_sfixed(0.1966,1,L_SIZE),
				to_sfixed(0.2023,1,L_SIZE),
				to_sfixed(0.2079,1,L_SIZE),
				to_sfixed(0.2135,1,L_SIZE),
				to_sfixed(0.2190,1,L_SIZE),
				to_sfixed(0.2246,1,L_SIZE),
				to_sfixed(0.2302,1,L_SIZE),
				to_sfixed(0.2357,1,L_SIZE),
				to_sfixed(0.2412,1,L_SIZE),
				to_sfixed(0.2468,1,L_SIZE),
				to_sfixed(0.2522,1,L_SIZE),
				to_sfixed(0.2577,1,L_SIZE),
				to_sfixed(0.2632,1,L_SIZE),
				to_sfixed(0.2686,1,L_SIZE),
				to_sfixed(0.2741,1,L_SIZE),
				to_sfixed(0.2795,1,L_SIZE),
				to_sfixed(0.2849,1,L_SIZE),
				to_sfixed(0.2902,1,L_SIZE),
				to_sfixed(0.2956,1,L_SIZE),
				to_sfixed(0.3009,1,L_SIZE),
				to_sfixed(0.3063,1,L_SIZE),
				to_sfixed(0.3116,1,L_SIZE),
				to_sfixed(0.3168,1,L_SIZE),
				to_sfixed(0.3221,1,L_SIZE),
				to_sfixed(0.3273,1,L_SIZE),
				to_sfixed(0.3326,1,L_SIZE),
				to_sfixed(0.3378,1,L_SIZE),
				to_sfixed(0.3429,1,L_SIZE),
				to_sfixed(0.3481,1,L_SIZE),
				to_sfixed(0.3532,1,L_SIZE),
				to_sfixed(0.3584,1,L_SIZE),
				to_sfixed(0.3635,1,L_SIZE),
				to_sfixed(0.3685,1,L_SIZE),
				to_sfixed(0.3736,1,L_SIZE),
				to_sfixed(0.3786,1,L_SIZE),
				to_sfixed(0.3836,1,L_SIZE),
				to_sfixed(0.3886,1,L_SIZE),
				to_sfixed(0.3936,1,L_SIZE),
				to_sfixed(0.3985,1,L_SIZE),
				to_sfixed(0.4034,1,L_SIZE),
				to_sfixed(0.4083,1,L_SIZE),
				to_sfixed(0.4132,1,L_SIZE),
				to_sfixed(0.4180,1,L_SIZE),
				to_sfixed(0.4229,1,L_SIZE),
				to_sfixed(0.4277,1,L_SIZE),
				to_sfixed(0.4324,1,L_SIZE),
				to_sfixed(0.4372,1,L_SIZE),
				to_sfixed(0.4419,1,L_SIZE),
				to_sfixed(0.4466,1,L_SIZE),
				to_sfixed(0.4513,1,L_SIZE),
				to_sfixed(0.4560,1,L_SIZE),
				to_sfixed(0.4606,1,L_SIZE),
				to_sfixed(0.4652,1,L_SIZE),
				to_sfixed(0.4698,1,L_SIZE),
				to_sfixed(0.4743,1,L_SIZE),
				to_sfixed(0.4788,1,L_SIZE),
				to_sfixed(0.4833,1,L_SIZE),
				to_sfixed(0.4878,1,L_SIZE),
				to_sfixed(0.4923,1,L_SIZE),
				to_sfixed(0.4967,1,L_SIZE),
				to_sfixed(0.5011,1,L_SIZE),
				to_sfixed(0.5055,1,L_SIZE),
				to_sfixed(0.5098,1,L_SIZE),
				to_sfixed(0.5142,1,L_SIZE),
				to_sfixed(0.5185,1,L_SIZE),
				to_sfixed(0.5227,1,L_SIZE),
				to_sfixed(0.5270,1,L_SIZE),
				to_sfixed(0.5312,1,L_SIZE),
				to_sfixed(0.5354,1,L_SIZE),
				to_sfixed(0.5395,1,L_SIZE),
				to_sfixed(0.5437,1,L_SIZE),
				to_sfixed(0.5478,1,L_SIZE),
				to_sfixed(0.5519,1,L_SIZE),
				to_sfixed(0.5560,1,L_SIZE),
				to_sfixed(0.5600,1,L_SIZE),
				to_sfixed(0.5640,1,L_SIZE),
				to_sfixed(0.5680,1,L_SIZE),
				to_sfixed(0.5719,1,L_SIZE),
				to_sfixed(0.5759,1,L_SIZE),
				to_sfixed(0.5798,1,L_SIZE),
				to_sfixed(0.5836,1,L_SIZE),
				to_sfixed(0.5875,1,L_SIZE),
				to_sfixed(0.5913,1,L_SIZE),
				to_sfixed(0.5951,1,L_SIZE),
				to_sfixed(0.5989,1,L_SIZE),
				to_sfixed(0.6026,1,L_SIZE),
				to_sfixed(0.6063,1,L_SIZE),
				to_sfixed(0.6100,1,L_SIZE),
				to_sfixed(0.6137,1,L_SIZE),
				to_sfixed(0.6173,1,L_SIZE),
				to_sfixed(0.6210,1,L_SIZE),
				to_sfixed(0.6245,1,L_SIZE),
				to_sfixed(0.6281,1,L_SIZE),
				to_sfixed(0.6316,1,L_SIZE),
				to_sfixed(0.6351,1,L_SIZE),
				to_sfixed(0.6386,1,L_SIZE),
				to_sfixed(0.6421,1,L_SIZE),
				to_sfixed(0.6455,1,L_SIZE),
				to_sfixed(0.6489,1,L_SIZE),
				to_sfixed(0.6523,1,L_SIZE),
				to_sfixed(0.6557,1,L_SIZE),
				to_sfixed(0.6590,1,L_SIZE),
				to_sfixed(0.6623,1,L_SIZE),
				to_sfixed(0.6656,1,L_SIZE),
				to_sfixed(0.6688,1,L_SIZE),
				to_sfixed(0.6720,1,L_SIZE),
				to_sfixed(0.6752,1,L_SIZE),
				to_sfixed(0.6784,1,L_SIZE),
				to_sfixed(0.6816,1,L_SIZE),
				to_sfixed(0.6847,1,L_SIZE),
				to_sfixed(0.6878,1,L_SIZE),
				to_sfixed(0.6909,1,L_SIZE),
				to_sfixed(0.6939,1,L_SIZE),
				to_sfixed(0.6969,1,L_SIZE),
				to_sfixed(0.6999,1,L_SIZE),
				to_sfixed(0.7029,1,L_SIZE),
				to_sfixed(0.7059,1,L_SIZE),
				to_sfixed(0.7088,1,L_SIZE),
				to_sfixed(0.7117,1,L_SIZE),
				to_sfixed(0.7146,1,L_SIZE),
				to_sfixed(0.7174,1,L_SIZE),
				to_sfixed(0.7203,1,L_SIZE),
				to_sfixed(0.7231,1,L_SIZE),
				to_sfixed(0.7259,1,L_SIZE),
				to_sfixed(0.7286,1,L_SIZE),
				to_sfixed(0.7314,1,L_SIZE),
				to_sfixed(0.7341,1,L_SIZE),
				to_sfixed(0.7368,1,L_SIZE),
				to_sfixed(0.7394,1,L_SIZE),
				to_sfixed(0.7421,1,L_SIZE),
				to_sfixed(0.7447,1,L_SIZE),
				to_sfixed(0.7473,1,L_SIZE),
				to_sfixed(0.7499,1,L_SIZE),
				to_sfixed(0.7524,1,L_SIZE),
				to_sfixed(0.7550,1,L_SIZE),
				to_sfixed(0.7575,1,L_SIZE),
				to_sfixed(0.7599,1,L_SIZE),
				to_sfixed(0.7624,1,L_SIZE),
				to_sfixed(0.7649,1,L_SIZE),
				to_sfixed(0.7673,1,L_SIZE),
				to_sfixed(0.7697,1,L_SIZE),
				to_sfixed(0.7721,1,L_SIZE),
				to_sfixed(0.7744,1,L_SIZE),
				to_sfixed(0.7767,1,L_SIZE),
				to_sfixed(0.7791,1,L_SIZE),
				to_sfixed(0.7814,1,L_SIZE),
				to_sfixed(0.7836,1,L_SIZE),
				to_sfixed(0.7859,1,L_SIZE),
				to_sfixed(0.7881,1,L_SIZE),
				to_sfixed(0.7903,1,L_SIZE),
				to_sfixed(0.7925,1,L_SIZE),
				to_sfixed(0.7947,1,L_SIZE),
				to_sfixed(0.7968,1,L_SIZE),
				to_sfixed(0.7990,1,L_SIZE),
				to_sfixed(0.8011,1,L_SIZE),
				to_sfixed(0.8031,1,L_SIZE),
				to_sfixed(0.8052,1,L_SIZE),
				to_sfixed(0.8073,1,L_SIZE),
				to_sfixed(0.8093,1,L_SIZE),
				to_sfixed(0.8113,1,L_SIZE),
				to_sfixed(0.8133,1,L_SIZE),
				to_sfixed(0.8153,1,L_SIZE),
				to_sfixed(0.8172,1,L_SIZE),
				to_sfixed(0.8192,1,L_SIZE),
				to_sfixed(0.8211,1,L_SIZE),
				to_sfixed(0.8230,1,L_SIZE),
				to_sfixed(0.8249,1,L_SIZE),
				to_sfixed(0.8267,1,L_SIZE),
				to_sfixed(0.8286,1,L_SIZE),
				to_sfixed(0.8304,1,L_SIZE),
				to_sfixed(0.8322,1,L_SIZE),
				to_sfixed(0.8340,1,L_SIZE),
				to_sfixed(0.8358,1,L_SIZE),
				to_sfixed(0.8375,1,L_SIZE),
				to_sfixed(0.8393,1,L_SIZE),
				to_sfixed(0.8410,1,L_SIZE),
				to_sfixed(0.8427,1,L_SIZE),
				to_sfixed(0.8444,1,L_SIZE),
				to_sfixed(0.8461,1,L_SIZE),
				to_sfixed(0.8477,1,L_SIZE),
				to_sfixed(0.8494,1,L_SIZE),
				to_sfixed(0.8510,1,L_SIZE),
				to_sfixed(0.8526,1,L_SIZE),
				to_sfixed(0.8542,1,L_SIZE),
				to_sfixed(0.8558,1,L_SIZE),
				to_sfixed(0.8573,1,L_SIZE),
				to_sfixed(0.8589,1,L_SIZE),
				to_sfixed(0.8604,1,L_SIZE),
				to_sfixed(0.8619,1,L_SIZE),
				to_sfixed(0.8634,1,L_SIZE),
				to_sfixed(0.8649,1,L_SIZE),
				to_sfixed(0.8664,1,L_SIZE),
				to_sfixed(0.8678,1,L_SIZE),
				to_sfixed(0.8693,1,L_SIZE),
				to_sfixed(0.8707,1,L_SIZE),
				to_sfixed(0.8721,1,L_SIZE),
				to_sfixed(0.8735,1,L_SIZE),
				to_sfixed(0.8749,1,L_SIZE),
				to_sfixed(0.8762,1,L_SIZE),
				to_sfixed(0.8776,1,L_SIZE),
				to_sfixed(0.8789,1,L_SIZE),
				to_sfixed(0.8803,1,L_SIZE),
				to_sfixed(0.8816,1,L_SIZE),
				to_sfixed(0.8829,1,L_SIZE),
				to_sfixed(0.8842,1,L_SIZE),
				to_sfixed(0.8854,1,L_SIZE),
				to_sfixed(0.8867,1,L_SIZE),
				to_sfixed(0.8879,1,L_SIZE),
				to_sfixed(0.8892,1,L_SIZE),
				to_sfixed(0.8904,1,L_SIZE),
				to_sfixed(0.8916,1,L_SIZE),
				to_sfixed(0.8928,1,L_SIZE),
				to_sfixed(0.8940,1,L_SIZE),
				to_sfixed(0.8952,1,L_SIZE),
				to_sfixed(0.8963,1,L_SIZE),
				to_sfixed(0.8975,1,L_SIZE),
				to_sfixed(0.8986,1,L_SIZE),
				to_sfixed(0.8997,1,L_SIZE),
				to_sfixed(0.9008,1,L_SIZE),
				to_sfixed(0.9019,1,L_SIZE),
				to_sfixed(0.9030,1,L_SIZE),
				to_sfixed(0.9041,1,L_SIZE),
				to_sfixed(0.9051,1,L_SIZE),
				to_sfixed(0.9062,1,L_SIZE),
				to_sfixed(0.9072,1,L_SIZE),
				to_sfixed(0.9083,1,L_SIZE),
				to_sfixed(0.9093,1,L_SIZE),
				to_sfixed(0.9103,1,L_SIZE),
				to_sfixed(0.9113,1,L_SIZE),
				to_sfixed(0.9123,1,L_SIZE),
				to_sfixed(0.9133,1,L_SIZE),
				to_sfixed(0.9142,1,L_SIZE),
				to_sfixed(0.9152,1,L_SIZE),
				to_sfixed(0.9161,1,L_SIZE),
				to_sfixed(0.9171,1,L_SIZE),
				to_sfixed(0.9180,1,L_SIZE),
				to_sfixed(0.9189,1,L_SIZE),
				to_sfixed(0.9198,1,L_SIZE),
				to_sfixed(0.9207,1,L_SIZE),
				to_sfixed(0.9216,1,L_SIZE),
				to_sfixed(0.9225,1,L_SIZE),
				to_sfixed(0.9234,1,L_SIZE),
				to_sfixed(0.9242,1,L_SIZE),
				to_sfixed(0.9251,1,L_SIZE),
				to_sfixed(0.9259,1,L_SIZE),
				to_sfixed(0.9267,1,L_SIZE),
				to_sfixed(0.9276,1,L_SIZE),
				to_sfixed(0.9284,1,L_SIZE),
				to_sfixed(0.9292,1,L_SIZE),
				to_sfixed(0.9300,1,L_SIZE),
				to_sfixed(0.9308,1,L_SIZE),
				to_sfixed(0.9315,1,L_SIZE),
				to_sfixed(0.9323,1,L_SIZE),
				to_sfixed(0.9331,1,L_SIZE),
				to_sfixed(0.9338,1,L_SIZE),
				to_sfixed(0.9346,1,L_SIZE),
				to_sfixed(0.9353,1,L_SIZE),
				to_sfixed(0.9360,1,L_SIZE),
				to_sfixed(0.9368,1,L_SIZE),
				to_sfixed(0.9375,1,L_SIZE),
				to_sfixed(0.9382,1,L_SIZE),
				to_sfixed(0.9389,1,L_SIZE),
				to_sfixed(0.9396,1,L_SIZE),
				to_sfixed(0.9403,1,L_SIZE),
				to_sfixed(0.9409,1,L_SIZE),
				to_sfixed(0.9416,1,L_SIZE),
				to_sfixed(0.9423,1,L_SIZE),
				to_sfixed(0.9429,1,L_SIZE),
				to_sfixed(0.9436,1,L_SIZE),
				to_sfixed(0.9442,1,L_SIZE),
				to_sfixed(0.9448,1,L_SIZE),
				to_sfixed(0.9455,1,L_SIZE),
				to_sfixed(0.9461,1,L_SIZE),
				to_sfixed(0.9467,1,L_SIZE),
				to_sfixed(0.9473,1,L_SIZE),
				to_sfixed(0.9479,1,L_SIZE),
				to_sfixed(0.9485,1,L_SIZE),
				to_sfixed(0.9491,1,L_SIZE),
				to_sfixed(0.9496,1,L_SIZE),
				to_sfixed(0.9502,1,L_SIZE),
				to_sfixed(0.9508,1,L_SIZE),
				to_sfixed(0.9513,1,L_SIZE),
				to_sfixed(0.9519,1,L_SIZE),
				to_sfixed(0.9524,1,L_SIZE),
				to_sfixed(0.9530,1,L_SIZE),
				to_sfixed(0.9535,1,L_SIZE),
				to_sfixed(0.9540,1,L_SIZE),
				to_sfixed(0.9546,1,L_SIZE),
				to_sfixed(0.9551,1,L_SIZE),
				to_sfixed(0.9556,1,L_SIZE),
				to_sfixed(0.9561,1,L_SIZE),
				to_sfixed(0.9566,1,L_SIZE),
				to_sfixed(0.9571,1,L_SIZE),
				to_sfixed(0.9576,1,L_SIZE),
				to_sfixed(0.9581,1,L_SIZE),
				to_sfixed(0.9585,1,L_SIZE),
				to_sfixed(0.9590,1,L_SIZE),
				to_sfixed(0.9595,1,L_SIZE),
				to_sfixed(0.9600,1,L_SIZE),
				to_sfixed(0.9604,1,L_SIZE),
				to_sfixed(0.9609,1,L_SIZE),
				to_sfixed(0.9613,1,L_SIZE),
				to_sfixed(0.9618,1,L_SIZE),
				to_sfixed(0.9622,1,L_SIZE),
				to_sfixed(0.9626,1,L_SIZE),
				to_sfixed(0.9630,1,L_SIZE),
				to_sfixed(0.9635,1,L_SIZE),
				to_sfixed(0.9639,1,L_SIZE),
				to_sfixed(0.9643,1,L_SIZE),
				to_sfixed(0.9647,1,L_SIZE),
				to_sfixed(0.9651,1,L_SIZE),
				to_sfixed(0.9655,1,L_SIZE),
				to_sfixed(0.9659,1,L_SIZE),
				to_sfixed(0.9663,1,L_SIZE),
				to_sfixed(0.9667,1,L_SIZE),
				to_sfixed(0.9671,1,L_SIZE),
				to_sfixed(0.9674,1,L_SIZE),
				to_sfixed(0.9678,1,L_SIZE),
				to_sfixed(0.9682,1,L_SIZE),
				to_sfixed(0.9686,1,L_SIZE),
				to_sfixed(0.9689,1,L_SIZE),
				to_sfixed(0.9693,1,L_SIZE),
				to_sfixed(0.9696,1,L_SIZE),
				to_sfixed(0.9700,1,L_SIZE),
				to_sfixed(0.9703,1,L_SIZE),
				to_sfixed(0.9707,1,L_SIZE),
				to_sfixed(0.9710,1,L_SIZE),
				to_sfixed(0.9713,1,L_SIZE),
				to_sfixed(0.9717,1,L_SIZE),
				to_sfixed(0.9720,1,L_SIZE),
				to_sfixed(0.9723,1,L_SIZE),
				to_sfixed(0.9726,1,L_SIZE),
				to_sfixed(0.9729,1,L_SIZE),
				to_sfixed(0.9732,1,L_SIZE),
				to_sfixed(0.9736,1,L_SIZE),
				to_sfixed(0.9739,1,L_SIZE),
				to_sfixed(0.9742,1,L_SIZE),
				to_sfixed(0.9745,1,L_SIZE),
				to_sfixed(0.9748,1,L_SIZE),
				to_sfixed(0.9750,1,L_SIZE),
				to_sfixed(0.9753,1,L_SIZE),
				to_sfixed(0.9756,1,L_SIZE),
				to_sfixed(0.9759,1,L_SIZE),
				to_sfixed(0.9762,1,L_SIZE),
				to_sfixed(0.9764,1,L_SIZE),
				to_sfixed(0.9767,1,L_SIZE),
				to_sfixed(0.9770,1,L_SIZE),
				to_sfixed(0.9772,1,L_SIZE),
				to_sfixed(0.9775,1,L_SIZE),
				to_sfixed(0.9778,1,L_SIZE),
				to_sfixed(0.9780,1,L_SIZE),
				to_sfixed(0.9783,1,L_SIZE),
				to_sfixed(0.9785,1,L_SIZE),
				to_sfixed(0.9788,1,L_SIZE),
				to_sfixed(0.9790,1,L_SIZE),
				to_sfixed(0.9793,1,L_SIZE),
				to_sfixed(0.9795,1,L_SIZE),
				to_sfixed(0.9797,1,L_SIZE),
				to_sfixed(0.9800,1,L_SIZE),
				to_sfixed(0.9802,1,L_SIZE),
				to_sfixed(0.9804,1,L_SIZE),
				to_sfixed(0.9807,1,L_SIZE),
				to_sfixed(0.9809,1,L_SIZE),
				to_sfixed(0.9811,1,L_SIZE),
				to_sfixed(0.9813,1,L_SIZE),
				to_sfixed(0.9815,1,L_SIZE),
				to_sfixed(0.9817,1,L_SIZE),
				to_sfixed(0.9820,1,L_SIZE),
				to_sfixed(0.9822,1,L_SIZE),
				to_sfixed(0.9824,1,L_SIZE),
				to_sfixed(0.9826,1,L_SIZE),
				to_sfixed(0.9828,1,L_SIZE),
				to_sfixed(0.9830,1,L_SIZE),
				to_sfixed(0.9832,1,L_SIZE),
				to_sfixed(0.9834,1,L_SIZE),
				to_sfixed(0.9836,1,L_SIZE),
				to_sfixed(0.9838,1,L_SIZE),
				to_sfixed(0.9839,1,L_SIZE),
				to_sfixed(0.9841,1,L_SIZE),
				to_sfixed(0.9843,1,L_SIZE),
				to_sfixed(0.9845,1,L_SIZE),
				to_sfixed(0.9847,1,L_SIZE),
				to_sfixed(0.9848,1,L_SIZE),
				to_sfixed(0.9850,1,L_SIZE),
				to_sfixed(0.9852,1,L_SIZE),
				to_sfixed(0.9854,1,L_SIZE),
				to_sfixed(0.9855,1,L_SIZE),
				to_sfixed(0.9857,1,L_SIZE),
				to_sfixed(0.9859,1,L_SIZE),
				to_sfixed(0.9860,1,L_SIZE),
				to_sfixed(0.9862,1,L_SIZE),
				to_sfixed(0.9864,1,L_SIZE),
				to_sfixed(0.9865,1,L_SIZE),
				to_sfixed(0.9867,1,L_SIZE),
				to_sfixed(0.9868,1,L_SIZE),
				to_sfixed(0.9870,1,L_SIZE),
				to_sfixed(0.9871,1,L_SIZE),
				to_sfixed(0.9873,1,L_SIZE),
				to_sfixed(0.9874,1,L_SIZE),
				to_sfixed(0.9876,1,L_SIZE),
				to_sfixed(0.9877,1,L_SIZE),
				to_sfixed(0.9879,1,L_SIZE),
				to_sfixed(0.9880,1,L_SIZE),
				to_sfixed(0.9881,1,L_SIZE),
				to_sfixed(0.9883,1,L_SIZE),
				to_sfixed(0.9884,1,L_SIZE),
				to_sfixed(0.9885,1,L_SIZE),
				to_sfixed(0.9887,1,L_SIZE),
				to_sfixed(0.9888,1,L_SIZE),
				to_sfixed(0.9889,1,L_SIZE),
				to_sfixed(0.9891,1,L_SIZE),
				to_sfixed(0.9892,1,L_SIZE),
				to_sfixed(0.9893,1,L_SIZE),
				to_sfixed(0.9894,1,L_SIZE),
				to_sfixed(0.9896,1,L_SIZE),
				to_sfixed(0.9897,1,L_SIZE),
				to_sfixed(0.9898,1,L_SIZE),
				to_sfixed(0.9899,1,L_SIZE),
				to_sfixed(0.9900,1,L_SIZE),
				to_sfixed(0.9902,1,L_SIZE),
				to_sfixed(0.9903,1,L_SIZE),
				to_sfixed(0.9904,1,L_SIZE),
				to_sfixed(0.9905,1,L_SIZE),
				to_sfixed(0.9906,1,L_SIZE),
				to_sfixed(0.9907,1,L_SIZE),
				to_sfixed(0.9908,1,L_SIZE),
				to_sfixed(0.9909,1,L_SIZE),
				to_sfixed(0.9910,1,L_SIZE),
				to_sfixed(0.9911,1,L_SIZE),
				to_sfixed(0.9912,1,L_SIZE),
				to_sfixed(0.9913,1,L_SIZE),
				to_sfixed(0.9914,1,L_SIZE),
				to_sfixed(0.9915,1,L_SIZE),
				to_sfixed(0.9916,1,L_SIZE),
				to_sfixed(0.9917,1,L_SIZE),
				to_sfixed(0.9918,1,L_SIZE),
				to_sfixed(0.9919,1,L_SIZE),
				to_sfixed(0.9920,1,L_SIZE),
				to_sfixed(0.9921,1,L_SIZE),
				to_sfixed(0.9922,1,L_SIZE),
				to_sfixed(0.9923,1,L_SIZE),
				to_sfixed(0.9924,1,L_SIZE),
				to_sfixed(0.9925,1,L_SIZE),
				to_sfixed(0.9926,1,L_SIZE),
				to_sfixed(0.9926,1,L_SIZE),
				to_sfixed(0.9927,1,L_SIZE),
				to_sfixed(0.9928,1,L_SIZE),
				to_sfixed(0.9929,1,L_SIZE),
				to_sfixed(0.9930,1,L_SIZE),
				to_sfixed(0.9931,1,L_SIZE),
				to_sfixed(0.9931,1,L_SIZE),
				to_sfixed(0.9932,1,L_SIZE),
				to_sfixed(0.9933,1,L_SIZE),
				to_sfixed(0.9934,1,L_SIZE),
				to_sfixed(0.9935,1,L_SIZE),
				to_sfixed(0.9935,1,L_SIZE),
				to_sfixed(0.9936,1,L_SIZE),
				to_sfixed(0.9937,1,L_SIZE),
				to_sfixed(0.9938,1,L_SIZE),
				to_sfixed(0.9938,1,L_SIZE),
				to_sfixed(0.9939,1,L_SIZE),
				to_sfixed(0.9940,1,L_SIZE),
				to_sfixed(0.9940,1,L_SIZE),
				to_sfixed(0.9941,1,L_SIZE),
				to_sfixed(0.9942,1,L_SIZE),
				to_sfixed(0.9942,1,L_SIZE),
				to_sfixed(0.9943,1,L_SIZE),
				to_sfixed(0.9944,1,L_SIZE),
				to_sfixed(0.9944,1,L_SIZE),
				to_sfixed(0.9945,1,L_SIZE),
				to_sfixed(0.9946,1,L_SIZE),
				to_sfixed(0.9946,1,L_SIZE),
				to_sfixed(0.9947,1,L_SIZE),
				to_sfixed(0.9948,1,L_SIZE),
				to_sfixed(0.9948,1,L_SIZE),
				to_sfixed(0.9949,1,L_SIZE),
				to_sfixed(0.9949,1,L_SIZE),
				to_sfixed(0.9950,1,L_SIZE)
			);
	  -- Signals
	signal IN_UNSIGNED						: unsigned((NUMBER_OF_BITS-1) downto 0);
	signal LOOKUP_TABLE_K 					: unsigned((NUMBER_OF_BITS-1) downto 0);
	signal LOOKUP_TABLE_OUT 				: INPUT_SFIXED;
	signal LOOKUP_TABLE_OUT_CONSTRAINED	: CONSTRAINED_SFIXED;
	signal UNIT_DELAY_OUT					: CONSTRAINED_SFIXED;
	
	
--=============================================================================
-- architecture begin
--=============================================================================	
	begin
		IN_UNSIGNED <= unsigned(X_VALUE);
		LOOKUP_TABLE_K <= -- Make sure no index will fall out of boundary
			to_unsigned(0, NUMBER_OF_BITS) when IN_UNSIGNED <= 0 
		else
			to_unsigned(VECTOR_SIZE, NUMBER_OF_BITS) when IN_UNSIGNED >= VECTOR_SIZE 
		else
			IN_UNSIGNED;
  
		LOOKUP_TABLE_OUT <= TAN_SIG(to_integer(LOOKUP_TABLE_K));
		
		
		
		LOOKUP_TABLE_OUT_CONSTRAINED<=
			resize(LOOKUP_TABLE_OUT,U_SIZE,L_SIZE);
		

		UNIT_DELAY_PROCESS : process (clk)
			
			begin
				if CLK'event and CLK = '1' then
				UNIT_DELAY_OUT <= LOOKUP_TABLE_OUT_CONSTRAINED;
				end if;
		
		end process UNIT_DELAY_PROCESS;


		Y_VALUE <= UNIT_DELAY_OUT;
end RTL;
--=============================================================================
-- architecture end
--=============================================================================
