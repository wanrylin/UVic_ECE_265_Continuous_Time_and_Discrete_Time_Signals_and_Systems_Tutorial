# ECE265 Tutorial 10

## Assignment 6A: Laplace and Z Transforms

Ruilin Wang

Use this recap to choose a method before you start computing. ULT means **unilateral Laplace transform** (continuous time); UZT means **unilateral Z transform** (discrete time). ROC means **region of convergence**. Page references are printed page numbers in the beta.3 slides and textbook.

### Practice map

| Assigned regular problem | Tutorial example | What to practise |
| --- | --- | --- |
| 7.29(a) | **Adapted 7.29(a)** (p. 339): change the step delay from 3 to 2 | Use the first active time as the lower limit of the ULT integral. Find the ROC from the tail of the integrand. |
| 7.30(c) | **Adapted 7.30(c)** (p. 340): move the ramp start from 2 to 3 in both factors | Identify the undelayed ramp, then use time delay and running integration. |
| 7.30(f) | **Example 7.44** (p. 328) | Match a time-weighted exponential to a transform pair. The example also uses delay; the recap covers the scaled step in the assignment. |
| 7.32(a) | **7.32(b)** (p. 340) | Split a piecewise function into step-windowed pieces. The example has an infinite tail; check the finite-duration case separately. |
| 12.16(b) | **Adapted 12.103(b)** (p. 647): use the definition instead of tables | Find the first active sample, reindex the geometric sum and state its ROC. |
| 12.17(b) | **12.17(a)** (p. 646) | Transform each causal factor of a convolution separately, then multiply. |
| 12.17(e) | **Adapted 12.16(a)** (p. 646): use table pairs and properties instead of the definition | Apply Z-domain differentiation twice. The recap also explains exponential weighting, which is not in the example. |
| 7.31(b) | **7.11(b)** (p. 337) | Use partial fractions with a simple pole and a double pole, then invert each term. |
| 12.18(d) | **12.104(g)** (p. 648) | Expand the transform divided by $z$, multiply back by $z$, then match exponential and impulse terms. |

## Problem-solving recap

### 1. Start from the definition: locate the first active time or sample

$$
X(s)=\int_{0^{-}}^{\infty} x(t)e^{-st}\thinspace dt,
\qquad
X(z)=\sum_{n=0}^{\infty} x(n)z^{-n}.
$$

The ULT integral includes any impulse at the origin, which is why the lower limit is $0^{-}$. The UZT includes the sample at $n=0$. Neither transform tells you what the signal did at negative times. Inverse problems here ask for the causal representative: zero before the origin.

- **CT:** If a step turns a regular function on at $T\gt0$, start the integral at $T$. Combine the exponential factors before integrating. If the integrand's tail is proportional to $e^{-(s+a)t}$ for real $a$, it decays at infinity when $\mathrm{Re}(s)\gt-a$.
- **DT:** If a step first turns a sequence on at sample $N$, start the sum at $N$. Set $k=n-N$ to make the new lower limit zero, and substitute $n=k+N$ in **every** factor, including $z^{-n}$. Then use $\sum_{k=0}^{\infty}q^k=1/(1-q)$ for $\lvert q\rvert\lt1$. When the ratio is $q=a/z$, the condition is $\lvert z\rvert\gt\lvert a\rvert$.

**Check:** The transform expression and its ROC are different pieces of information. Get the convergence condition from the integral or sum, not from where the simplified expression happens to be defined.

**References:** slides pp. 299, 304, 306–311; textbook §§7.17 and 12.16, Examples 7.42 and 12.41.

### 2. CT tables: delay, integration and multiplication by time

For a causal function $g(t)$ with ULT $G(s)$:

| Time-domain operation | ULT |
| --- | --- |
| Delay by $T\ge0$: $g(t-T)$ | $e^{-sT}G(s)$ |
| Running integral: $\int_{0^{-}}^{t}g(\tau)\thinspace d\tau$ | $G(s)/s$ |
| Multiply by time: $tg(t)$ | $-dG(s)/ds$ |

Start from the inside operation. For a running integral of a delayed signal, match the undelayed signal to a pair, apply the delay, then divide by $s$. For a time-weighted exponential, use the exponential pair and differentiate its transform, or use the corresponding pair directly. Useful starting pairs are $u(t)\longleftrightarrow 1/s$ for $\mathrm{Re}(s)\gt0$ and $e^{-at}u(t)\longleftrightarrow 1/(s+a)$ for $\mathrm{Re}(s)\gt-a$ when $a$ is real.

