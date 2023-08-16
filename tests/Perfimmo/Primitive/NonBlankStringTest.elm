module Perfimmo.Primitive.NonBlankStringTest exposing (..)

import Expect
import Perfimmo.Primitive.NonBlankString as NonBlankString exposing (..)
import Test exposing (..)


innerString =
    Maybe.map NonBlankString.toString


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
                    actual : Maybe NonBlankString
                    actual =
                        NonBlankString.fromString "    \tfooo     "
                in
                Expect.equal (innerString actual) <| Just "    \tfooo     "
        ]
