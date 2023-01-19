module Perfimmo.Form.FormField.FormSelect exposing
    ( FormSelect
    , AvailableValues
    , FromStringBuilder
    , ToString
    , init
    , setValue
    , setValues
    , setValueFromS
    , getSelectValues
    , getValue
    , getStringValue
    , addInfo
    , removeInfo
    , getInfos
    )

{-| FormSelect

@docs FormSelect, AvailableValues, FromStringBuilder, ToString

@docs init

@docs setValue, setValues, setValueFromS, getSelectValues, getValue, getStringValue

@docs addInfo, removeInfo, getInfos
-}

import Perfimmo.Form.FormField.Common exposing (FormFieldInfo, addFormFieldInfo, initFormFieldInfos, removeFormFieldInfo)



{-| FormSelect
-}
type FormSelect a decoration = FormSelect (Value a) AvailableValues (List (FormFieldInfo decoration)) (FromStringBuilder a) (ToString a)

{-| Value
-}
type alias Value a = (Maybe a)

{-| AvailableValues
-}
type alias AvailableValues = List (String, String)

{-| FromStringBuilder
-}
type alias FromStringBuilder a = String -> Maybe a

{-| ToString
-}
type alias ToString a = a -> String

{-| init
-}
init: AvailableValues -> (List (FormFieldInfo decoration)) -> FromStringBuilder a -> ToString a -> FormSelect a decoration
init values infos stringBuilder toString = FormSelect Nothing values (initFormFieldInfos infos) stringBuilder toString

{-| setValue
-}
setValue: a -> FormSelect a decoration -> FormSelect a decoration
setValue x (FormSelect _ values infos builder toString) = FormSelect (Just x) values infos builder toString

{-| setValues
-}
setValues: AvailableValues -> FormSelect a decoration -> FormSelect a decoration
setValues values (FormSelect val _ infos builder toString) = FormSelect val values infos builder toString

{-| setValueFromS
-}
setValueFromS: String -> FormSelect a decoration -> FormSelect a decoration
setValueFromS s (FormSelect _ values infos builder toString) = case String.trim s of
    "" -> FormSelect Nothing values infos builder toString
    _ -> FormSelect (builder s) values infos builder toString

{-| getSelectValues
-}
getSelectValues: FormSelect a decoration -> (Maybe String, List (String, String))
getSelectValues (FormSelect val values infos _ toString) =
    (Maybe.map toString val, values)

{-| getValue
-}
getValue: FormSelect a decoration -> Maybe a
getValue (FormSelect val _ _ _ _) = val

{-| getStringValue
-}
getStringValue: FormSelect a decoration -> Maybe String
getStringValue (FormSelect val _ _ _ toString) = Maybe.map toString val

{-| addInfo
-}
addInfo: FormFieldInfo decoration -> FormSelect a decoration -> FormSelect a decoration
addInfo info (FormSelect val values infos builder toString) =
    FormSelect val values (addFormFieldInfo infos info) builder toString

{-| removeInfo
-}
removeInfo: FormFieldInfo decoration -> FormSelect a decoration -> FormSelect a decoration
removeInfo info (FormSelect val values infos builder toString) =
    FormSelect val values (removeFormFieldInfo infos info) builder toString

{-| getInfos
-}
getInfos: FormSelect a decoration -> List (FormFieldInfo decoration)
getInfos (FormSelect _ _ infos _ _) = infos