**Checks:** A delay changes the whole argument, not just the step. The factor $1/s$ from integration can introduce a pole at zero; check whether it remains after simplification. For a positive $c$, $u(ct)=u(t)$: changing the argument of the **step alone** does not give a transform scaling factor for the whole signal.

**References:** slides pp. 313–314, 320, 328, 330, 336, 339; textbook §7.17, Tables 7.4–7.5 and Example 7.44.

### 3. CT piecewise signals: turn each piece on and off

For a piece $f(t)$ active on $a\le t\lt b$, write $f(t)\bigl[u(t-a)-u(t-b)\bigr]$. For a tail starting at $b$ with no turn-off point, use just the turn-on step. Add the pieces, then use linearity and the table.

**Check:** Before using the delay formula on a term $f(t)u(t-a)$, write the underlying shape in the local time $\theta=t-a$. The formula needs the shape as well as the step expressed relative to the same start time. If the original signal is integrable and has finite duration, its ULT has the entire complex plane as its ROC. Apparent poles introduced by separate window terms are removable in the combined expression.

**References:** slides pp. 309, 313–314, 317, 320, 339; textbook §§7.7 and 7.17.

### 4. DT tables: delay, convolution and repeated differentiation

Useful pairs are $u(n)\longleftrightarrow z/(z-1)$ for $\lvert z\rvert\gt1$ and $a^nu(n)\longleftrightarrow z/(z-a)$ for $\lvert z\rvert\gt\lvert a\rvert$ when $a\ne0$.

- **Causal delay:** If $g(n)$ is causal and $N$ is a nonnegative integer, $g(n-N)$ transforms to $z^{-N}G(z)$. For the step and exponential pairs used here, the exterior ROC bound is unchanged.
- **Causal convolution:** If both sequences are causal, their convolution transforms to $X_1(z)X_2(z)$. Use the common part of the two ROCs as a starting point, and simplify before deciding the final ROC. A canceled pole does not set the final boundary.
- **Multiply by $n$ or $n^2$:** Apply the operator $D_z$ below once for $n$ and twice for $n^2$.

$$
D_zG(z)=-z\frac{dG(z)}{dz}, \qquad D_z^2G(z)=D_z\bigl(D_zG(z)\bigr).
$$

- **Exponential weighting:** If $a\gt0$, multiplying $g(n)$ by $a^n$ changes $G(z)$ to $G(z/a)$ and scales the ROC by $a$.

**Check:** On the second pass, differentiate the whole first result, including its leading $-z$. The product rule matters: $D_z^2G$ is not just $z^2G''$.

**References:** slides pp. 311, 315–316, 321, 326, 329, 337; textbook §12.16, Tables 12.4–12.5.

### 5. Inverse transforms: make the fractions match the table

**CT — inverse ULT.** Factor the denominator and use partial fraction expansion. A double pole contributes terms with both $(s-p)$ and $(s-p)^2$ in the denominator. To find the coefficients, clear denominators and match coefficients of like powers. If the numerator and denominator have the same degree, divide first; any constant quotient gives an impulse.

$$
\frac{1}{(s-p)^k}\longleftrightarrow \frac{t^{k-1}}{(k-1)!}e^{pt}u(t),\qquad 1\longleftrightarrow\delta(t),\qquad k=1,2,\ldots
$$

**DT — inverse UZT.** For a proper rational $X(z)$, expand $X(z)/z$ into partial fractions. Multiply the **entire expansion** by $z$ before matching terms. A term $A/(z-p)$ becomes $Az/(z-p)$; a term $C/z$ becomes the constant $C$.

$$
\frac{z}{z-p}\longleftrightarrow p^n u(n)\quad(p\ne0),\qquad 1\longleftrightarrow\delta(n).
$$

**Checks:** Don't omit the first-power term at a repeated CT pole. In DT, don't invert $X(z)/z$ by mistake or read a constant as a step. Once multiplied back by $z$, a constant gives a sample only at $n=0$.

**References:** slides pp. 341–342 and 385–390; textbook §§7.10, 7.17, 12.10, 12.16 and Appendix B.

### MATLAB bridge: choose the forward or inverse symbolic command

