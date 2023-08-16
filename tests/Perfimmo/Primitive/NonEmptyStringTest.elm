module Perfimmo.Primitive.NonEmptyStringTest exposing (..)

import Expect
import Fuzz
import Perfimmo.Primitive.NonEmptyString as NonEmptyString
import Test exposing (..)


suite =
    describe "NonEmptyString"
        [ test "constructor should return Nothing on empty String" <|
            \_ ->
                Expect.equal (NonEmptyString.fromString "") Nothing
        , fuzz (Fuzz.stringOfLengthBetween 1 100) "constructor should return an instance if non-empty input" <|
            \value ->
                let
                    actual =
                        NonEmptyString.fromString value

                    innerString =
                        Maybe.map NonEmptyString.toString actual
                in
                Expect.equal innerString <| Just value
        ]
