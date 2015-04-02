# Using NOWEB to write TeX or LaTeX macros

 Norman Ramsey's [NOWEB](http://www.cs.tufts.edu/~nr/noweb/) literate
programming tool can be used to write TeX or LaTeX macros.

## The Makefile

The Makefile must declare several variables:

- _NOWEB_ enumerates your NOWEB files;
- _NOTANGLE_ enumerates the code files that need to be
generated from the NOWEB files;
- _NOWEAVE_
