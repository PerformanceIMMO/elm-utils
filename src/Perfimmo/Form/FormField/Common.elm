module Perfimmo.Form.FormField.Common exposing
    ( FormFieldInfo(..)
    , formFieldComparable
    , initFormFieldInfos
    , addFormFieldInfo
    , removeFormFieldInfo
    , SubComparator
    )

{-| Common

@docs  FormFieldInfo

@docs formFieldComparable

@docs initFormFieldInfos

@docs addFormFieldInfo

@docs removeFormFieldInfo

@docs SubComparator
-}

import List.Extra as ListE

{-| Add info to your field that you will could use to decorate it after

    type FormFieldInfo decoration =
        -- the field is mandatory
        FieldIsMandatory
        -- Allow to add custom decoration to field.
        | CustomDecorator decoration (SubComparator decoration)
-}

type FormFieldInfo decoration =
    FieldIsMandatory
    | CustomDecorator decoration (SubComparator decoration)

{-| formFieldComparable
-}
formFieldComparable: FormFieldInfo decoration -> String
formFieldComparable f = case f of
    FieldIsMandatory -> "FieldIsMandatory"
    CustomDecorator x comparable -> "CustomDecorator_" ++ comparable x

{-| initFormFieldInfos
-}
initFormFieldInfos: List (FormFieldInfo decoration) -> List (FormFieldInfo decoration)
initFormFieldInfos infos = (infos |> ListE.uniqueBy formFieldComparable)

{-| addFormFieldInfo
-}
addFormFieldInfo: List (FormFieldInfo decoration) -> FormFieldInfo decoration -> List (FormFieldInfo decoration)
addFormFieldInfo existing infoToAdd = (existing ++ [infoToAdd] |> ListE.uniqueBy formFieldComparable)

{-| removeFormFieldInfo
-}
removeFormFieldInfo: List (FormFieldInfo decoration) -> FormFieldInfo decoration -> List (FormFieldInfo decoration)
removeFormFieldInfo existing infoToRemove = ListE.filterNot (\i -> formFieldComparable i == formFieldComparable infoToRemove) existing

{-| a function that allow to compare decorator (cf. `formFieldComparable`) between them.
    Useful to {add, remove} `FormFieldInfo decoration` {to,from} field.
-}
type alias SubComparator a = (a -> String)