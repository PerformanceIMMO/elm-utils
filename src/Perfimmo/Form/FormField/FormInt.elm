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

import Perfimmo.Form.FormField.Common exposing (FormFieldInfo, formFieldComparable)
import List.Extra as ListE

{-| FormInt
-}
type FormInt = FormInt (Maybe Int) String (List FormFieldInfo)

{-| init
-}
init: List FormFieldInfo -> FormInt
init infos = FormInt Nothing "" (infos |> ListE.uniqueBy formFieldComparable)

{-| empty
-}
empty: FormInt
empty = FormInt Nothing "" []

{-| setValue
-}
setValue: Int -> FormInt -> FormInt
setValue int (FormInt _ _ infos) = FormInt (Just int) (String.fromInt int) infos

{-| setValueFromS
-}
setValueFromS: String -> FormInt -> FormInt
setValueFromS raw (FormInt oldInt oldRaw infos) =
    let checkInt = String.toInt raw
            |> Maybe.map (\i -> (Just i, raw))
            |> Maybe.withDefault (oldInt, oldRaw)
        (val, s) = if String.trim raw == "" then (Nothing, "") else checkInt
    in FormInt val s infos

{-| toString
-}
toString: FormInt -> String
toString (FormInt _ s _) = s

{-| toInt
-}
toInt: FormInt -> Maybe Int
toInt (FormInt int _ _) = int

{-| getInfos
-}
getInfos: FormInt -> List FormFieldInfo
getInfos (FormInt _ _ infos) = infos