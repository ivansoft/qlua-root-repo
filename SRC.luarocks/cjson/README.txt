
https://www.kyne.com.au/~mark/software/lua-json-performance.html

DKJSON
Tested with/without LPeg 10.2.

Lua YAJL
Tested with YAJL 2.0.4.

Lua CJSON
Tested with Libc and internal floating point conversion routines.

These results show the number of JSON operations per second sustained by each module.
All results have been normalised against the pure Lua DKJSON implementation.


Decoding performance

             | DKJSON                  | Lua YAJL   | Lua CJSON
             | No LPeg     With LPeg   |            | Libc         Internal
             | Lua  JIT    Lua    JIT  | Lua   JIT  | Lua   JIT    Lua   JIT
example1     | 1x   2x     2.6x   3.4x | 7.1x  10x  | 14x   20x    14x   20x
example2     | 1x   2.2x   2.9x   4.4x | 6.7x  9.9x | 14x   22x    14x   22x
example3     | 1x   2.1x   3x     4.3x | 6.9x  9.3x | 14x   21x    15x   22x
example4     | 1x   2x     2.5x   3.7x | 7.3x  10x  | 12x   19x    12x   20x
example5     | 1x   2.2x   3x     4.5x | 7.8x  11x  | 16x   24x    16x   24x
numbers      | 1x   2.2x   2.3x   4x   | 4.6x  5.5x | 8.9x  10x    13x   17x
rfc-example1 | 1x   2.1x   2.8x   4.3x | 6.1x  8.1x | 13x   19x    14x   21x
rfc-example2 | 1x   2.1x   3.1x   4.2x | 7.1x  9.2x | 15x   21x    17x   24x
types        | 1x   2.2x   2.6x   4.3x | 5.3x  7.4x | 12x   20x    13x   21x
-------------|-------------------------|------------|-----------------------
= Average => | 1x   2.1x   2.7x   4.1x | 6.5x  9x   | 13x   20x    14x   21x



Encoding performance

             | DKJSON                  | Lua YAJL   | Lua CJSON
             | No LPeg     With LPeg   |            | Libc         Internal
             | Lua  JIT    Lua    JIT  | Lua   JIT  | Lua   JIT    Lua   JIT
example1     | 1x   1.8x   0.97x  1.6x | 3.1x  5.2x | 23x   29x    23x   29x
example2     | 1x   2x     0.97x  1.7x | 2.6x  4.3x | 22x   28x    22x   28x
example3     | 1x   1.9x   0.98x  1.6x | 2.8x  4.3x | 13x   15x    16x   18x
example4     | 1x   1.7x   0.96x  1.3x | 3.9x  6.1x | 15x   19x    17x   21x
example5     | 1x   2x     0.98x  1.7x | 2.7x  4.5x | 20x   23x    20x   23x
numbers      | 1x   2.3x   1x     2.2x | 1.3x  1.9x | 3.8x  4.1x   4.2x  4.6x
rfc-example1 | 1x   1.9x   0.97x  1.6x | 2.2x  3.2x | 8.5x  9.3x   11x   12x
rfc-example2 | 1x   1.9x   0.98x  1.6x | 2.6x  3.9x | 10x   11x    17x   19x
types        | 1x   2.2x   0.97x  2x   | 1.2x  1.9x | 11x   13x    12x   14x
-------------|-------------------------|------------|-----------------------
= Average => | 1x   1.9x   0.98x  1.7x | 2.5x  3.9x | 14x   17x    16x   19x






