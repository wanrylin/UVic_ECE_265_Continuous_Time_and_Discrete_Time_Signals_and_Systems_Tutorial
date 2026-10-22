# ECE265 Lecture Key Knowledge Summary 6

**Coverage:** This summary continues after [Lecture Key Knowledge Summary 5](tutorial5lecture_summary.md). It covers the unified lecture slides from **printed p. 162, "Fourier Series and Frequency Spectra," through printed p. 175, "CT/DT Frequency Response: Summary."** The corresponding PDF-viewer pages are **181-194**. This includes slides §4.4, **"Fourier Series and LTI Systems" (pp. 172-175)**. Printed p. 176 starts the next unit, **"CT and DT Fourier Transforms"**; that page, p. 177 **"Motivation for the CT and DT Fourier Transforms,"** and everything after them are excluded. Both slides and textbook are Edition **7.0.0-beta.3**.

This is a supplementary study guide. All references below use **printed** slide and textbook pages.

**Notation:** Fourier-series coefficients are $a_k$, following the slides; the textbook often writes $c_k$ for the same coefficients. We use $\omega$ for angular frequency in both CT and DT, as in the slides; the textbook usually uses $\Omega$ in DT. CT angular frequency is in radians per second, and DT angular frequency is in radians per sample. $\mathcal{H}$ denotes an LTI system, $h$ its impulse response, and $H(\omega)$ its frequency response.

## 1. From a time-domain signal to its frequency content (slides §4.3, pp. 163-166)

The time-domain view describes how $x(t)$ or $x(n)$ changes with time. The Fourier-series view describes **which harmonically related complex sinusoids make up the signal, and how strongly each contributes**.

Writing a coefficient in polar form gives

$$
a_k=\lvert a_k\rvert e^{j\arg(a_k)},
$$

so its term in the Fourier series becomes

$$
a_ke^{jk\omega_0\xi}
=\lvert a_k\rvert e^{j[k\omega_0\xi+\arg(a_k)]}.
$$

Here $\xi=t$ for CT and $\xi=n$ for DT. The fundamental angular frequency is $\omega_0=2\pi/T$ in CT and $\omega_0=2\pi/N$ in DT.

- $k\omega_0$ identifies the component's angular frequency. In DT, frequencies differing by $2\pi$ represent the same complex sinusoid.
- $\lvert a_k\rvert$ is the amplitude of this **complex-exponential term**.
- $\arg(a_k)$ is its phase offset and affects how the components combine in time.

The example on slides pp. 164-165 compares approximations that retain different Fourier-series terms. Keeping the largest-magnitude coefficients captures the main features much better than keeping the smallest-magnitude nonzero coefficients. Here the four largest are at $k=\pm1,\pm3$, which happen to be the lowest nonzero frequencies present. In general, the strongest terms are **not necessarily the lowest-frequency terms**; inspect their magnitudes.

**Textbook:** §5.6, pp. 145, 147-148; §10.7, p. 463. Textbook Example 5.8 illustrates the same approximation principle, but its numerical coefficients differ from the slide example.

### Supplement: a real cosine's amplitude versus its coefficient magnitudes

For real $x$, two distinct conjugate-pair terms combine as

$$
a_ke^{jk\omega_0\xi}+a_{-k}e^{-jk\omega_0\xi}
=2\lvert a_k\rvert\cos(k\omega_0\xi+\arg(a_k)).
$$

Use $k>0$ in CT; in DT, use $k=1,\ldots,\lfloor(N-1)/2\rfloor$ so the two terms are distinct. Thus a real cosine of amplitude $A>0$ at such a frequency gives **two magnitude-spectrum stems of height $A/2$**, not $A$. DC and, for even $N$, the DT component at $\omega=\pi$ are each represented once; do not split them into two independent stems.

**Textbook:** §5.5.10, p. 144; §10.5.11, p. 458.

## 2. Frequency, magnitude and phase spectra (slides §4.3, pp. 166-167)

