module Perfimmo.Primitive.NonEmptyString exposing (fromString, toString, NonEmptyString)

{-| NonEmptyString

@docs fromString, toString, NonEmptyString

-}

import Perfimmo.Primitive.ExtendString exposing (stringToNonEmptyString)


{-| NonEmptyString
-}
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
