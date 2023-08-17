module Perfimmo.Primitive.NonBlankString exposing (append, fromString, toString, NonBlankString)

{-| NonBlankString

@docs fromString, toString, NonBlankString, append

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
