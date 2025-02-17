# A study on the _mysterious_ class AB amplifier

It's pretty common in literature to depict the class B and AB amplifiers as two bipolar transistors conducting alternatively as the input signal varies. The NPN takes care of the upper wave while the PNP handles the negative part.

[TODO: add schematic]

The difference between class AB and class B consists in a subtle biasing that *pre-heats* (so to speak) the two transistors, thus avoiding the infamous **cross-over distortion**.

Assuming the cross-over is dealt with properly (resistor, diodes, 'rubber diode', etc.), I've always been puzzled by how nicely **the handover goes between the two transistors** as the input crosses zero. How come it works so well without any bumps?

Moreover, as the input goes high, one of the transistors completely **turns OFF** without advserse consequences on the output.

Observing each transistor individually, I don't expect much linearity in their behaviour. 
But some _magic_ is happening here, making the output just follow the input, nice and smoothly.

## Case 1: no series resistors on the emitter

### Small signal analysis

We the sake of simplicity, we assume the following:
- symmetrical power supply and quiescent current such that $v_{out} = 0$ when $v_{in} = 0$ (so no decoupling capacitor is required)
- NPN and PNP have similar properties
- base currents are ignored 

Derivation is quite similar to that of the common collector:

[TODO: derivation]


### Large signal analysis
An amplifier is meant for power. It wouldn't be realistic to stay under the small signal hypothesis for a complete study.

Let's go big, and call our good old friend LTspice.


[TODO: figure]

Again, the output follows the input with minor distortion. When I say "minor", it's because it's nowhere near the mess that happens on each transistor:

[TODO: figure]

Observations:
- Current curves are highly **non-linear**, yet pretty **symmetrical**
- From the load point of view, non-linearities mostly **disappear**, exhibiting a **voltage follower property**.

Seeing this, my first guess was that the NPN and PNP are too ideally matched. Such a symmetry looks suspiciously surreal. 
Though, I used a BC847 / BC857 and as far as I know, they are not matched _that closely_.

In doubt, it would be interesting to **'detune'** their models.
I didn't really want to bother looking up how to create a custom model in LTSpice.

Also, at that point I had some clues about what was going on, and I wanted to plug in any model, not just a tweaked NPN/PNP part. 

So I was off simulating the circuit myself. Turns out it's not as tricky as it sounds.

### Simulating a simplified large signal model, the DIY way.

Let's reduce the NPN and PNP to a simple **Voltage Controlled Current Source** (VCCS). 

Also, we abstract the i/v relationship with a sober:
- $I_E = f(V_{BE})$ for the NPN transistor,
- $I_E = g(V_{EB})$ for the PNP transistor.

Forget about the base current participating to I<sub>E</sub>, it is neglected for simplicity.

Actually, let's completely forget about the exponential behaviour of the bipolar transistor. 
Let's just assume $f(x)$ and $g(x)$ being monotonic in $x$ with a _decent_ slope.

Then $v_{out}$ is simply:

[TODO: add equation]

Notice that the equation is actually an **implicit equation**: $v_{out} = somefunc(v_{in}, v_{out})$

That was the case already in the small signal analysis, but the equation was simple enough to extract `v_out`.

Here, there's little chance to find a closed form for `v_out`, in particular when `f` and `g` are exponential-like.

### Solving with the _self-correcting_ approach
One approach would be setting `v_out` to a 'plausible' value, and reinjecting it to the rest of the equations, giving a new value for `v_out`, and _hoping_ that the approximation would improve itself.

While this method works quite well for a classic resistor + diode circuit, it behaves poorly here (unstable).

> [!NOTE]
Maybe a proper rewrite of the equation (in terms of `log` instead of `exp`) could solve the issue, but I didn't really want to bother digging into the numerical stability aspects for now.

### Solving with the _brute-force_ approach
To find the operating point, we can just use a crude **brute-force exploration**.

The real circuit works, it doesn't blow off, so there **must** be a finite and realistic value for `v_out`.
We have a clue of the range `v_out` lives in, let's just try a lot of values until there's a decent match between `v_out` and f(...) - g(...) 

A simple min-finding makes it pretty easy to get the operating point: 

[TODO: add curve]

That being done, we are on the right tracks for a simple simulation with a sinewave input.

Results with an incorrect cross-over compensation:

[TODO: add curve]

That looks quite promising.
And in proper operation:

[TODO: add curve]

As of the current sources behaviour:

[TODO: add curve]

Again: massive non-linearities, but with a symmetry between the two transistors. But now, there's something we can do about it.

Let's detune dramatically the PNP from the NPN so that it acts almost as a MOSFET:
- f(x) = 1e-14*(exp(vBE/Vt)-1)
- g(x) = 0.01*(x-0.6)^2 (x > 0.6), 0 otherwise.

[TODO: add curve]

Surprise: it still acts as a voltage follower!

Further experimentations show that the exact model for the NPN/PNP doesn't really matter, as long as the slope in the i/v curve shows "enough" gain. 
Which is good news for real world implementation. 

But now, to understand what is really going on, it's time for some deeper exploration.

### Analysis as a feedback loop

A voltage follower that operates regardless of the exact gain of its inner components reminds us of the op amp version of this function. 
And the key to that is **feedback**.

This circuit must have some sort of hidden feedback somewhere.

Starting from $v_{out} = f(x) - g(...)$, here's an attempt for a block diagram representation of the circuit: 

![feedback_diagram](https://github.com/user-attachments/assets/f5796714-944c-40b2-a4a1-b4d5bac4fc05)

Here comes the feedback loop, in a somewhat op-amp-ish form.

It is worth noting that this is more of an abstract representation. In real life, we can't really dissociate the emitter potential from the current going to the load that easily.



## Case 2: series resistors on the emitter
For practical implementations, it is common to see a resistor added in series with the emitter. Some books justify them for 'thermal stability purposes'.

These resistors introduce further static dissipation, as well as a drop in the overall gain. So they are preferably kept to a very low value.

**Example**: the Minimoog headphones amplifier
![image](https://github.com/user-attachments/assets/c40eaea1-8921-4488-a6bd-8c6ddbdb5e4a)



### Large signal analysis
Let's dive directly into the large signal analysis.

Introducing the resistors complexifies a tad the analysis but it is still possible to interpret it in terms of feedback loops.




