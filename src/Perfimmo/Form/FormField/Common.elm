module Perfimmo.Form.FormField.Common exposing
    ( FormFieldInfo(..)
    , formFieldComparable)

{-| Common

@docs  FormFieldInfo

@docs formFieldComparable
-}

{-| FormFieldInfo
-}
type FormFieldInfo =
    FieldIsMandatory

{-| formFieldComparable
-}
formFieldComparable: FormFieldInfo -> String
formFieldComparable f = case f of
    FieldIsMandatory -> "FieldIsMandatory"