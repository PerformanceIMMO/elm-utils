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

import Perfimmo.Form.FormField.Common exposing (FormFieldInfo, addFormFieldInfo, initFormFieldInfos, removeFormFieldInfo)


{-| FormField
-}
type FormField a decoration = FormField (Maybe a) (List (FormFieldInfo decoration))

{-| init
-}
init: Maybe a -> List (FormFieldInfo decoration) -> FormField a decoration
init val infos = FormField val (initFormFieldInfos infos)

{-| empty
-}
empty: FormField a decoration
empty = FormField Nothing []

{-| setValue
-}
setValue: a -> FormField a decoration -> FormField a decoration
setValue val (FormField _ infos) = FormField (Just val) infos

{-| setValueForS
-}
setValueFromS: String -> FormField String decoration -> FormField String decoration
setValueFromS val (FormField _ infos) =
    let nonemptycheckedVal = if String.isEmpty val then Nothing else Just val
    in FormField nonemptycheckedVal infos

{-| getValue
-}
getValue: FormField a decoration -> Maybe a
getValue (FormField val _) = val

{-| addInfo
-}
addInfo: FormFieldInfo decoration -> FormField a decoration -> FormField a decoration
addInfo infoToAdd (FormField val infos) = FormField val (addFormFieldInfo infos infoToAdd)

{-| removeInfo
-}
removeInfo: FormFieldInfo decoration -> FormField a decoration -> FormField a decoration
removeInfo infoToRemove (FormField val infos) =
    FormField val (removeFormFieldInfo infos infoToRemove)

{-| getInfos
-}
getInfos: FormField a decoration -> List (FormFieldInfo decoration)
getInfos (FormField _ infos) = infos