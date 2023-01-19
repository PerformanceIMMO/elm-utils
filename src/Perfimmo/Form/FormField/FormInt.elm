module Perfimmo.Form.FormField.FormInt exposing
    ( FormInt
    , init
    , empty
    , setValue
    , getInfos
    , toInt
    , toString
    , setValueFromS
    )

{-|
type représentant un Int sous forme de string
pour gérer l'affichage ergonomique sur le formulaire

@docs FormInt

@docs init, empty

@docs setValue, setValueFromS, toString, toInt

@docs getInfos
-}

import Perfimmo.Form.FormField.Common exposing (FormFieldInfo, initFormFieldInfos)

{-| FormInt
-}
type FormInt decoration = FormInt (Maybe Int) String (List (FormFieldInfo decoration))

{-| init
-}
init: List (FormFieldInfo decoration) -> FormInt decoration
init infos = FormInt Nothing "" (initFormFieldInfos infos)

{-| empty
-}
empty: FormInt decoration
empty = FormInt Nothing "" []

{-| setValue
-}
setValue: Int -> FormInt decoration -> FormInt decoration
setValue int (FormInt _ _ infos) = FormInt (Just int) (String.fromInt int) infos

{-| setValueFromS
-}
setValueFromS: String -> FormInt decoration -> FormInt decoration
setValueFromS raw (FormInt oldInt oldRaw infos) =
    let checkInt = String.toInt raw
            |> Maybe.map (\i -> (Just i, raw))
            |> Maybe.withDefault (oldInt, oldRaw)
        (val, s) = if String.trim raw == "" then (Nothing, "") else checkInt
    in FormInt val s infos

{-| toString
-}
toString: FormInt decoration -> String
toString (FormInt _ s _) = s

{-| toInt
-}
toInt: FormInt decoration -> Maybe Int
toInt (FormInt int _ _) = int

{-| getInfos
-}
getInfos: FormInt decoration -> List (FormFieldInfo decoration)
getInfos (FormInt _ _ infos) = infos