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

import Perfimmo.Form.FormField.Common exposing (FormFieldInfo, formFieldComparable)
import Perfimmo.Form.FormField.FormFloat as FormFloat
import List.Extra as ListE


{-| FormPourcent
-}
type FormPourcent = FormPourcent (Maybe Float) String (List FormFieldInfo)

{-| init
-}
init: List FormFieldInfo -> FormPourcent
init infos = FormPourcent Nothing "" infos

{-| empty
-}
empty: FormPourcent
empty = FormPourcent Nothing "" []

{-| setValue
-}
setValue: Float -> FormPourcent -> FormPourcent
setValue float form = testPourcent (String.fromFloat float) form float

{-| setValueFromS
-}
setValueFromS: String -> FormPourcent -> FormPourcent
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
toString: FormPourcent -> String
toString (FormPourcent _ s _) = s

{-| toFloat
-}
toFloat: FormPourcent -> Maybe Float
toFloat (FormPourcent v _ _) = v

{-| addInfo
-}
addInfo: FormFieldInfo -> FormPourcent -> FormPourcent
addInfo info (FormPourcent float s infos) = FormPourcent float s (infos ++ [info] |> ListE.uniqueBy formFieldComparable)

{-| removeInfo
-}
removeInfo: FormFieldInfo -> FormPourcent -> FormPourcent
removeInfo info (FormPourcent float s infos) = FormPourcent float s (ListE.filterNot ((==) info) infos)

{-| getInfos
-}
getInfos: FormPourcent -> List FormFieldInfo
getInfos (FormPourcent _ _ infos) = infos

testPourcent raw (FormPourcent oldFloat oldRaw info) float =
    if 0 <= float && float <= 100 then FormPourcent (Just float) raw info
    else FormPourcent oldFloat oldRaw info