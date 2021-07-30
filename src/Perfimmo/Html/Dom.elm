module Perfimmo.Html.Dom exposing
    ( onClick_stopProp
    , buildOptions
    )

{-
Handle event propagation
-}

import Html.Styled.Events exposing (stopPropagationOn)
import Json.Decode as Decode exposing (Decoder)
import Html.Styled exposing (Html, option, text)
import Html.Styled.Attributes exposing (id, selected, value)

onClick_stopProp: msg -> Html.Styled.Attribute msg
onClick_stopProp msg = stopPropagationOn "click" (Decode.succeed (msg,True))

buildOptions : Maybe String -> List (String, String) -> List (Html msg)
buildOptions value values =
    (Maybe.map (always []) value
        |> Maybe.withDefault [option [] [text "Choisir une valeur"]]) ++ List.map (buildOption value) values

buildOption : Maybe String -> (String, String) -> Html msg
buildOption v0 (id, nom) =
    option
        [ value id
        , selected ((Maybe.map ((==) id) v0) |> Maybe.withDefault False)
        ]
        [ text nom ]