| Assignment problem | Direction | Symbolic command |
| --- | --- | --- |
| 7.203(b), p. 349 | CT: time $t$ to transform variable $s$ | `laplace` |
| 7.204(b), p. 349 | CT: transform variable $s$ back to time $t$ | `ilaplace` |
| 12.201(b), p. 649 | DT: sample index $n$ to transform variable $z$ | `ztrans` |
| 12.202(b), p. 649 | DT: transform variable $z$ back to sample index $n$ | `iztrans` |

Specify the input and output variables explicitly. Use symbolic numbers when exact fractions matter. For the two **forward** problems, the textbook also asks for `simplify` with `Steps` set to 50. A symbolic expression does not replace a convergence argument when a problem asks for the ROC.

**References:** slides pp. 546–549; textbook §§7.19.3 and 12.18.3.

## 7.29(a) (Adapted): Problem

Using the definition of the unilateral Laplace transform, find $X(s)$ and its ROC for

$$
x(t)=e^{-at}u(t-2),\qquad a\gt0 \text{ real}.
$$

**Source:** textbook 7.29(a), p. 339. The step delay is changed from 3 to 2; the exponential is unchanged.

### Knowledge points

ULT definition and right-half-plane ROC: slides pp. 299, 307–309; textbook §7.17.

### Core bridge formula

$$
X(s)=\int_{0^{-}}^{\infty}x(t)e^{-st}\thinspace dt.
$$

If an ordinary function is zero up to a positive time $T$, the integral starts at $T$.

### Answer

The step $u(t-2)$ turns on at $t=2$. Only the lower limit moves; the exponent in $e^{-at}$ is still $-at$. Combining the two exponentials gives

$$
X(s)=\int_2^\infty e^{-at}e^{-st}\thinspace dt
=\int_2^\infty e^{-(s+a)t}\thinspace dt.
$$

For a finite upper limit $M\gt2$ and $s+a\ne0$, the integral is

$$
\frac{-e^{-(s+a)M}}{s+a}-\frac{-e^{-2(s+a)}}{s+a}
=\frac{e^{-2(s+a)}-e^{-(s+a)M}}{s+a}.
$$

As $M\to\infty$, the second exponential tends to zero exactly when $\mathrm{Re}(s+a)\gt0$. On the boundary the integral either grows ($s+a=0$) or oscillates without a limit; outside it, the exponential grows.

$$
\boxed{X(s)=\frac{e^{-2(s+a)}}{s+a},\qquad \mathrm{Re}(s)\gt-a.}
$$

## 7.30: Problem

Use unilateral Laplace transform properties and table pairs to find the transform and ROC of each function.

**A. Adapted 7.30(c)** (textbook p. 340): the ramp starts at 3 instead of 2 in both factors.

$$
x(t)=\int_{0^{-}}^{t}(\tau-3)u(\tau-3)\thinspace d\tau.
$$

**B. Textbook Example 7.44** (p. 328, practice for 7.30(f)):

$$
x(t)=(t-2)e^{t-2}u(t-2).
$$

### Knowledge points

ULT pairs, delay, Laplace-domain differentiation, and time-domain integration: slides pp. 313–314, 320, 328, 336; textbook §7.17, Tables 7.4–7.5.

### Core bridge formula

If $g(t)$ is causal and has ULT $G(s)$, then

$$
g(t-T)\longleftrightarrow e^{-sT}G(s)\quad(T\ge0),\qquad
\int_{0^{-}}^{t}g(\tau)\thinspace d\tau\longleftrightarrow \frac{G(s)}{s},\qquad
tg(t)\longleftrightarrow -\frac{dG(s)}{ds}.
$$

### Answer

#### A. Delayed ramp followed by integration

Start with $r(t)=tu(t)$, which has ULT $R(s)=1/s^2$ for $\mathrm{Re}(s)\gt0$. The function inside the integral is $r(\tau-3)$: both the ramp argument and its step are shifted by 3. Its transform is

$$
e^{-3s}R(s)=\frac{e^{-3s}}{s^2}.
$$

Now apply the running integral. It divides the transform of the integrand by $s$:

$$
X(s)=\frac{1}{s}\frac{e^{-3s}}{s^2}=\frac{e^{-3s}}{s^3}.
$$

The numerator is 1 at $s=0$, so the pole there does not cancel. In time, $x(t)$ is zero before $t=3$ and grows as $(t-3)^2/2$ after that. The ULT integral converges only when $e^{-st}$ decays, that is, when $\mathrm{Re}(s)\gt0$.

