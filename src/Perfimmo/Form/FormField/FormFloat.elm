module Perfimmo.Form.FormField.FormFloat exposing
    ( FormFloat
    , setValueFromS
    , setValue
    , toString
    , toFloat
    , addInfo
    , removeInfo
    , getInfos
    , empty
    , init
    , add)

{-|
type représentant un Float sous forme de string
pour gérer l'affichage ergonomique sur le formulaire

@docs FormFloat

@docs init, empty

@docs setValue, setValueFromS, toString, toFloat

@docs addInfo, removeInfo, getInfos

@docs add
-}

import Perfimmo.Form.FormField.Common exposing (FormFieldInfo, formFieldComparable)
import List.Extra as ListE


{-| FormFloat
-}
type FormFloat = FormFloat (Maybe Float) String (List FormFieldInfo)

{-| init
-}
init: List FormFieldInfo -> FormFloat
init infos = FormFloat Nothing "" (infos |> ListE.uniqueBy formFieldComparable)

{-| empty
-}
empty: FormFloat
empty = FormFloat Nothing "" []

{-| setValue
-}
setValue: Float -> FormFloat -> FormFloat
setValue float (FormFloat _ _ infos) = FormFloat (Just float) (String.fromFloat float) infos

{-| setValueFromS
-}
setValueFromS: String -> FormFloat -> FormFloat
setValueFromS raw (FormFloat oldFloat oldRaw infos) =
    let neutralFloat = String.replace "," "." raw
        checkFloat = String.toFloat neutralFloat
            |> Maybe.map (\f -> (Just f, raw))
            |> Maybe.withDefault (oldFloat, oldRaw)
        (val, s) = if String.trim raw == "" then (Nothing, "") else checkFloat
    in FormFloat val s infos

{-| toString
-}
toString: FormFloat -> String
toString (FormFloat _ s _) = s

{-| toFloat
-}
toFloat: FormFloat -> Maybe Float
toFloat (FormFloat float _ _) = float

{-| addInfo
-}
addInfo: FormFieldInfo -> FormFloat -> FormFloat
addInfo info (FormFloat float s infos) = FormFloat float s (infos ++ [info] |> ListE.uniqueBy formFieldComparable)

{-| removeInfo
-}
removeInfo: FormFieldInfo -> FormFloat -> FormFloat
removeInfo info (FormFloat float s infos) = FormFloat float s (ListE.filterNot ((==) info) infos)

{-| getInfos
-}
getInfos: FormFloat -> List FormFieldInfo
getInfos (FormFloat _ _ infos) = infos

{-| add
-}
add: FormFloat -> FormFloat -> FormFloat
add (FormFloat f1 _ i1) (FormFloat f2 _ i2) =
    let i = init <| i1 ++ i2
    in case (f1, f2) of
        (Just x, Just y) -> setValue (x + y) i
        (Just x, Nothing) -> setValue x i
        (Nothing, Just x) -> setValue x i
        (Nothing, Nothing) -> i
