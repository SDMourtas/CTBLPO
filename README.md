# Continuous-Time Black-Litterman Portfolio Optimization
The Black-Litterman model is a very important analytical tool for active portfolio management because it allows investment analysts to incorporate investor's views into market equilibrium returns. The Continuous-Time Black-Litterman Portfolio Optimization (CTBLPO) problem is a continuous time-varying quadratic programming (TVQP) problem.
The purpose of this package is to solve online the CTBLPO problem by using two continuous-time neural network (NN) solvers. These solvers are the zeroing NN (ZNN) and the linear-variational-inequality primal-dual NN (LVI-PDNN).
The main article used is the following:
*	S.D.Mourtas, V.N.Katsikis, "Continuous-Time Black-Litterman Portfolio Optimization: A Neural Network Approach", (submitted)

# M-files Description
*	Main_CTBLPO.m: the main function and parameters declaration
*	CTBLPO.m: problem setup and main procedure
*	dataprep.m: Black-Litterman expected return and covariance construction
*	EER.m: function for calculating the equilibrium excess returns
*	problem.m: complementary function for the problem setup
*	problem2.m: complementary function for the problem setup
*	inputs.m: complementary function for the problem setup
*	inputs2.m: complementary function for the problem setup
*	linotsm.m: function for vectors' linear interpolation
*	linotssm.m: function for matrices' linear interpolation
*	ZNN.m: the ZNN solver
*	LVIPDNN.m: the LVI-PDNN solver
*	Poweromega.m: the projection operator of the LVI-PDNN solver

# Installation
*	Unzip the file you just downloaded and copy the CTBLPO directory to a location,e.g.,/my-directory/
*	Run Matlab/Octave, Go to /my-directory/CTBLPO/ at the command prompt
*	run 'Main_CTBLPO' (Matlab/Octave)

# Results
After running the Main_TVBLPONC.m file, the package outputs are the following:
*	The optimal portfolio of TV-BLPONC problem created by BAS, ABC, DE and SMA.
*	The time consumptions of BAS, ABC, DE and SMA.
*	The graphic illustration of the average price of the objected function along with the optimal portfolios expected return, variance and transaction cost.

# Environment
The CTBLPO package has been tested in Matlab 2021a on OS: Windows 10 64-bit.