$$
\boxed{X(s)=\frac{e^{-3s}}{s^3},\qquad \mathrm{Re}(s)\gt0.}
$$

#### B. Time-weighted exponential followed by delay

Write $g(t)=e^tu(t)$ and $v(t)=tg(t)$. Then $v(t-2)=(t-2)e^{t-2}u(t-2)$, which is $x(t)$. Start with the exponential pair and multiply by $t$ using Laplace-domain differentiation:

$$
G(s)=\frac{1}{s-1},\qquad
V(s)=-\frac{d}{ds}(s-1)^{-1}=-\bigl[-(s-1)^{-2}\bigr]=\frac{1}{(s-1)^2}.
$$

Apply the 2-unit delay **after** differentiating. The delay factor does not change the ROC of the growing exponential tail.

$$
\boxed{X(s)=e^{-2s}V(s)=\frac{e^{-2s}}{(s-1)^2},\qquad \mathrm{Re}(s)\gt1.}
$$

## 7.32(b): Problem

Using tables of transform properties and pairs, find the ULT of the function below, including the general form of its ROC.

$$
x(t)=
\begin{cases}
t & 0\le t\lt1 \cr
1 & 1\le t\lt2 \cr
e^{-(t-2)} & t\ge2 \cr
0 & \text{otherwise}.
\end{cases}
$$

**Source:** textbook 7.32(b), p. 340. A solution that does not require differentiation is possible.

### Knowledge points

Step functions, ULT tables, and ROC of a finite-duration function: slides pp. 309, 313–314, 317, 320; textbook §§7.7 and 7.17.

### Core bridge formula

$$
g(t-T)\longleftrightarrow e^{-sT}G(s)\quad(g\text{ causal},\ T\ge0).
$$

Build the piecewise function by adding a causal term at each breakpoint. Each added term should change the current expression into the next piece.

### Answer

1. Start with $tu(t)$. It is zero before 0 and gives $t$ on the first interval.
2. At $t=1$, subtract $(t-1)u(t-1)$. For $t\ge1$, the first two terms now give $t-(t-1)=1$.
3. At $t=2$, subtract $u(t-2)$ to remove that constant and add $e^{-(t-2)}u(t-2)$ to start the exponential tail.

Putting the corrections together,

$$
x(t)=tu(t)-(t-1)u(t-1)-u(t-2)+e^{-(t-2)}u(t-2).
$$

The table entries are $tu(t)\longleftrightarrow 1/s^2$, $u(t)\longleftrightarrow 1/s$, and $e^{-t}u(t)\longleftrightarrow 1/(s+1)$. The second term is a ramp delayed by 1; the last two terms are delayed by 2. Applying the factors gives

$$
X(s)=\frac{1}{s^2}-\frac{e^{-s}}{s^2}-\frac{e^{-2s}}{s}+\frac{e^{-2s}}{s+1}.
$$

To get the exact ROC, look at the two parts of the signal. The first three terms in the time-domain decomposition together are zero after $t=2$, so their transform exists for every finite $s$. The apparent singularity at $s=0$ in their sum is removable. Only the exponential tail determines the boundary, and its ROC is $\mathrm{Re}(s)\gt-1$.

$$
\boxed{X(s)=\frac{1-e^{-s}}{s^2}-\frac{e^{-2s}}{s}+\frac{e^{-2s}}{s+1},
\qquad \mathrm{ROC}:\ \mathrm{Re}(s)\gt-1.}
$$

At $s=0$, use the continuous extension. Equivalently, the integral of the three pieces is $1/2+1+1=5/2$, so $X(0)=5/2$.

## 12.103(b) (Adapted): Problem

Using the **definition** of the unilateral Z transform, find $X(z)$ and its ROC for

$$
x(n)=\left(\frac25\right)^n u(n-2).
$$

**Source:** textbook 12.103(b), p. 647. The sequence is unchanged; the original asks for a table-based calculation. This version practises the method in Assignment 6A, 12.16(b).

### Knowledge points

UZT definition, geometric sum, and circle exterior ROC: slides pp. 304, 310–311; textbook §12.16 and Example 12.41.

### Core bridge formula

$$
X(z)=\sum_{n=0}^{\infty}x(n)z^{-n},\qquad
\sum_{k=0}^{\infty}q^k=\frac{1}{1-q}\quad(\lvert q\rvert\lt1).
$$

### Answer

