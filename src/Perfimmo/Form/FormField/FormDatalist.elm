module Perfimmo.Form.FormField.FormDatalist exposing
    ( FormDatalist
    , ValueState(..)
    , init
    , setValue
    , setValueFromS
    , getValue
    , addInfo
    , removeInfo
    , getStringValue
    , getInfos
    , getSelectValues
    )

{-| Entité représentant une datalist dans un formulaire
    marche avec la fonction datalistForm. La spécificité de la datalist c'est qu'elle retourne la valeur affichée
    alors qu'un select retourne l'identifiant associé à la valeur.

@docs FormDatalist, ValueState

@docs init

@docs setValue, setValueFromS

@docs getValue, getSelectValues, getStringValue

@docs addInfo, removeInfo, getInfos
-}

import Perfimmo.Form.FormField.Common exposing (FormFieldInfo)
import Perfimmo.Form.FormField.FormSelect as FormSelect exposing (AvailableValues, FormSelect, FromStringBuilder, ToString)
import List.Extra as ListE
import Maybe.Extra as MaybeE
import Maybe.FlatMap as MaybeF


{-| FormDatalist
-}
type FormDatalist a = FormDatalist (FormSelect (ValueState a))

{-|
indique le statut de la saisie :
- ChosenItem ->  j'ai cliqué sur une valeur de la liste déroulante
- InputSearch -> je suis en train de tapé ma recherche pour trouver la bonne valeur
-}
type ValueState a = ChosenItem a | InputSearch String

{-| init
-}
init: List String -> List FormFieldInfo -> FromStringBuilder a -> ToString a -> FormDatalist a
init values infos stringBuilder toString =
    let tupledValues = List.map (\x -> (x, x)) values
        dlFromStringBuilder = builder values stringBuilder
        dlToSring = toStringV toString
    in FormDatalist <| FormSelect.init tupledValues infos dlFromStringBuilder dlToSring

{-| setValue
-}
setValue: a -> FormDatalist a -> FormDatalist a
setValue x (FormDatalist select) = FormDatalist <| FormSelect.setValue (ChosenItem x) select

-- TODO si setValues, change FromStringBuilder & ToString
{-setValues: AvailableValues -> FormDatalist a -> FormDatalist a
setValues values (FormDatalist select) = FormDatalist <| FormSelect.setValues values select-}

{-| setValueFromS
-}
setValueFromS: String -> FormDatalist a -> FormDatalist a
setValueFromS raw (FormDatalist select) = FormDatalist <| FormSelect.setValueFromS raw select

{-| getValue
-}
getValue: FormDatalist a -> Maybe (ValueState a)
getValue (FormDatalist select) = FormSelect.getValue select

{-| getSelectValues
-}
getSelectValues: FormDatalist a -> (Maybe (ValueState String), List String)
getSelectValues (FormDatalist select) =
    let (x, values) = FormSelect.getSelectValues select
        state = case getValue (FormDatalist select) of
            Just (ChosenItem _) -> Maybe.map ChosenItem x
            Just (InputSearch i) -> Just <| InputSearch i
            Nothing -> Nothing
        untupledValues = List.map Tuple.first values

    in (state, untupledValues)

{-| getStringValue
-}
getStringValue: FormDatalist a -> Maybe String
getStringValue (FormDatalist select) = FormSelect.getStringValue select

{-| addInfo
-}
addInfo: FormFieldInfo -> FormDatalist a -> FormDatalist a
addInfo info (FormDatalist select) = FormDatalist <| FormSelect.addInfo info select

{-| removeInfo
-}
removeInfo: FormFieldInfo -> FormDatalist a -> FormDatalist a
removeInfo info (FormDatalist select) = FormDatalist <| FormSelect.removeInfo info select

{-| getInfos
-}
getInfos: FormDatalist a -> List FormFieldInfo
getInfos (FormDatalist select) = FormSelect.getInfos select

builder: List String -> FromStringBuilder a -> FromStringBuilder (ValueState a)
builder values f = (\raw ->
        ListE.find ((==) raw) values
            |> MaybeF.flatMap f
            |> Maybe.map ChosenItem
            |> MaybeE.orElse (Just <| InputSearch raw)
    )

toStringV: ToString a -> ToString (ValueState a)
toStringV f = (\state -> case state of
        ChosenItem x -> f x
        InputSearch x -> ""
    )
