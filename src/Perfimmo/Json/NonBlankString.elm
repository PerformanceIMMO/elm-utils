module Perfimmo.Json.NonBlankString exposing (decoder, encoder)

{-| NonBlankString

@docs decoder, encoder

-}

import Json.Decode as Decode exposing (Decoder)
import Json.Encode as Encode exposing (Value)
import Perfimmo.Primitive.NonBlankString as NonBlankString exposing (NonBlankString)


{-| decoder
-}
decoder : Decoder NonBlankString
decoder =
    Decode.string
        |> Decode.andThen (NonBlankString.fromString >> Maybe.map Decode.succeed >> Maybe.withDefault (Decode.fail "should not be blank"))


{-| encoder
-}
encoder : NonBlankString -> Value
encoder =
    NonBlankString.toString >> Encode.string
