module Perfimmo.Primitive.NonBlankStringTest exposing (..)

import Expect
import Fuzz
import Perfimmo.Primitive.NonBlankString as NonBlankString exposing (..)
import Test exposing (..)
import Utils exposing (fuzzFilterMap)


nonBlankStringFuzzer : Fuzz.Fuzzer NonBlankString
nonBlankStringFuzzer =
    Fuzz.stringOfLengthBetween 1 100 |> fuzzFilterMap NonBlankString.fromString


suite =
    describe "NonBlankString"
        [ test "constructor should return Nothing on empty String" <|
            \_ ->
                Expect.equal (NonBlankString.fromString "") Nothing
        , test "constructor should return Nothing on single-space String" <|
            \_ ->
                Expect.equal (NonBlankString.fromString " ") Nothing
        , test "constructor should return Nothing on lot of spaces String" <|
            \_ ->
                Expect.equal (NonBlankString.fromString " \t ") Nothing
        , test "constructor should return an instance on spaced String" <|
            \_ ->
                let
                    innerString =
                        Maybe.map NonBlankString.toString

                    actual : Maybe NonBlankString
                    actual =
                        NonBlankString.fromString "    \tfooo     "
                in
                Expect.equal (innerString actual) <| Just "    \tfooo     "
        , fuzz2 nonBlankStringFuzzer Fuzz.string "append any string to NonBlankString should return a NonBlankString" <|
            \nonBlankString string ->
                let
                    actual =
                        NonBlankString.append nonBlankString string
                in
                Expect.equal (NonBlankString.toString actual) <| NonBlankString.toString nonBlankString ++ string
        , fuzz2 nonBlankStringFuzzer Fuzz.string "prepend any string to NonBlankString should return a NonBlankString" <|
            \nonBlankString string ->
                let
                    actual =
                        NonBlankString.prepend nonBlankString string
                in
                Expect.equal (NonBlankString.toString actual) <| string ++ NonBlankString.toString nonBlankString
        ]
