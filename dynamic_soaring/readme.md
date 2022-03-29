# 3-DoF Aircraft Dynamic Soaring using Chebyshev Pseudospectral Method.

 - Refer to [Zhao 2004](https://doi.org/10.1002/oca.739) (included in `resources`) for the problem formulation. 
 - Demonstrates usage of the CGL differentation matrix (computed in `cheb.m`) and the CGL interpolant (assembled in `cheb_interp.m`).
 - Run `main.m` to compute trajectory.
 - The differentiation matrix is used in `Cfun.m` to discretize the normalized continuous-time 3-DoF aircraft dynamics.
 - The interpolant is used in `view_result.m` to interpolat the solution generated in `main.m` to a finer grid for plotting.

![](/media/sample_traj.png)