The sequence is zero for $n\lt2$, so the sum starts at $n=2$. For nonzero $z$, let $q=(2/5)z^{-1}$. Then

$$
X(z)=\sum_{n=2}^{\infty}\left(\frac25\right)^n z^{-n}
=\sum_{n=2}^{\infty}q^n.
$$

Set $k=n-2$, so $n=k+2$ and $n=2$ becomes $k=0$. Pull the first power $q^2$ outside the sum:

$$
X(z)=\sum_{k=0}^{\infty}q^{k+2}=q^2\sum_{k=0}^{\infty}q^k=\frac{q^2}{1-q}.
$$

The geometric sum converges when $\lvert q\rvert=(2/5)/\lvert z\rvert\lt1$. Substitute $q=2/(5z)$ and simplify:

$$
X(z)=\frac{4/(25z^2)}{1-2/(5z)}
=\frac{4}{25z^2}\frac{z}{z-2/5}
=\frac{4}{25z(z-2/5)}.
$$

$$
\boxed{X(z)=\frac{4}{25z(z-2/5)},\qquad \lvert z\rvert\gt\frac25.}
$$

## 12.17: Problem

Use UZT properties and transform pairs to find $X(z)$ and the ROC for each sequence.

**A. Textbook 12.17(a)** (p. 646):

$$
x(n)=(x_1\ast x_2)(n),\qquad x_1(n)=u(n-2),\qquad x_2(n)=\left(\frac38\right)^n u(n).
$$

**B. Adapted 12.16(a)** (p. 646, practice for 12.17(e)): the sequence is unchanged; use transform tables and properties instead of the definition.

$$
x(n)=n^2u(n).
$$

### Knowledge points

UZT pairs, causal delay and convolution, and Z-domain differentiation: slides pp. 315–316, 321, 326, 329; textbook §12.16, Tables 12.4–12.5.

### Core bridge formula

For causal sequences,

$$
g(n-N)\longleftrightarrow z^{-N}G(z)\quad(N\ge0\text{ integer}),\qquad
(x_1\ast x_2)(n)\longleftrightarrow X_1(z)X_2(z),\qquad
ng(n)\longleftrightarrow -z\frac{dG(z)}{dz}.
$$

### Answer

#### A. Delayed step convolved with an exponential

Start from $u(n)\longleftrightarrow z/(z-1)$ for $\lvert z\rvert\gt1$. The 2-sample delay multiplies by $z^{-2}$. The exponential pair gives the transform of the second sequence directly:

$$
X_1(z)=z^{-2}\frac{z}{z-1},\qquad
X_2(z)=\frac{z}{z-3/8}.
$$

The second ROC is $\lvert z\rvert\gt3/8$, so the common part of the two ROCs is $\lvert z\rvert\gt1$. Both sequences are causal. Multiply their transforms:

$$
X(z)=z^{-2}\frac{z}{z-1}\frac{z}{z-3/8}
=\frac{1}{(z-1)(z-3/8)}.
$$

The two factors of $z$ cancel the delay factor $z^{-2}$, but neither of the poles at $1$ and $3/8$ cancels. The pole at $1$ therefore still sets the boundary.

$$
\boxed{X(z)=\frac{1}{(z-1)(z-3/8)},\qquad \lvert z\rvert\gt1.}
$$

#### B. Multiply by the sample index twice

Start from $G(z)=z/(z-1)$ for $g(n)=u(n)$. First transform $nu(n)$:

$$
X_1(z)=-z\frac{d}{dz}\left(\frac{z}{z-1}\right)
=-z\frac{(z-1)-z}{(z-1)^2}
=\frac{z}{(z-1)^2}.
$$

Now $n^2u(n)=n[nu(n)]$. Differentiate the **entire** first result. Use the product rule on $z(z-1)^{-2}$:

$$
X(z)=-z\frac{d}{dz}\left[z(z-1)^{-2}\right]
=-z\left[(z-1)^{-2}-2z(z-1)^{-3}\right].
$$

With a common denominator, the bracket is $\bigl[(z-1)-2z\bigr]/(z-1)^3=(-z-1)/(z-1)^3$. Multiplying by $-z$ gives

$$
\boxed{X(z)=\frac{z(z+1)}{(z-1)^3},\qquad \lvert z\rvert\gt1.}
$$

The numerator is 2 at $z=1$, so the pole remains. The causal sequence therefore has the exterior ROC shown above.

## 7.11(b): Problem

Find the causal inverse Laplace transform $x$ of

