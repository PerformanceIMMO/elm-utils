module Perfimmo.Form.FormField.FormDate exposing
    ( init
    , empty
    , setValue
    , setRawDate)

{-| Utilitaire a FormField pour Date

@docs init, empty, setValue, setRawDate
-}

import Perfimmo.Form.FormField.Common exposing (FormFieldInfo)
import Perfimmo.Form.FormField.FormField as FormField exposing (FormField)
import Date exposing (Date)
import Result as R

{-| init
-}
init: Maybe Date -> List (FormFieldInfo decoration) -> FormField Date decoration
init = FormField.init

{-| empty
-}
empty: FormField Date decoration
empty = FormField.empty

{-| setValue
-}
setValue: Date -> FormField Date decoration -> FormField Date decoration
setValue = FormField.setValue

{-| setRawDate
-}
setRawDate: String -> FormField Date decoration -> FormField Date decoration
setRawDate rawDate form =
    let val = Date.fromIsoString rawDate |> R.toMaybe
    in FormField.init val (FormField.getInfos form)