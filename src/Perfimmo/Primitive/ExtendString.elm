module Perfimmo.Primitive.ExtendString exposing (..)

maybeStringToMaybeNonEmptyString: Maybe String -> Maybe String
maybeStringToMaybeNonEmptyString maybe =
    case maybe of
        Just s -> stringToNonEmptyString s
        Nothing -> Nothing

stringToNonEmptyString: String -> Maybe String
stringToNonEmptyString s =
    case s of
        "" -> Nothing
        _ -> Just s