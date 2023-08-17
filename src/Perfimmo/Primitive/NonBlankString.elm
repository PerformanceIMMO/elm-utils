module Perfimmo.Primitive.NonBlankString exposing (append, prepend, fromString, toString, NonBlankString)

{-| NonBlankString

@docs fromString, toString, NonBlankString, append, prepend

-}

import Perfimmo.Primitive.ExtendString exposing (stringToNonEmptyString)

{-| NonBlankString
-}
type NonBlankString
    = NonBlankString String


{-| fromString
-}
fromString : String -> Maybe NonBlankString
fromString input =
    String.trim input
        |> stringToNonEmptyString
        |> Maybe.map (\_ -> NonBlankString input)


{-| toString
-}
toString : NonBlankString -> String
toString (NonBlankString input) =
    input

{-| append
-}
append : NonBlankString -> String -> NonBlankString
append (NonBlankString nonBlankString) string = NonBlankString (nonBlankString ++ string)

{-| prepend
-}
prepend : NonBlankString -> String -> NonBlankString
prepend (NonBlankString nonBlankString) string = NonBlankString (string ++ nonBlankString)
