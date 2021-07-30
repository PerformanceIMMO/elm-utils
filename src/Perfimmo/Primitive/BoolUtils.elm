module Perfimmo.Primitive.BoolUtils exposing
    ( bool2StringFr
    )

{-| BoolUtils

@docs bool2StringFr
-}


{-| bool2StringFr
-}
bool2StringFr : Bool -> String
bool2StringFr bool = case bool of
    True -> "Vrai"
    False -> "Faux"