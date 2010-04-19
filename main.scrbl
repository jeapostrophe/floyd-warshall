#lang scribble/manual
@(require (for-label (except-in scheme/base path?)
                     scheme/contract
                     "main.ss"))

@title{Floyd-Warshall}
@author{@(author+email "Jay McCarthy" "jay@plt-scheme.org")}

An implementation of the @link["http://en.wikipedia.org/wiki/Floyd–Warshall_algorithm"]{Floyd-Warshall} all shortest paths algorithm.

@defmodule[(planet jaymccarthy/floyd-warshall)]

@defstruct[path 
           ([cost number?]
            [edges (listof any/c)])]

A struct representing the path between two vertices. The edge list is really the list of nodes along the way.

Note: @scheme[cost] may be @scheme[+inf.0] and @scheme[edges] may be empty.

@defproc[(shortest-paths [how-many-nodes exact-integer?]
                         [node-path (exact-integer? exact-integer? . -> . path?)])
         (matrix? exact-integer? exact-integer? path?)]

Returns a matrix (from @schememodname[(planet wmfarr/simple-matrix/matrix-base)]) that is @scheme[how-many-nodes] by @scheme[how-many-nodes] where entry @schemeidfont{(i,j)} is the shortest path from node @scheme[i] to node @scheme[j].