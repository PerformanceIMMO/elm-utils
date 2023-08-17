module Perfimmo.Json.NonBlankStringTest exposing (..)

import Expect
import Fuzz
import Json.Decode as Decode exposing (Decoder, Error)
import Json.Encode as Encode
import Perfimmo.Json.NonBlankString exposing (decoder, encoder)
import Perfimmo.Primitive.NonBlankString as NonBlankString exposing (..)
import Test exposing (..)
import Utils exposing (fuzzFilterMap)


nonBlankStringFuzzer : Fuzz.Fuzzer NonBlankString
nonBlankStringFuzzer =
    Fuzz.stringOfLengthBetween 1 100 |> fuzzFilterMap NonBlankString.fromString


suite =
    describe "NonBlankStringDecoder"
        [ test "should decode a non blank string value" <|
            \_ ->
                Expect.ok (Decode.decodeString decoder """ "foo" """)
        , test "should fail decoding an empty string" <|
            \_ -> Expect.err (Decode.decodeValue decoder <| Encode.string "")
        , test "should fail decoding a blank string" <|
            \_ -> Expect.err (Decode.decodeValue decoder <| Encode.string " \t")
        , test "should encode a non blank string value" <|
            \_ ->
                let
                    nonBlank =
                        NonBlankString.fromString "foo"

                    actual =
                        Maybe.map encoder nonBlank
                in
                Expect.equal actual <| Just <| Encode.string "foo"
        , fuzz nonBlankStringFuzzer "encode -> decode roundtrip should produce the same value" <|
            \s ->
                let
                    roundtrip =
                        encoder >> Decode.decodeValue decoder
                in
                Expect.equal (roundtrip s) <| Ok s
        ]
