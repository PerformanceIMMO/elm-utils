module Perfimmo.Collection.DictTest exposing (..)

import Perfimmo.Collection.Dict exposing (nonemptyGroupBy)

import Dict
import Expect
import List.Nonempty exposing (Nonempty(..))

import Test exposing (describe, test)

suite =
    describe "Group second level variables by their parent projection name"
        [ test "no input no output" <|
            \_ ->
                let
                    result =
                        nonemptyGroupBy identity []

                    expected =
                        Dict.fromList []
                in
                result |> Expect.equal expected
        , test "multiple elem come into a single entry" <|
            \_ ->
                let
                    result =
                        nonemptyGroupBy Tuple.first [ ( "a", 0 ), ( "a", 1 ) ]

                    expected =
                        Dict.fromList [ ( "a", Nonempty ( "a", 0 ) [ ( "a", 1 ) ] ) ]
                in
                result |> Expect.equal expected
        , test "different elem come into a multiple entry" <|
            \_ ->
                let
                    result =
                        nonemptyGroupBy Tuple.first [ ( "a", 0 ), ( "b", 1 ) ]

                    expected =
                        Dict.fromList [ ( "a", Nonempty ("a", 0) [] ), ( "b", Nonempty ("b", 1) [] ) ]
                in
                result |> Expect.equal expected

        , test "different elem and same elem come into a multiple entry with right data" <|
            \_ ->
                let
                    result =
                        nonemptyGroupBy Tuple.first [ ( "a", 0 ), ( "b", 1 ), ( "a", 2 ), ( "b", 3 ) ]

                    expected =
                        Dict.fromList [ ( "a", Nonempty ( "a", 0 ) [ ( "a", 2 ) ] ), ( "b", Nonempty ( "b", 1 ) [ ( "b", 3 ) ] ) ]
                in
                result |> Expect.equal expected
        ]
