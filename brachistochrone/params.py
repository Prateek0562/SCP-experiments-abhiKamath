import numpy as np
import scipy.linalg as la

G = -9.81                             # gravitational acceleration [m/s^2]
g = np.array([0, G])

# Initial conditions
r0 = np.array([0.0, 0.0])             # initial position (x, y) [m]
v0 = np.array([0.0, 0.0])             # initial velocity (x, y) [m/s]

# Target conditions
rf = np.array([6.0, -2.0])            # final position [m]

# Standard bases (column vectors)
e1 = np.c_[np.array([1, 0])]
e2 = np.c_[np.array([0, 1])]

# Number of temporal nodes
N = 50

# SCP parameters
max_iters = 25 # maximum SCP iterations
w_tf = 1e0 # final-time weight
w_vb = 1e1 # virtual buffer weight
w_tr = 1e0 # trust region weight

###############
### Scaling ###
###############

# Linear scaling

# u
u_guess = la.norm(g)
au = np.diag([u_guess, u_guess])

# r
r_guess = la.norm(rf)
ar = np.diag([r_guess, r_guess])

# v
v_guess = np.sqrt(la.norm(v0)**2 + 2*u_guess*r_guess)
av = np.diag([v_guess, v_guess])

# tf
tf_guess = v_guess/u_guess
atf = tf_guess