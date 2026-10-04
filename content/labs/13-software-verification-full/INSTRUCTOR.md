# Instructor Notes: Session 13 --- Software Verification

Local exercise, no deployment.

The payoff is `swap_xor(&a, &a)`: the XOR trick is provably correct only when the two pointers do not alias, an assumption the contract omits.
Lead the equational reasoning on the board; the aliasing break is the point to land.

The previous edition also had a linked-list verification task (`sis-private/software-verification/list`); it can be added as a second task if there is time.
