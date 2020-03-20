//: # Chapter One
//: 1. Implement, as best as you can, the identity function in your favorite language (or the second favorite, if your favorite language happens to be Haskell).

func id<T>(_ t: T) -> T{
    return t
}

//:  ### "For every object A there is an arrow which is a unit of composition. This arrow loops from the object to itself. Being a unit of composition means that, when composed with any arrow that either starts at A or ends at A, respectively, it gives back the same arrow."


//: 2. Implement the composition function in your favorite language. It takes two functions as arguments and returns a function that is their composition.
infix operator ∘: ForwardComposition

precedencegroup ForwardComposition {
  associativity: left
}

func ∘<A,B,C>(_ f: @escaping (A) -> B, _ g: @escaping (B) -> C) -> (A) -> C {
  return { a in g(f(a))
  }
}

func composition<A,B,C>(f: @escaping(A) -> B, g: @escaping(B) -> C ) -> (A) -> C {
    return {a in g(f(a))}
}

//:  ### g∘f as “g after f.”


//: 3. Write a program that tries to test that your composition function respects identity.

func square(_ int: Int) -> Int {
  return int*int
}

(id∘square)(5) == (square∘id)(5) // true
(id∘square)(5) == square(5) // true
5 == id(5) // true

func compositionUsingIdentity<A,B,C>(f: @escaping(A) -> B, g: @escaping(B) -> C ) -> (A) -> C {
    return {a in g(f(id(a)))}
}
// Pass a as an identity function
let a = id("a")

//: [Next](@next)
