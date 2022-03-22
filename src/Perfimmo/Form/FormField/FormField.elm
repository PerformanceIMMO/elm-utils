module Perfimmo.Form.FormField.FormField exposing
    ( FormField
    , init
    , setValue
    , removeInfo
    , addInfo
    , empty
    , getValue
    , getInfos
    , setValueFromS
    )

{-| type de base d'un champ de formulaire (String, Date, ...)

@docs FormField

@docs init, empty

@docs setValue, setValueFromS, getValue

@docs addInfo, removeInfo, getInfos
-}

import Perfimmo.Form.FormField.Common exposing (FormFieldInfo, formFieldComparable)
import List.Extra as ListE


{-| FormField
-}
type FormField a = FormField (Maybe a) (List FormFieldInfo)

{-| init
-}
init: Maybe a -> List FormFieldInfo -> FormField a
init val infos = FormField val infos

{-| empty
-}
empty: FormField a
empty = FormField Nothing []

{-| setValue
-}
setValue: a -> FormField a -> FormField a
setValue val (FormField _ infos) = FormField (Just val) infos

{-| setValueForS
-}
setValueFromS: String -> FormField String -> FormField String
setValueFromS val (FormField _ infos) =
    let nonemptycheckedVal = if String.isEmpty val then Nothing else Just val
    in FormField nonemptycheckedVal infos

{-| getValue
-}
getValue: FormField a -> Maybe a
getValue (FormField val _) = val

{-| addInfo
-}
addInfo: FormFieldInfo -> FormField a -> FormField a
addInfo info (FormField val infos) = FormField val (infos ++ [info] |> ListE.uniqueBy formFieldComparable)

{-| removeInfo
-}
removeInfo: FormFieldInfo -> FormField a -> FormField a
removeInfo info (FormField val infos) = FormField val (ListE.filterNot ((==) info) infos)

{-| getInfos
-}
getInfos: FormField a -> List FormFieldInfo
getInfos (FormField _ infos) = infos