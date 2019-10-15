module CounterTest exposing (..)

import  Counter exposing (..)
import Expect exposing (Expectation)
import Test exposing (..)

suite : Test
suite =
    describe "Counter module"
        [ describe "update will change model"
            [ test "when Increase messed is passed, model is increased" <|
                \_ ->
                    let
                        model = init
                    in
                        Expect.equal (update Increment model) 1
            , test "when Decrease messed is passed, model is increased" <|
                              \_ ->
                                  let
                                      model = init
                                  in
                                      Expect.equal (update Decrement model) -1
            ]
        ]