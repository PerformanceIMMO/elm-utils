module Perfimmo.Primitive.NonEmptyString exposing (fromString, toString)

{-| NonEmptyString

@docs fromString, toString

-}

import Perfimmo.Primitive.ExtendString exposing (stringToNonEmptyString)


type NonEmptyString
    = NonEmptyString String


{-| fromString
-}
fromString : String -> Maybe NonEmptyString
fromString input =
    stringToNonEmptyString input |> Maybe.map NonEmptyString


{-| toString
-}
toString : NonEmptyString -> String
toString (NonEmptyString input) =
    input
