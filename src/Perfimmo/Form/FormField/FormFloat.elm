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

import Decimal
import Perfimmo.Form.FormField.Common exposing (FormFieldInfo, addFormFieldInfo, initFormFieldInfos, removeFormFieldInfo)


{-| FormFloat
-}
type FormFloat decoration = FormFloat (Maybe Float) String (List (FormFieldInfo decoration))

{-| init
-}
init: List (FormFieldInfo decoration) -> FormFloat decoration
init infos = FormFloat Nothing "" (initFormFieldInfos infos)

{-| empty
-}
empty: FormFloat decoration
empty = FormFloat Nothing "" []

{-| setValue
-}
setValue: Float -> FormFloat decoration -> FormFloat decoration
setValue float (FormFloat _ _ infos) = FormFloat (Just float) (String.fromFloat float) infos

{-| setValueFromS
-}
setValueFromS: String -> FormFloat decoration -> FormFloat decoration
setValueFromS raw (FormFloat oldFloat oldRaw infos) =
    let neutralFloat = String.replace "," "." raw
        checkFloat = String.toFloat neutralFloat
            |> Maybe.map (\f -> (Just f, raw))
            |> Maybe.withDefault (oldFloat, oldRaw)
        (val, s) = if String.trim raw == "" then (Nothing, "") else checkFloat
    in FormFloat val s infos

{-| toString
-}
toString: FormFloat decoration -> String
toString (FormFloat _ s _) = s

{-| toFloat
-}
toFloat: FormFloat decoration -> Maybe Float
toFloat (FormFloat float _ _) = float

{-| addInfo
-}
addInfo: FormFieldInfo decoration -> FormFloat decoration -> FormFloat decoration
addInfo info (FormFloat float s infos) = FormFloat float s (addFormFieldInfo infos info)

{-| removeInfo
-}
removeInfo: FormFieldInfo decoration -> FormFloat decoration -> FormFloat decoration
removeInfo info (FormFloat float s infos) = FormFloat float s (removeFormFieldInfo infos info)

{-| getInfos
-}
getInfos: FormFloat decoration -> List (FormFieldInfo decoration)
getInfos (FormFloat _ _ infos) = infos

{-| add
-}
add: FormFloat decoration -> FormFloat decoration -> FormFloat decoration
add (FormFloat f1 _ i1) (FormFloat f2 _ i2) =
    let i = init <| i1 ++ i2
    in case (f1, f2) of
        (Just x, Just y) ->
            let d1 = Decimal.fromFloat x
                d2 = Decimal.fromFloat y
            in Maybe.map2 Decimal.add d1 d2
                |> Maybe.map (\v -> setValue (Decimal.toFloat v) i)
                |> Maybe.withDefault (setValue (x + y) i)

        (Just x, Nothing) -> setValue x i
        (Nothing, Just x) -> setValue x i
        (Nothing, Nothing) -> i