| Quantity | Meaning | What is plotted vertically |
| --- | --- | --- |
| Frequency spectrum | The complex Fourier-series coefficients | $a_k$ when all coefficients are real; the imaginary part when all are purely imaginary; otherwise use the two plots below |
| Magnitude spectrum | The size of each coefficient | $\lvert a_k\rvert$ |
| Phase spectrum | The phase of each coefficient | $\arg(a_k)$ |

The horizontal coordinate is normally **angular frequency $\omega=k\omega_0$**, not just coefficient index $k$. If plotting purely imaginary coefficients directly, label the vertical axis as their imaginary part.

Fourier series have components only at these discrete harmonic frequencies. Their spectra are therefore **line spectra**, usually drawn as stem plots, even when the original signal is continuous-time. Do not join the stems into a continuous curve.

### A short plotting checklist

1. Determine the signal's period and $\omega_0$.
2. Find $a_k$, or read the coefficients from an existing Fourier-series expression. Keep the $k=0$ (DC) component if it is nonzero.
3. For each coefficient, mark the horizontal location $k\omega_0$ and compute $\lvert a_k\rvert$ and $\arg(a_k)$.
4. Draw separate magnitude and phase stem plots when the coefficients are generally complex. In DT, choose one baseband interval as described below.

### Supplement: phase at a zero coefficient

If $a_k=0$, there is no component at that frequency, so its phase carries no information. The textbook uses the plotting convention $\arg(0)=0$ in Example 5.9 (p. 149). A zero phase marker there is a convention, not evidence of a nonzero component.

**Textbook:** §5.6, pp. 147-150; §10.7, pp. 464-466.

## 3. CT versus DT spectra and baseband (slides §4.3, pp. 168-169)

| Feature | CT Fourier series | DT Fourier series |
| --- | --- | --- |
| Original signal | $T$-periodic function | $N$-periodic sequence |
| Harmonic spacing | $\omega_0=2\pi/T$ | $\omega_0=2\pi/N$ |
| Coefficient indices | All integers; generally not periodic | All integers; $a_{k+N}=a_k$ |
| Spectrum periodicity in frequency | Generally not periodic | $2\pi$-periodic |
| Number of distinct basis signals | Infinitely many | $N$ |
| Usual plotted frequency range | The harmonics of interest | One period, usually baseband |

For integer $n$,

$$
e^{j(\omega+2\pi)n}=e^{j\omega n}e^{j2\pi n}=e^{j\omega n}.
$$

Thus adding $2\pi$ to a DT frequency does not produce a new basis sequence. Equivalently, increasing $k$ by $N$ returns to the same DTFS coefficient and basis sequence.

The **baseband** is one frequency interval of length $2\pi$ centered at zero, normally

$$
\boxed{\lbrack-\pi,\pi)\quad\text{or}\quad(-\pi,\pi\rbrack.}
$$

Choose the $N$ consecutive coefficient indices whose frequencies lie in the chosen interval. A frequency outside it can be moved into it by adding or subtracting an integer multiple of $2\pi$; the coefficient value is unchanged.

**Endpoint check:** $-\pi$ and $\pi$ describe the same DT frequency. For a single period, include only one of them. If a plot shows both endpoints to illustrate repetition, they are not two independent components. In CT, different integer values of $k$ identify distinct basis functions; there is no corresponding $2\pi$ frequency repetition in general.

**Textbook:** §10.2, p. 439 (repeated DT basis sequences); §10.3, p. 441 (periodic coefficient sequence); §10.7, pp. 464-466 (spectral plots). The CT/DT comparison and baseband convention are stated explicitly on slides pp. 168-169.

## 4. Spectral symmetry of a real-valued signal (slides §4.3, p. 170)

For a real-valued CT function or DT sequence, the Fourier-series coefficients are **conjugate symmetric**:

$$
\boxed{a_{-k}=(a_k)^{\ast}.}
$$

Consequently, the magnitude spectrum is even:

$$
\boxed{\lvert a_{-k}\rvert=\lvert a_k\rvert.}
$$

The phase spectrum has the corresponding odd symmetry, with phases interpreted modulo $2\pi$ at nonzero coefficients:

$$
\arg(a_{-k})\equiv-\arg(a_k)\pmod{2\pi}.
$$

