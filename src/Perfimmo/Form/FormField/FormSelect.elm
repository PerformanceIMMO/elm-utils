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

import Perfimmo.Form.FormField.Common exposing (FormFieldInfo, formFieldComparable)
import List.Extra as ListE



{-| FormSelect
-}
type FormSelect a = FormSelect (Value a) AvailableValues (List FormFieldInfo) (FromStringBuilder a) (ToString a)

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
init: AvailableValues -> (List FormFieldInfo) -> FromStringBuilder a -> ToString a -> FormSelect a
init values infos stringBuilder toString = FormSelect Nothing values infos stringBuilder toString

{-| setValue
-}
setValue: a -> FormSelect a -> FormSelect a
setValue x (FormSelect _ values infos builder toString) = FormSelect (Just x) values infos builder toString

{-| setValues
-}
setValues: AvailableValues -> FormSelect a -> FormSelect a
setValues values (FormSelect val _ infos builder toString) = FormSelect val values infos builder toString

{-| setValueFromS
-}
setValueFromS: String -> FormSelect a -> FormSelect a
setValueFromS s (FormSelect _ values infos builder toString) = case String.trim s of
    "" -> FormSelect Nothing values infos builder toString
    _ -> FormSelect (builder s) values infos builder toString

{-| getSelectValues
-}
getSelectValues: FormSelect a -> (Maybe String, List (String, String))
getSelectValues (FormSelect val values infos _ toString) =
    (Maybe.map toString val, values)

{-| getValue
-}
getValue: FormSelect a -> Maybe a
getValue (FormSelect val _ _ _ _) = val

{-| getStringValue
-}
getStringValue: FormSelect a -> Maybe String
getStringValue (FormSelect val _ _ _ toString) = Maybe.map toString val

{-| addInfo
-}
addInfo: FormFieldInfo -> FormSelect a -> FormSelect a
addInfo info (FormSelect val values infos builder toString) =
    FormSelect val values (infos ++ [info] |> ListE.uniqueBy formFieldComparable) builder toString

{-| removeInfo
-}
removeInfo: FormFieldInfo -> FormSelect a -> FormSelect a
removeInfo info (FormSelect val values infos builder toString) =
    FormSelect val values (ListE.filterNot ((==) info) infos) builder toString

{-| getInfos
-}
getInfos: FormSelect a -> List FormFieldInfo
getInfos (FormSelect _ _ infos _ _) = infos