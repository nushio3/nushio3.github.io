---
title: Thinking Physically in Haskell
author: Takayuki Muranushi
tags: Protoplanetary Disk, Lightning, Haskell
---

Today I have submitted a paper to Astrophysical Journal. What is so special about this paper is that it is written in Haskell.

That does not only mean that Haskell generates the LaTeX source code for the paper. Chemistry and physics data the paper is based on are presented together in machine-readable forms. The physical formulae and models used in the paper are encoded as Haskell functions. Physical reasonings are functional applications of such formulae. I paid effort to encode most of the physical reasoning of this paper in programming languages, mainly in Haskell, also some C/C++ and Python. Moreover, Haskell parts are type-checked for correctness of quantity calculus. In this paper are no adding of meters to seconds, or meters to light-years; no mixing-ups of radiant flux with radiance, irradiance, spectral radiance, and spectral irradiance.

As a result, the paper demonstrates redefined level of reproducibility and objectivity. Anyone --- even unintellectual silicate circuits --- can reproduce the research by just saying `make paper`. (With dependencies installed. At least, that is what I aimed for in this paper.)

And following advices and practices by [Kenko](../about.html),
[Daisuke](http://www.slideshare.net/pfi/ss-40627009), and 
[Microsoft](https://github.com/Microsoft) (who made Visual Studio an open software,) I decided to make the whole system open to the public eyeballs for feedbacks!

[The source code for the paper](https://github.com/nushio3/lightning/tree/master/paper7) is publically available.

Related Tools
====

- [units](http://hackage.haskell.org/package/units), a package for type-level dimensional analysis in Haskell programs. See also [the slides](http://www.slideshare.net/nushio/haskell-2014-typechecking-polymorphic-units-for-astrophysics-research-in-haskell) and [the paper](http://www.cis.upenn.edu/~eir/papers/2014/units/units.pdf) that describe the "Physics in Haskell" experience from the Haskell's side.
- [authoring](http://hackage.haskell.org/package/authoring), a package for writing papers in Haskell. In addition to LaTeX combinators, it has built-in mechanisms for managing labels for equations, figures and tables, and tracking citations.
- [citation-resolve](http://hackage.haskell.org/package/citation-resolve) is a package for resolving bibliographic references; it recognizes DOIs, ISBNs, arXiv IDs and generates proper citations.



Regrets, or Future Challenges
=====

Remove Lava Flows 
----
As is inevitable with dog-fooding development cycle, some parts of the source code are written in the old style. For example, some parts of the paper English are written directly as HaTeX syntax nodes, because they are written before `authoring` quasi-quoters were available. Also, overall style of physics encoding reflects the legacy of `unittyped` .

As a result, paper exhibits several archeological layers of the development. I hope the subsequent papers will gradually become much free of legacies as we bring the "writing in Haskell" style to well-practiced convention. Or will the "writing with computer" style grow indifinitely?


Unite English Texts into One File
----
The natural language components of the paper is scattered among the tens of Haskell source codes. 
For example, English sentences that describe Hayashi's protoplanetary disk model are right next to the program that encodes Hayashi model equations. Initially, I thought it was the right thing to do, since documentation of a program must sit close to the implementation. However, this later turned out to be a bad design choice. It became harder and harder to follow the logic; "Where is the next section? In which file?" Also, as I repeatedly read the printout, or passed it to people for feedback, I wanted to fix the paper. When I apply the fix to the source, it was a hard job to locate where the particular English sentence is coming from.

In other words, English component of the paper is a spaghetti code that jumps randomly among Haskell source files.

A paper is not a pile of text pasted together. Rather, a good paper must exhibit a good flow of logic. For the next paper, I'm thinking of the opposite approach; rather than embedding English into Haskell source codes as documentations, a single English document should describe the project, to which Haskell values are embedded. The new `inputQ` quasi-quoter of the latest `authoring` package will do the job.


Units-typed Foreign Function Interface
----
Although the Haskell parts are protected from unit errors by use of `units` library, C/C++ and Python parts are not. I have been afraid of it, but I did experienced an error from it. I call [LIME](http://www.nbi.dk/~brinch/lime.php) software for radiative transfer simulations.  For a while I had been giving LIME line velocities in `km/s` where it expects `m/s`. As a result LIME-generated images showed virtually no signals because the given velocities are 1000 times slower than they should be.

More proper approach here should have been to define a Haskell library that wraps LIME C code, and type the interface functions with appropriate units.


Conclusions
=====

In the course of the development, many times I had to fight the urges to restart from scratch, or clean up the old codes. 
And I believe I made the right choice, since had I obeyed those urges, the paper would have never been completed.
The paper is not a completed example of a "physics paper in Haskell". Rather, it represents our current achievement. I make it publically available knowing that it is imperfect, in order to achieve some accomplishment for great good.

