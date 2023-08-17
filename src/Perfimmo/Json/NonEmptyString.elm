module Perfimmo.Json.NonEmptyString exposing (decoder, encoder)

{-| NonEmptyString

@docs decoder, encoder

-}

import Json.Decode as Decode exposing (Decoder)
import Json.Encode as Encode exposing (Value)
import Perfimmo.Primitive.NonEmptyString as NonEmptyString exposing (NonEmptyString)


{-| decoder
-}
decoder : Decoder NonEmptyString
decoder =
    Decode.string
        |> Decode.andThen (NonEmptyString.fromString >> Maybe.map Decode.succeed >> Maybe.withDefault (Decode.fail "should not be empty"))


{-| encoder
-}
encoder : NonEmptyString -> Value
encoder =
    NonEmptyString.toString >> Encode.string
