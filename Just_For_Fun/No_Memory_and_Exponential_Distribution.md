# Definition

Definition of exponential distribution:
$$
\left \{ \begin{matrix}

f(x) = \lambda e^{-\lambda x}, x \ge 0 \\
F(x) = 1 - e^{-\lambda x}, x \ge 0

\end{matrix} \right.
$$

Definition of no memory:
$$
P(X>t|X>0) = P(X>t+s|X>s) \quad \forall s \ge 0, \forall t \ge 0
$$



# Exponential Distribution $ \Rightarrow  $ No Memory

For an exponential distribution:
$$
P(X>t) = 1 - F(t) = e^{- \lambda t}, \ \forall t \ge 0
$$
Then:
$$
L.H.S. = P(X>t|X>0) = P(X>t) = e^{- \lambda t} \\
R.H.S. = \frac{P(X>t+s \wedge X > s)}{P(X>s)} = \frac{P(X>t+s)}{P(X>s)} = \frac{e^{- \lambda (t+s)}}{e^{- \lambda s}} = e^{- \lambda t}
$$
So:
$$
L.H.S = R.H.S.
$$




# No Memory $ \Rightarrow  $ Exponential Distribution

Given
$$
P(X>t|X>0) = P(X>t+s|X>s) \quad \forall s \ge 0, \forall t \ge 0
$$

We denote $f(x)$ as its probability density function, then
$$
\int_t^{+\infty} f(x) \mathrm{d} x = \frac{\int_{t+s}^{+\infty} f(x) \mathrm{d} x }{\int_s^{+\infty} f(x) \mathrm{d} x }
$$

Fix s and do derivative for t
$$
f(t) = \frac{1}{{\int_s^{+\infty} f(x) \mathrm{d} x }} f(t+s)
$$

Define $G(x) := \int_x^{+\infty} f(x') \mathrm{d} x'$
$$
G^{\prime}(t+s) + f(t)G(s) = 0
$$
Let $t = 0$
$$
G^{\prime}(s) + f(0)G(s) = 0
$$
Then

$$
G(s) = G(0)e^{-f(0)s}
$$
By definition, $G(0) =  \int_0^{+\infty} f(x') \mathrm{d} x' = 1$

So
$$
G(s) = e^{-f(0)s}
$$
Finally we get
$$
f(s) = - G^{\prime}(s) = f(0) e^{-f(0)s}
$$
If we denote $f(0)$ as $\lambda$, then
$$
f(s) = \lambda e^{-\lambda s}
$$
Yeah, We've done it!



# THINK

* What is the geometry meaning of no memory?
* Do you understand why Poisson Process is the intersection of Counting Process and Markov Process now?
