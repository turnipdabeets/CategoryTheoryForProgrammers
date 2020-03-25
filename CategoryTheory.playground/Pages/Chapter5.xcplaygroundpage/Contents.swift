//: [Previous](@previous)

import Foundation

//: # Chapter Five

/*:
 - We are defined by our relationships.
 - These relationships are defined by morphisms. You can thiink of morphisms as arrows.
*/

//: #### The initial object is the object that has one and only one morphism going to any object in the category.

//: initial object is unique up to isomorphism; it is unique up to unique isomorphism - this is an important property of all universal constructions

//: In the category of sets and functions, the initial object is the empty set. An empty set corresponds to Swift's Never type, or Haskell's Void type and the unique polymorphic function from Never to any other type is called absurd. It’s this family of morphisms that makes Never the initial object in the category of types.

func absurd<T>(t: Never) -> T {}

//: #### The terminal object is the object with one and only one morphism coming to it from any object in the category.

//: In the category of sets, the terminal object is a singleton. They correspond the the unit type in Haskell or Void in Swift.

//: Unit, there is one and only one pure function from any type to the unit type
func unit() -> Void {}

//: Insisting on uniqueness gives us just the right precision to narrow down the definition of the terminal object to just one type.

//: #### opposite category is defined just by reversing all the arrows

//: The constructions in the opposite category are often prefixed with “co”: products and coproducts, monads and comonads, cones and cocones, limits and colimits

//: #### no-op is the reversed identity arrow

//: #### isomorphism, in mathematics, is a mapping between two structures of the same type that can be reversed by an inverse mapping. Two mathematical structures are isomorphic if an isomorphism exists between them.

//: #### A product of two objects a and b is the object c equipped with two projections such that for any other object c’ equipped with two projections there is a unique morphism m from c’ to c that factorizes those projections.


// factorizer for a product
func factorizer<A,B,C>(i: @escaping (C) -> A, j: @escaping (C) -> B) -> (C) -> (A, B) {
    return { c in
        return (i(c), j(c))
    }
}

//: #### A coproduct of two objects a and b is the object c equipped with two injections such that for any other object c’ equipped with two injections there is a unique morphism m from c to c’ that factorizes those injections.

//: #### A tagged union is also called a variant

protocol PhoneNumber {}
protocol EmailAddress {}

struct Contact: PhoneNumber, EmailAddress {}

enum Either<L, R> {
  case left(L)
  case right(R)
}

// factorizer for a coproduct
func factorizer<A,B,C>(i: @escaping (A) -> C, j: @escaping (B) -> C) -> (Either<A, B>) -> C {
    return { either in
        switch either {
        case let .left(a):
            return i(a)
        case let .right(b):
            return j(b)
        }
    }
}

//: #### product behaves like multiplication, with the terminal object playing the role of one; whereas coproduct behaves more like the sum, with the initial object playing the role of zero


//: [Next](@next)
