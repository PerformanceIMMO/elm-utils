module Perfimmo.Primitive.CharUtils exposing
    ( greaterChar
    , lowerChar
    , greaterOrEqChar
    , lowerOrEqChar
    )

{-| CharUtils

@docs greaterChar, lowerChar, greaterOrEqChar, lowerOrEqChar
-}

{-| greaterChar
-}
greaterChar : String
greaterChar = ">"
{-| lowerChar
-}
lowerChar : String
lowerChar = "<"
{-| greaterOrEqChar
-}
greaterOrEqChar : String
greaterOrEqChar = "\u{2265}"
{-| lowerOrEqChar
-}
lowerOrEqChar : String
lowerOrEqChar = "\u{2264}"