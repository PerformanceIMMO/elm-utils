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
init: Maybe Date -> List FormFieldInfo -> FormField Date
init = FormField.init

{-| empty
-}
empty: FormField Date
empty = FormField.empty

{-| setValue
-}
setValue: Date -> FormField Date -> FormField Date
setValue = FormField.setValue

{-| setRawDate
-}
setRawDate: String -> FormField Date -> FormField Date
setRawDate rawDate form =
    let val = Date.fromIsoString rawDate |> R.toMaybe
    in FormField.init val (FormField.getInfos form)