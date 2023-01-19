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
type FormDatalist a decoration = FormDatalist (FormSelect (ValueState a) decoration)

{-|
indique le statut de la saisie :
- ChosenItem ->  j'ai cliqué sur une valeur de la liste déroulante
- InputSearch -> je suis en train de tapé ma recherche pour trouver la bonne valeur
-}
type ValueState a = ChosenItem a | InputSearch String

{-| init
-}
init: List String -> List (FormFieldInfo decoration) -> FromStringBuilder a -> ToString a -> FormDatalist a decoration
init values infos stringBuilder toString =
    let tupledValues = List.map (\x -> (x, x)) values
        dlFromStringBuilder = builder values stringBuilder
        dlToSring = toStringV toString
    in FormDatalist <| FormSelect.init tupledValues infos dlFromStringBuilder dlToSring

{-| setValue
-}
setValue: a -> FormDatalist a decoration -> FormDatalist a decoration
setValue x (FormDatalist select) = FormDatalist <| FormSelect.setValue (ChosenItem x) select

-- TODO si setValues, change FromStringBuilder & ToString
{-setValues: AvailableValues -> FormDatalist a -> FormDatalist a
setValues values (FormDatalist select) = FormDatalist <| FormSelect.setValues values select-}

{-| setValueFromS
-}
setValueFromS: String -> FormDatalist a decoration -> FormDatalist a decoration
setValueFromS raw (FormDatalist select) = FormDatalist <| FormSelect.setValueFromS raw select

{-| getValue
-}
getValue: FormDatalist a decoration -> Maybe (ValueState a)
getValue (FormDatalist select) = FormSelect.getValue select

{-| getSelectValues
-}
getSelectValues: FormDatalist a decoration -> (Maybe (ValueState String), List String)
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
getStringValue: FormDatalist a decoration -> Maybe String
getStringValue (FormDatalist select) = FormSelect.getStringValue select

{-| addInfo
-}
addInfo: (FormFieldInfo decoration) -> FormDatalist a decoration -> FormDatalist a decoration
addInfo info (FormDatalist select) = FormDatalist <| FormSelect.addInfo info select

{-| removeInfo
-}
removeInfo: (FormFieldInfo decoration) -> FormDatalist a decoration -> FormDatalist a decoration
removeInfo info (FormDatalist select) = FormDatalist <| FormSelect.removeInfo info select

{-| getInfos
-}
getInfos: FormDatalist a decoration -> List (FormFieldInfo decoration)
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
