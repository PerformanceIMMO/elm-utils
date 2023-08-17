module Perfimmo.Primitive.NonEmptyStringTest exposing (..)

import Expect
import Fuzz
import Perfimmo.Primitive.NonEmptyString as NonEmptyString exposing (..)
import Test exposing (..)
import Utils exposing (fuzzFilterMap)


nonEmptyStringFuzzer : Fuzz.Fuzzer NonEmptyString
nonEmptyStringFuzzer =
    Fuzz.stringOfLengthBetween 1 100 |> fuzzFilterMap NonEmptyString.fromString


suite =
    describe "NonEmptyString"
        [ test "constructor should return Nothing on empty String" <|
            \_ ->
                Expect.equal (NonEmptyString.fromString "") Nothing
        , fuzz (Fuzz.stringOfLengthBetween 1 100) "constructor should return an instance if non-empty input" <|
            \value ->
                let
                    innerString =
                        Maybe.map NonEmptyString.toString

                    actual : Maybe NonEmptyString
                    actual =
                        NonEmptyString.fromString value
                in
                Expect.equal (innerString actual) <| Just value
        , fuzz2 nonEmptyStringFuzzer Fuzz.string "append any string to NonEmptyString should return a NonEmptyString" <|
            \nonEmptyString string ->
                let
                    actual =
                        NonEmptyString.append nonEmptyString string
                in
                Expect.equal (NonEmptyString.toString actual) <| NonEmptyString.toString nonEmptyString ++ string
        ]
