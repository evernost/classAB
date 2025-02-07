# A study on the mysterious class AB amplifier

It's pretty common in literature to depict the class B and AB amplifiers as two transistors conducting alternatively as the input signal varies. The NPN takes care of the upper wave while the PNP handles the negative part.

The difference between class AB and class B consists in a subtle biasing that pre-heats (so to speak) the two transistors, thus avoiding the infamous **cross-over distortion**.

Assuming the cross-over is dealt with properly, I've always been puzzled by how nicely the handover goes between the two transistors as the input crosses zero. How come it works so well without any bumps?

Moreover, as the input goes, one of the transistors might even reach the blocked region without consequences on the output.

Observing each transistor individually, I don't expect much linearity in their behaviour. But for some _magical_ reason, the output doesn't see this mess and just follows the input nice and smoothly.

## Small signal analysis

Derivation is quite similar to that of the common collector.

[TODO: derivation]


## Large signal analysis
An amplifier is meant for power. It wouldn't be realistic to stay under the small signal hypothesis. 

Let's go big, and call our good old friend LTspice.


[TODO: figure]

Again, the output follows the input with minor distortion. When I say "minor", it's because it's nowhere near the mess that happens on each transistor:

[TODO: figure]

Observations:
- Current curves are highly non-linear, yet pretty symmetrical
- From the load point of view, non-linearities mostly disappear, exhibiting a voltage follower property.

Seeing this, my first guess was that the NPN and PNP are too ideally matched. Such a symmetry looks suspiciously surreal. 
Though, I used a BC847 / BC857 and as far as I know, they are not that closely matched.

In doubt, it would be interesting to **'detune'** their models.
I didn't really want to bother looking up how to create a custom model in LTSpice.

Also, at that point I had some clues about what was going on, and I wanted to plug in any model, not just a tweaked NPN/PNP part. 

So I was off simulating the circuit myself. Turns out it's not as tricky as it sounds.

## Simulating a simplified large signal model, the DIY way

Let's reduce the NPN and PNP to a simple Voltage Controlled Current Source (VCCS). 

Also, we abstract the i/v relationship with a sober I<sub>E</sub> = f(Vbe) for the NPN, and Ie = g(Veb) for the PNP. Forget about the base current participating to Ie. Actually, let's completely forget about the exponential behaviour. Let's just assume f(x) and g(x) being monotonic in x, with a decent slope.
Then Vout is simply:

As such, the equation is actually and implicit equation for which there's little chance to find a closed form for v_out, in particular when f and g are exponentials.

One approach would be setting v_out to a 'plausible' value, and reinjecting it to the rest of the equations, giving a new value for v_out, and hoping that it would improve the approximation. 

While this method works quite well for a resistor + diode circuit, it behaved poorly here, being very unstable.
Maybe a proper rewrite of the equation (in terms of log instead of exp) could solve the issue, but I didn't really want to bother digging into the numerical stability aspects for now.

To find the operating point, we can just use a crude brute-force exploration. The real circuit works, it doesn't blow off, so there must be a finite and realistic value for v_out. We have a clue of the range v_out lives in, let's just try a lot of values until there's a decent match between v_out and f(...) - g(...) 

A simple min-finding makes it pretty easy to find the operating point: 


That being done, we were on the right tracks for a simple simulation with a sinewave input.
Results with an incorrect cross-over compensation:

That looks quite promising.
And in proper operation:




As of the current sources behaviour:

Again, massive non-linearities, but with a symmetry between the two transistors. But now, we can do something about it.
Let's detune dramatically the PNP from the NPN so that it becomes a MOSFET:


Surprise: it still acts as a follower.
After further experimentation, the actual model does not matter that much, as long as the slope in the i/v curve shows enough gain. Which is good news for real world implementation. 

But now, to understand what is really going on, it's time for some deeper exploration.

## Feedback analysis

A voltage follower that operates regardless of the exact gain of its inner components reminds us of the op amp version of this function. And the key to that is feedback.

This circuit must have some sort of hidden feedback loop too, that would explain our observations.

Starting from v_out = f(x) - g(...), here's an attempt for a block diagram representation of the circuit: 

Here comes the feedback loop!
It is worth noting that this is more of an abstract representation. In real life, we can't really dissociate the emitter potential from the current going to the load.
