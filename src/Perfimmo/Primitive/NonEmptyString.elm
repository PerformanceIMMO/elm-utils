module Perfimmo.Primitive.NonEmptyString exposing (fromString, toString, NonEmptyString, append, prepend)

{-| NonEmptyString

@docs fromString, toString, NonEmptyString, append, prepend

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


{-| prepend
-}
prepend : NonEmptyString -> String -> NonEmptyString
prepend (NonEmptyString nonEmptyString) string =
    NonEmptyString (string ++ nonEmptyString)