$$
X(s)=\frac{-3s^2-6s-2}{(s+1)^2(s+2)}.
$$

**Source:** textbook 7.11(b), p. 337. Since the inverse sought is causal, this is also a practice problem for inverse ULT.

### Knowledge points

Inverse ULT and repeated-pole partial fractions: slides pp. 341, 388–390; textbook §§7.10, 7.17 and Appendix B.

### Core bridge formula

For a pole at $p$ of order two, include both $(s-p)^{-1}$ and $(s-p)^{-2}$ in the expansion template. The corresponding time-domain terms are

$$
\frac{1}{s-p}\longleftrightarrow e^{pt}u(t),\qquad
\frac{1}{(s-p)^2}\longleftrightarrow te^{pt}u(t).
$$

### Answer

The pole at $-1$ is double and the pole at $-2$ is simple. The numerator degree is smaller than the denominator degree, so no polynomial division is needed. Write

$$
X(s)=\frac{A}{s+1}+\frac{B}{(s+1)^2}+\frac{C}{s+2}.
$$

After multiplying by $(s+1)^2(s+2)$, the numerator identity is

$$
-3s^2-6s-2=A(s+1)(s+2)+B(s+2)+C(s+1)^2.
$$

- At $s=-1$, the $A$ and $C$ terms vanish, giving $-3+6-2=B(1)$, so $B=1$.
- At $s=-2$, the $A$ and $B$ terms vanish, giving $-12+12-2=C(-1)^2$, so $C=-2$.
- The coefficient of $s^2$ is $-3$ on the left and $A+C$ on the right. Thus $A=-3-(-2)=-1$.

Now invert the three terms:

$$
\frac{-1}{s+1}\longleftrightarrow -e^{-t}u(t),\qquad
\frac{1}{(s+1)^2}\longleftrightarrow te^{-t}u(t),\qquad
\frac{-2}{s+2}\longleftrightarrow -2e^{-2t}u(t).
$$

$$
\boxed{x(t)=\bigl[(t-1)e^{-t}-2e^{-2t}\bigr]u(t).}
$$

The rightmost pole is $-1$, so the causal transform has ROC $\mathrm{Re}(s)\gt-1$.

## 12.104(g): Problem

Find the inverse unilateral Z transform $x$ of

$$
X(z)=\frac{2(z-1/2)(z+1/2)}{(z-1/4)(z+1/4)}.
$$

**Source:** textbook 12.104(g), p. 648.

### Knowledge points

Inverse UZT, simple-pole partial fractions, and the origin sample: slides pp. 315, 342, 388–389; textbook §12.16, Example 12.42 and Appendix B.

### Core bridge formula

For a proper rational $X(z)$, expand $X(z)/z$, then multiply every term by $z$ before using

$$
\frac{z}{z-p}\longleftrightarrow p^n u(n)\quad(p\ne0),\qquad
1\longleftrightarrow\delta(n).
$$

### Answer

The numerator and denominator of $X(z)$ have the same degree. Dividing by $z$ gives a strictly proper expression. Factor by difference of squares in the numerator and write

$$
\frac{X(z)}{z}
=\frac{2(z^2-1/4)}{z(z-1/4)(z+1/4)}
=\frac{C}{z}+\frac{A}{z-1/4}+\frac{B}{z+1/4}.
$$

Clear the denominator to obtain

$$
2(z^2-1/4)=C(z-1/4)(z+1/4)+Az(z+1/4)+Bz(z-1/4).
$$

- At $z=0$, $2(-1/4)=C(-1/4)(1/4)=-C/16$, so $C=8$.
- At $z=1/4$, $2(1/16-1/4)=-3/8=A(1/4)(1/2)=A/8$, so $A=-3$.
- At $z=-1/4$, $2(1/16-1/4)=-3/8=B(-1/4)(-1/2)=B/8$, so $B=-3$.

Multiply back by $z$. The term $8/z$ becomes the constant $8$, not a delayed exponential:

$$
X(z)=8-3\frac{z}{z-1/4}-3\frac{z}{z+1/4}.
$$

Now the constant gives $8\delta(n)$, and the two fractions give exponentials with bases $1/4$ and $-1/4$.

$$
\boxed{x(n)=8\delta(n)-3\left[\left(\frac14\right)^n+\left(-\frac14\right)^n\right]u(n).}
$$