Knowing the nonnegative-frequency coefficients therefore determines the negative-frequency coefficients, so real-signal spectra are often displayed using only the nonnegative frequencies. This does **not** mean that the negative-frequency terms can simply be deleted from the two-sided Fourier-series synthesis equation. For a signal that is not real valued, do not assume this conjugate symmetry.

### Supplement: reading a phase plot

Angles differing by $2\pi$ describe the same complex number. For example, $\pi$ and $-\pi$ are equivalent. A principal-phase plot may therefore not look literally odd at a negative-real coefficient, even though the coefficients satisfy conjugate symmetry. Check $a_{-k}=(a_k)^{\ast}$ when the phase display is ambiguous. At zero coefficients, use the plotting convention from §2.

**Textbook:** §5.6, p. 147; §10.7, p. 464; the underlying real-signal properties are in §5.5.10, pp. 142-145, and §10.5.11, pp. 457-459.

## 5. How many coefficients are needed for a real DT sequence? (slides §4.3, p. 171)

For a real-valued $N$-periodic sequence, combine conjugate symmetry with $N$-periodicity:

$$
\boxed{a_{N-k}=(a_k)^{\ast},\qquad k=1,\ldots,N-1.}
$$

So the coefficients at indices

$$
0,1,\ldots,\left\lfloor\frac{N}{2}\right\rfloor
$$

determine every coefficient in one period. Only

$$
\boxed{\left\lfloor\frac{N}{2}\right\rfloor+1}
$$

coefficient entries need to be stored independently, subject to these restrictions:

- $a_0$ is real because it equals its own complex conjugate.
- If $N$ is even, $a_{N/2}$ is also real: its partner index $N-N/2$ is itself. Its frequency is $\pi$, equivalent to $-\pi$.
- All other entries occur in conjugate pairs. If a real-valued approximation retains one member of a pair, it must retain the conjugate partner as well.

This counts independent **coefficient entries**, not unconstrained complex numbers: the DC entry and, for even $N$, the $N/2$ entry have no independent imaginary part.

**Textbook:** §10.5.11, especially Theorem 10.13, p. 459.

## 6. Complex sinusoids and the frequency response of an LTI system (slides §4.4, pp. 172-173)

A complex sinusoid is an eigenfunction/eigensequence of an LTI system: the output is the same sinusoid multiplied by a complex constant.

### CT

$$
x(t)=e^{j\omega t}
\quad\Longrightarrow\quad
y(t)=H(\omega)e^{j\omega t},
$$

$$
\boxed{H(\omega)=\int_{-\infty}^{\infty}h(\tau)e^{-j\omega\tau}\thinspace d\tau.}
$$

### DT

$$
x(n)=e^{j\omega n}
\quad\Longrightarrow\quad
y(n)=H(\omega)e^{j\omega n},
$$

$$
\boxed{H(\omega)=\sum_{m=-\infty}^{\infty}h(m)e^{-j\omega m}.}
$$

The function $H$ is the system's **frequency response**. It tells us the multiplier applied at each angular frequency.

**Supplement (required textbook condition):** These formulas require the defining integral or sum to converge at the frequency being used.

For a nonzero multiplier, writing

$$
H(\omega)=\lvert H(\omega)\rvert e^{j\arg H(\omega)}
$$

shows that its magnitude scales the component's amplitude and its argument adds a phase offset. If $H(\omega)=0$, that component is removed. The frequency itself does not change.

In DT,

$$
\boxed{H(\omega+2\pi)=H(\omega),}
$$

because the factors $e^{-j\omega m}$ repeat after $2\pi$ for integer $m$. CT frequency responses are not generally periodic.

### Supplement: connect this $H$ to the previous summary

The previous summary used $H(s)$ in CT and $H(z)$ in DT for a **system function**. The present $H(\omega)$ is a **frequency response** with a different argument. To distinguish the notations temporarily,

$$
H_{\mathrm{freq}}(\omega)=H_{\mathrm{sys}}(j\omega)\quad\text{in CT},
$$

$$
H_{\mathrm{freq}}(\omega)=H_{\mathrm{sys}}(e^{j\omega})\quad\text{in DT},
$$

