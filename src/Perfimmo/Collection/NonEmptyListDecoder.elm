module Perfimmo.Collection.NonEmptyListDecoder exposing
    ( nelJsonDecoder
    )

{-| NonEmptyListDecoder

@docs  nelJsonDecoder
-}

import Json.Decode as D exposing (Decoder, list)
import List.Nonempty as NEL
import Perfimmo.Collection.NonEmptyList exposing (NEL)

{-| nelJsonDecoder
-}
nelJsonDecoder: Decoder a -> Decoder (NEL a)
nelJsonDecoder d = list d |> D.andThen(\l -> case NEL.fromList l of
        Just nel -> D.succeed nel
        Nothing -> D.fail "should be nonempty list"
    )