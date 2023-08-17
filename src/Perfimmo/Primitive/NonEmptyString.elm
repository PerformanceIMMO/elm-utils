module Perfimmo.Primitive.NonEmptyString exposing (fromString, toString, NonEmptyString, append)

{-| NonEmptyString

@docs fromString, toString, NonEmptyString, append

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


{-| append
-}
append : NonEmptyString -> String -> NonEmptyString
append (NonEmptyString nonEmptyString) string =
    NonEmptyString (nonEmptyString ++ string)
