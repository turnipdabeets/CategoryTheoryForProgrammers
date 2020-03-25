import Foundation
import UIKit

//: [Previous](@previous)

//: # Chapter Two

//:  ### Swift's Bottom Type, absurd type, is ["Never"](https://github.com/apple/swift-evolution/blob/master/proposals/0102-noreturn-bottom-type.md#never-as-a-universal-bottom-subtype)

/*:
Void vs Never
 - Implementation: Void is a tuple, Never is an empty enum.
 - Never informs the compiler that there is no need to return a value.
 - Never is used in methods that will unconditionally throw an error or crash the system.
 - Never can’t be constructed, is an uninhabited type
*/

// Swift enumeration cases don’t have an integer value set by default, unlike languages like C and Objective-C.


/*:
- A mathematical function is just a mapping of values to values.
- A mathematical function does not execute any code
- In programming languages, functions that always produce the same result given the same input and have no side effects are called pure functions.
- Monads let us model all kinds of effects using only pure functions. So we really don’t lose anything by restricting ourselves to mathematical functions.
- Are pure functions mathematical functions?
*/

/*:
- "Types are Sets"
- Haskell Unit f44 :: () -> Integer  or f44 () = 44
- Swift's (Void) -> Int
- Declares that f44 takes the type (), pronounced “unit,” into the type Integer.
- parametrically polymorphic = Functions that can be implemented with the same formula for any type
- predicates = Functions to Bool are called.
*/

//: Unit, there is one and only one pure function from any type to the unit type
func unit() -> Void {}

//: Absurd
func absurd<T>(t: Never) -> T {}
 
//: 1. Define a higher-order function (or a function object) memoize in your favorite language. This function takes a pure function f as an argument and returns a function that behaves almost exactly like f, except that it only calls the original function once for every argument, stores the result internally, and subsequently returns this stored result every time it’s called with the same argument. You can tell the memoized function from the original by watch- ing its performance. For instance, try to memoize a function that takes a long time to evaluate. You’ll have to wait for the result the first time you call it, but on subsequent calls, with the same argument, you should get the result immediately.

func memoize<A: Hashable, B>(_ f: @escaping (A) -> B ) -> (A) -> B{
    var memo = [A:B]()
    return{ a in
        if let b = memo[a] { return b }
        let result = f(a)
        memo[a] = result
        return result
    }
}

let double: (Int) -> Int = { int in
  do {
    sleep(5)
    return int * 2
  }
}

let doubleMemo = memoize(double)

//doubleMemo(1)
//doubleMemo(2)
//doubleMemo(3)
//doubleMemo(1)
//doubleMemo(2)

//: 2. Try to memoize a function from your standard library that you normally use to produce random numbers. Does it work?
//: 3 Most random number generators can be initialized with a seed. Implement a function that takes a seed, calls the random number generator with that seed, and returns the result. Memoize that function. Does it work?

//let randomMemo = memoize(f: Int.random(in:))
let randomNumberGenerator: (Int) -> Int = { _ in Int.random(in: 1...100) }
let memoizedRandom = memoize(randomNumberGenerator)

//Memoization works, but this use case doesn't make sense. The input will produce the same output when we want a random output.

//: 4. Which of these functions are pure? Try to memoize them and see what happens when you call them multiple times

func factorial(_ input: Int) -> Int {
  return input == 0 ? 1 : input * factorial(input - 1)
}

factorial(4) // 24
memoize(factorial)(4) // 24

func toBool() -> Bool { print("Hello\n"); return true }

toBool()
//memoize(toBool) // does not work

func staticInt(_ x: Int) -> Int { var y = 0; y += x; return y }

staticInt(3) // 3
memoize(staticInt)(3) // 3

//: 5. How many different functions are there from Bool to Bool? Can you implement them all?

// maps T -> T and F -> F
func id_bool(_ x: Bool) -> Bool { return x }

// maps T -> F and F -> T
func inverse(_ x: Bool) -> Bool { return !x }

// maps T -> F and F -> F
func `false`(_: Bool) -> Bool { return false }

// maps T -> T and F -> T
func `true`(_: Bool) -> Bool { return true }

`true`(true)

//: [Next](@next)
