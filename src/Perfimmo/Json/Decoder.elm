module Perfimmo.Json.Decoder exposing
    ( subDecoderByType
    )

{-| Decoder

@docs subDecoderByType
-}

import Json.Decode as D exposing (Decoder)

subDecoderByType : String -> (String -> Decoder b) -> Decoder b
subDecoderByType discriminator subDecoder = D.field discriminator D.string |> D.andThen subDecoder