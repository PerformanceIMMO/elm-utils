module Perfimmo.Form.FormField.FormMultiSelect exposing
    ( FormMultiSelect(..)
    , AvailableValues
    , SelectTag
    , SelectedValues
    , init
    , selectValues
    , update
    , getSelectedValues
    , addInfo
    , removeInfo
    , getInfos
    , view)

{-| FormMultiSelect

@docs FormMultiSelect, AvailableValues, SelectTag, SelectedValues

@docs init

@docs selectValues, update, getSelectedValues

@docs addInfo, removeInfo, getInfos

@docs view
-}

import Html.Styled as Styled
import Multiselect
import Perfimmo.Form.FormField.Common exposing (FormFieldInfo, addFormFieldInfo, initFormFieldInfos, removeFormFieldInfo)


{-| Multiselect DOM backend element
- can search a value
- can select several values
-}
type FormMultiSelect decoration =
    FormMultiSelect
        Multiselect.Model
        (List (FormFieldInfo decoration))
{-        (FromStringBuilder a)
        (ToString a)-}

{-| Values available in the Multiselect
-}
type alias AvailableValues = List (String, String)

{-| Give a name to the Multiselect
-}
type alias SelectTag = String

{-| Values that are selected
-}
type alias SelectedValues = List (String, String)

{-{-| FromStringBuilder
-}
type alias FromStringBuilder a = String -> Maybe a

{-| ToString
-}
type alias ToString a = a -> String-}

{-| initialize the Multiselect

    FormMultiSelect.init [("1", "toto"), ("2", "titi")] "myMultiSelect" [FieldIsMandatory]
-}
init: AvailableValues
    -> SelectTag
    -> (List (FormFieldInfo decoration))
{-    -> FromStringBuilder a
    -> ToString a-}
    -> FormMultiSelect decoration
init values tag infos  = --stringBuilder toString
  let model = Multiselect.initModel values tag Multiselect.Show
  in FormMultiSelect model (initFormFieldInfos infos) --stringBuilder toString

{-{-| setValue
-}
setValue: a -> FormMultiSelect a decoration -> FormMultiSelect a decoration
setValue x (FormSelect _ values infos builder toString) = FormSelect (Just x) values infos builder toString-}

{-| set several values as selected from availables values in the Multiselect

    multiselect = FormMultiSelect.init [("1", "toto"), ("2", "titi")] "myMultiSelect" []
    FormMultiSelect.selectValues [("2", "toto")] multiselect
-}
selectValues: SelectedValues -> FormMultiSelect decoration -> FormMultiSelect decoration
selectValues values (FormMultiSelect model infos) = -- builder toString
    let newModel = Multiselect.populateValues
                    model
                    (Multiselect.getValues model)
                    values
    in FormMultiSelect newModel infos --builder toString

{-| update Multiselect with specific event (tagged as Msg). Should be use with Multiselect.view.

    multiselect = FormMultiSelect.init [("1", "toto"), ("2", "titi")] "myMultiSelect" []
    (newSelect, cmd, out) = FormMultiSelect.update (Multiselect.RemoveItem ("1", "toto")) multiselect
-}
update: Multiselect.Msg
    -> FormMultiSelect decoration
    -> (FormMultiSelect decoration, Cmd Multiselect.Msg, Maybe Multiselect.OutMsg)
update msg (FormMultiSelect model infos ) = --builder toString
    let (newModel, newCmd, out) = Multiselect.update msg model
    in (FormMultiSelect newModel infos, newCmd, out)

{-| getSelectedValues
-}
getSelectedValues: FormMultiSelect decoration -> SelectedValues
getSelectedValues (FormMultiSelect model _) = Multiselect.getSelectedValues model

{-| addInfo
-}
addInfo: FormFieldInfo decoration -> FormMultiSelect decoration -> FormMultiSelect decoration
addInfo info (FormMultiSelect model infos) = --builder toString
    FormMultiSelect model (addFormFieldInfo infos info) --builder toString

{-| removeInfo
-}
removeInfo: FormFieldInfo decoration -> FormMultiSelect decoration -> FormMultiSelect decoration
removeInfo info (FormMultiSelect model infos) = -- builder toString
    FormMultiSelect model (removeFormFieldInfo infos info) --builder toString

{-| getInfos
-}
getInfos: FormMultiSelect decoration -> List (FormFieldInfo decoration)
getInfos (FormMultiSelect _ infos) = infos

{-| give a Html view of the component
-}
view: FormMultiSelect decoration -> Styled.Html Multiselect.Msg
view (FormMultiSelect model _) = Multiselect.view model|> Styled.fromUnstyled

-- TODO gérer les souscriptions
-- TODO configurer comme select simple
-- TODO configurer le nombre d'éléments max et min de la multilist