14/07/17
Zhao's normalised dynamics is discretised pseudospectrally to yield the
non-linear algebraic constraints.

The code seems to be performing better than its non-spectral 
Hermite-Simpson counterpart.

Need to investigate more.

LOITER
The code started to converge better ("convergence-run" observable) when the lower-bound on tfbar was invreased to 1.

TRAVELLING
Not a single converged trajectory was obtained. Prematurely stopping the optimization showed that trajectory looked "sensible" 