It is zero for $n\lt0$, and $x(0)=8-3-3=2$. This agrees with $\lim_{z\to\infty}X(z)=2$. The causal ROC is $\lvert z\rvert\gt1/4$.

## MATLAB: Assignment 6A Problems

### 7.203(b): Forward unilateral Laplace transform (textbook p. 349)

Using MATLAB, compute the unilateral Laplace transform of

$$
x(t)=(1-e^{-t})\frac{1}{t}u(t).
$$

The textbook suggests `laplace` and requires `simplify` with the number of simplification steps set to 50.

**Idea:** The unilateral integral uses the positive-time expression. The apparent $1/t$ singularity is removable: the numerator also vanishes at $t=0$. The value assigned at this one point does not affect the transform of this ordinary function.

**Classroom fill-in (Symbolic Math Toolbox):** Copy the block into a MATLAB script and fill both TODO lines before running it.

~~~matlab
% Prepare the time variable, the transform variable, and the input for t > 0.
syms t s
x_ct = (1 - exp(-t)) / t;

% TODO 1: Transform x_ct from t to s and save the result as X_ct_raw.

% TODO 2: Simplify X_ct_raw with Steps set to 50 and save it as X_ct.

% Display the simplified unilateral Laplace transform.
disp(X_ct);
~~~

### 7.204(b): Inverse unilateral Laplace transform (textbook p. 349)

Using MATLAB, compute the inverse unilateral Laplace transform of

$$
X(s)=\frac{e^{-\sqrt{s}}}{\sqrt{s}}.
$$

The textbook suggests `ilaplace`.

**Idea:** This is not a rational transform, so a partial fraction expansion is not the tool here. Build the expression in $s$ first; the output is a function of $t$.

**Classroom fill-in (Symbolic Math Toolbox):** Copy the block into a MATLAB script and fill the TODO line before running it.

~~~matlab
% Prepare the transform variable and the output time variable.
syms s t

% Build the transform given in the original problem.
X_ct_inv = exp(-sqrt(s)) / sqrt(s);

% TODO: Invert X_ct_inv from s to t and save the result as x_ct_inv.

% Display the inverse unilateral Laplace transform.
disp(x_ct_inv);
~~~

### 12.201(b): Forward unilateral Z transform (textbook p. 649)

Using MATLAB, compute the unilateral Z transform of

$$
x(n)=\frac{n}{n+1}\left(\frac12\right)^n u(n).
$$

The textbook suggests `ztrans` and requires `simplify` with the number of simplification steps set to 50.

**Idea:** The unilateral sum already starts at $n=0$. Use the stated expression on those indices, where $u(n)=1$, and keep $1/2$ as an exact symbolic fraction.

**Classroom fill-in (Symbolic Math Toolbox):** Copy the block into a MATLAB script and fill both TODO lines before running it.

~~~matlab
% Prepare the sample index and the transform variable.
syms n z

% Build the input for n >= 0 using the exact fraction 1/2.
x_dt = (n / (n + 1)) * (sym(1) / 2)^n;

% TODO 1: Transform x_dt from n to z and save the result as X_dt_raw.

% TODO 2: Simplify X_dt_raw with Steps set to 50 and save it as X_dt.

% Display the simplified unilateral Z transform.
disp(X_dt);
~~~

### 12.202(b): Inverse unilateral Z transform (textbook p. 649)

Using MATLAB, compute the inverse unilateral Z transform of

$$
X(z)=\frac{(z+1/11)(z+1)}{(z+1/42)(z-1)}.
$$

The textbook suggests `iztrans`.

**Idea:** Build the rational function with exact fractions and invert from $z$ to $n$. If the output contains an impulse, keep it as an impulse: it contributes at exactly one index. The total first sample, including contributions from the other terms, should agree with the limit of $X(z)$ as $z$ goes to infinity.

**Classroom fill-in (Symbolic Math Toolbox):** Copy the block into a MATLAB script and fill the TODO line before running it.

~~~matlab
% Prepare the transform variable and the output sample index.
syms z n

% Build the transform using exact symbolic fractions.
numerator = (z + sym(1) / 11) * (z + 1);
denominator = (z + sym(1) / 42) * (z - 1);
X_dt_inv = numerator / denominator;

% TODO: Invert X_dt_inv from z to n and save the result as x_dt_inv.

% Display the inverse unilateral Z transform.
disp(x_dt_inv);
~~~

**References:** slides pp. 546–549; textbook §§7.19.3 and 12.18.3.
