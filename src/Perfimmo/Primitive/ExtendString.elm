module Perfimmo.Primitive.ExtendString exposing
    (maybeStringToMaybeNonEmptyString, stringToNonEmptyString)

{-| ExtendString

@docs maybeStringToMaybeNonEmptyString, stringToNonEmptyString
-}


{-| maybeStringToMaybeNonEmptyString
-}
maybeStringToMaybeNonEmptyString: Maybe String -> Maybe String
maybeStringToMaybeNonEmptyString maybe =
    case maybe of
        Just s -> stringToNonEmptyString s
        Nothing -> Nothing

{-| stringToNonEmptyString
-}
stringToNonEmptyString: String -> Maybe String
stringToNonEmptyString s =
    case s of
        "" -> Nothing
        _ -> Just s