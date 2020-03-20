//: [Previous](@previous)

import Foundation

//: # Chapter Four

//: 1. Construct the Kleisli category for partial functions (define composition and identity).

//composition Fish
precedencegroup ForwardComposition {
  associativity: left
}

infix operator >=>: ForwardComposition

// Simple Composition
func >=><A,B,C>(f: @escaping(A) -> B, g: @escaping(B) -> C ) -> (A) -> C {
    return {a in g(f(a))}
}

// Another version to make optionals like in safeRootReciprocal work
func >=><A,B,C>(f: @escaping(A) -> B?, g: @escaping(B) -> C?) -> (A) -> C? {
    return {a in
        guard let result = f(a) else { return nil }
        return g(result)
    }
}

func id<A>(x: A) -> A? {
    return Optional(x)
}

struct Writter<A> {
    let pair: (A, String)
}

func WriterIdentity<A>(_ a: A) -> (A, String) {
    return (a, "")
}

// Writer Composition
func >=><A,B,C>(f: @escaping(A) -> Writter<B>, g: @escaping(B) -> Writter<C> ) ->  (A) -> Writter<C> {
    return {a in
        g(f(a).pair.0)
    }
}

//: 2. Implement the embellished function safe_reciprocal that returns a valid reciprocal of its argument, if its different from zero.
func safe_reciprocal(_ x: Double) -> Double? {
  return x == 0 ? nil : 1/x
}

//: 3. Compose the functions safe_root and safe_reciprocal to implement safe_root_reciprocal that calculates sqrt(1/x) whenever possible.
func safe_root(_ x: Double) -> Double? {
  return x < 0 ? nil : sqrt(x)
}

let safe_root_reciprocal = safe_reciprocal >=> safe_root

safe_root(5)
safe_reciprocal(5)
safe_root_reciprocal(5)


//: [Next](@next)
