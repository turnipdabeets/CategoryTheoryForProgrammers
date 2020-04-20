//: [Previous](@previous)

import Foundation

//: # Chapter Seven

//: ## Functors, a mapping between categories that preserves connections and preserves the structure of the category
//: Functors are more restrictive than regular functions

//: ### Endofunctors map category to itself, it maps types to types. The Maybe Functor uses a Maybe type as a constructor that requires a type like Bool ir int to turn it into a type.

//: Functor Laws:
//: - preserves identity and composition


//: f :: a -> b   becomes Ff :: Fa -> Fb

enum Maybe<A> {
    case nothing
    case just(A)
}

// Swift abstraction that doesn't actually work
//protocol Functor: Self<A> {
//    func fmap<B>(f: A -> B) -> Self<A> -> Self<B>
//}

//enum Maybe<A>: Functor

//func fmap<A, B>(_f: @escaping (A) -> B) -> (Maybe<A>) -> Maybe<B> {}

//: Implement the reader functor in your second favorite language (Swift):

func reader<A, B>(b: B) -> (A) -> B {
  return { _ in b }
}




//: [Next](@next)
