module Perfimmo.Primitive.BoolUtils exposing
    ( bool2StringFr
    )

bool2StringFr bool = case bool of
    True -> "Vrai"
    False -> "Faux"