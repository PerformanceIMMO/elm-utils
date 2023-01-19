module Perfimmo.Form.FormField.FormPourcent exposing
    ( FormPourcent
    , setValueFromS
    , setValue
    , toString
    , toFloat
    , init
    , empty
    , addInfo
    , removeInfo
    , getInfos
    )

{-|
type représentant un Pourcentage sous forme de string
pour gérer l'affichage ergonomique sur le formulaire

@docs FormPourcent

@docs init, empty

@docs setValue, setValueFromS, toString, toFloat

@docs addInfo, removeInfo, getInfos

-}

import Perfimmo.Form.FormField.Common exposing (FormFieldInfo, addFormFieldInfo, initFormFieldInfos, removeFormFieldInfo)
import Perfimmo.Form.FormField.FormFloat as FormFloat


{-| FormPourcent
-}
type FormPourcent decoration = FormPourcent (Maybe Float) String (List (FormFieldInfo decoration))

{-| init
-}
init: List (FormFieldInfo decoration) -> FormPourcent decoration
init infos = FormPourcent Nothing "" (initFormFieldInfos infos)

{-| empty
-}
empty: FormPourcent decoration
empty = FormPourcent Nothing "" []

{-| setValue
-}
setValue: Float -> FormPourcent decoration -> FormPourcent decoration
setValue float form = testPourcent (String.fromFloat float) form float

{-| setValueFromS
-}
setValueFromS: String -> FormPourcent decoration -> FormPourcent decoration
setValueFromS raw form =
    let (FormPourcent _ _ infos) = form
        update = FormFloat.init infos
            |> FormFloat.setValueFromS raw
            |> FormFloat.toFloat
            |> Maybe.map (testPourcent raw form)
            |> Maybe.withDefault form
    in if raw == "" then FormPourcent Nothing "" infos else update

{-| toString
-}
toString: FormPourcent decoration -> String
toString (FormPourcent _ s _) = s

{-| toFloat
-}
toFloat: FormPourcent decoration -> Maybe Float
toFloat (FormPourcent v _ _) = v

{-| addInfo
-}
addInfo: FormFieldInfo decoration -> FormPourcent decoration -> FormPourcent decoration
addInfo info (FormPourcent float s infos) = FormPourcent float s (addFormFieldInfo infos info)

{-| removeInfo
-}
removeInfo: FormFieldInfo decoration -> FormPourcent decoration -> FormPourcent decoration
removeInfo info (FormPourcent float s infos) = FormPourcent float s (removeFormFieldInfo infos info)

{-| getInfos
-}
getInfos: FormPourcent decoration -> List (FormFieldInfo decoration)
getInfos (FormPourcent _ _ infos) = infos

testPourcent raw (FormPourcent oldFloat oldRaw info) float =
    if 0 <= float && float <= 100 then FormPourcent (Just float) raw info
    else FormPourcent oldFloat oldRaw info