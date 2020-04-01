//: [Previous](@previous)

import Foundation

//: # Chapter Six

//: #### An isomorphism is a mapping for which an inverse mapping also exists. It's a way to describe equivalence.
//: In programming, you often have the choice to implement a particular feature in more than one way. These alternatives may be equivalent, in which case they're isomorphic.

//: Alegbra of Types
/*:
 - Void unit is 1 and the neutral product type
 - Never is 0 and the neutral sum type
 - Enums like Either or Optional is a sum type
 - Structs, tuples are Product types
 */

//: - Bool true or false                         1 + 1 = 2
//: - Optional .none or .some              1 + a

//: Logical Types
/*:
 - Never is false
 - Unit (Void) is true
 - Either is a || b
 - (a,b) is a && b
 */

//: Haskell data structures are immutable, so a JUST "energy" will never turn into Nothing. The immutability makes the construction reversible.

enum Either<L, R> {
    case left(L)
    case right(R)
}

extension Either {
    init(left: L) {
        self = .left(left)
    }
}

extension Either {
    init(right: R) {
        self = .right(right)
    }
}

func productToSum<A, B, C>(a: A, either: Either<B,C>) -> Either<(A, B), (A,C)> {
    switch either {
    case let .left(l):
        return Either(left: (a, l))
    case let .right(r):
        return Either(right: (a, r))
    }
}

func sumToProduct<A, B, C>(_ e: Either<(A, B), (A, C)>) -> (a: A, either: Either<B,C>) {
    switch e {
    case let .left(x, y):
        return (x, Either(left: y))
    case let .right(x, z):
        return (x, Either(right: z))
    }
}

//: Show isomorphism between Maybe and Either

// both are enums
func optionalToEither<A>(a: A?)-> Either<A,A?> {
    if let a = a {
        return Either(left: a)
    }else {
        return Either(right: a)
    }
}

func eitherToOptional<A>(_ either: Either<A, A?>) -> A? {
    switch either {
    case let .left(some):
        return some
    case let .right(none):
        return none
    }
}

//: Implement Shape and area
enum Shape {
    case circle(r:Float)
    case rect(d: Float, h: Float)
}

func area(_ shape: Shape) -> Float {
    switch shape {
    case let .circle(r):
        return .pi * r * r
    case let .rect(d, h):
        return d * h
    }
}

//: implement circumference. We can easily add a new function without touching the definition of Shape
func circumference(_ shape: Shape) -> Float {
    switch shape {
    case let .circle(r):
        return 2.0 * .pi * r
    case let .rect(d, h):
        return 2.0 * (d + h)
    }
}

//: Add a new shape, Square, to Shape. What code did you have to touch?
//Adding a case to Shape involved updating both `area` and `circumference` switch statements


//: [Next](@next)
