module Perfimmo.Primitive.NonBlankString exposing (fromString, toString)

{-| NonBlankString

@docs fromString, toString

-}

import Perfimmo.Primitive.ExtendString exposing (stringToNonEmptyString)


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