where these evaluations exist. Thus DC uses the frequency-response value **$H(0)$ in both CT and DT**. In the earlier DT system-function notation, the same DC evaluation was at $z=1$, not $z=0$.

**Textbook:** §5.7, Corollary 5.1 and Eq. (5.21), p. 151; §10.8, Corollary 10.1 and Eq. (10.12), pp. 466-467. Convergence conditions for the underlying exponential-input rule: §4.10, pp. 109-110, and §9.10, p. 428.

## 7. Pass a Fourier series through an LTI system (slides §4.4, pp. 174-175)

Each Fourier-series component is a complex sinusoid. Apply the eigenproperty to each component and add the resulting outputs.

### CT

If

$$
x(t)=\sum_{k=-\infty}^{\infty}a_ke^{jk\omega_0t},
\qquad\omega_0=\frac{2\pi}{T},
$$

then, under the convergence qualification below,

$$
\boxed{y(t)=\sum_{k=-\infty}^{\infty}a_kH(k\omega_0)e^{jk\omega_0t}.}
$$

### DT

If

$$
x(n)=\sum_{k=\langle N\rangle}a_ke^{jk\omega_0n},
\qquad\omega_0=\frac{2\pi}{N},
$$

then

$$
\boxed{y(n)=\sum_{k=\langle N\rangle}a_kH(k\omega_0)e^{jk\omega_0n}.}
$$

The notation $\sum_{k=\langle N\rangle}$ means a sum over any $N$ consecutive integers, just as in the previous summary.

**Supplement (required textbook condition):** Each required $H(k\omega_0)$ must exist, as described in §6.

In either case, if $b_k$ denotes the output's Fourier-series coefficients on the **same harmonic grid**,

$$
\boxed{b_k=a_kH(k\omega_0).}
$$

The procedure is:

1. Express the input in complex-exponential Fourier-series form and identify $a_k$ and $\omega_0$.
2. Obtain $H(\omega)$ from the given frequency response or from $h$.
3. Evaluate it at the input's harmonic frequencies: **$k\omega_0$, not simply $k$**.
4. Multiply to obtain $b_k$, then use the synthesis equation if the time-domain output is required.

This avoids computing convolution directly. The system can change or remove harmonic components, but it does not move them to new frequencies. The input period $T$ or $N$ remains a period of the output; the output's **fundamental** period can be smaller if some harmonics disappear.

### Supplement: infinite-series qualification

The DT synthesis sum has only $N$ terms. In CT, passing the system operation through an infinite Fourier series requires suitable convergence and justification for exchanging the system operation with the sum; finite-sum linearity alone does not establish this. A finite sinusoidal input sum does not have this infinite-sum issue.

**Textbook:** §5.7, p. 152 (CT coefficient rule); §10.8, p. 467 (DT coefficient rule). Worked applications for further reading: Examples 5.12-5.13, pp. 152-154, and Examples 10.11-10.13, pp. 467-473. The subsequent filtering sections are outside this summary.

## Quick self-check

1. If a coefficient has index $k$, where does its stem go on an angular-frequency axis? What do its magnitude and phase describe?
2. Why does a CT periodic function have a discrete line spectrum? How does this differ from DT spectrum periodicity?
3. Why do $-\pi$ and $\pi$ not represent two independent DT components?
4. For real $x$, how can you recover $a_{-k}$ from $a_k$? Why can a principal-phase plot show $\pi$ at both members of a conjugate pair?
5. For even $N$, why must $a_{N/2}$ be real? How many independent coefficient entries determine a real $N$-periodic sequence?
6. What is the difference between the input spectrum $a_k$ and the system frequency response $H(\omega)$? How do they determine the output spectrum?
7. Does an LTI system necessarily preserve the input's fundamental period, or only a period? Which value of the frequency response acts on DC?

**Sources:** Michael D. Adams, unified lecture slides, Edition 7.0.0-beta.3, printed pp. 162-175; *Signals and Systems*, Edition 7.0.0-beta.3, sections cited above. Assignment context: Assignment handout Version 2026-09-21, Assignment 4. This summary contains no worked assignment answers and does not enter the next Fourier-transform unit.
