module Perfimmo.Json.NonEmptyStringTest exposing (..)

import Expect
import Fuzz
import Json.Decode as Decode exposing (Decoder, Error)
import Json.Encode as Encode
import Perfimmo.Json.NonEmptyString exposing (decoder, encoder)
import Perfimmo.Primitive.NonEmptyString as NonEmptyString exposing (..)
import Test exposing (..)
import Utils exposing (fuzzFilterMap)


nonEmptyStringFuzzer : Fuzz.Fuzzer NonEmptyString
nonEmptyStringFuzzer =
    Fuzz.stringOfLengthBetween 1 100 |> fuzzFilterMap NonEmptyString.fromString


suite =
    describe "NonEmptyStringDecoder"
        [ test "should decode a non empty string value" <|
            \_ ->
                Expect.ok (Decode.decodeString decoder """ "foo" """)
        , test "should fail decoding an empty string" <|
            \_ -> Expect.err (Decode.decodeValue decoder <| Encode.string "")
        , test "should encode a non empty string value" <|
            \_ ->
                let
                    nonEmpty =
                        NonEmptyString.fromString "foo"

                    actual =
                        Maybe.map encoder nonEmpty
                in
                Expect.equal actual <| Just <| Encode.string "foo"
        , fuzz nonEmptyStringFuzzer "encode -> decode roundtrip should produce the same value" <|
            \s ->
                let
                    roundtrip =
                        encoder >> Decode.decodeValue decoder
                in
                Expect.equal (roundtrip s) <| Ok s
        ]
