module Perfimmo.Html.Dom exposing
    ( onClick_stopProp
    , buildOptions
    , selectViewOptions, selectView, datalistView)

{-| Handle event propagation

@docs onClick_stopProp

@docs selectView, buildOptions

@docs selectViewOptions

@docs datalistView
-}

import Html.Styled.Events exposing (onInput, stopPropagationOn)
import Json.Decode as Decode exposing (Decoder)
import Html.Styled exposing (Html, datalist, div, input, option, select, text)
import Html.Styled.Attributes exposing (id, list, selected, type_, value)

{-| onClick_stopProp
-}
onClick_stopProp: msg -> Html.Styled.Attribute msg
onClick_stopProp msg = stopPropagationOn "click" (Decode.succeed (msg,True))

{-| buildOptions
-}
buildOptions : Maybe String -> List (String, String) -> List (Html msg)
buildOptions value values =
    (Maybe.map (always []) value
        |> Maybe.withDefault [option [] [text "Choisir une valeur"]]) ++ List.map (buildOption value) values

{-| selectView
-}
selectView : (String -> msg) -> List (Html msg) -> Html msg
selectView msg = select [ onInput msg ]

{-| selectViewOptions
-}
selectViewOptions : (String -> msg) -> Maybe String -> List (String, String) -> Html msg
selectViewOptions msg value values = selectView msg <| buildOptions value values

buildOption : Maybe String -> (String, String) -> Html msg
buildOption v0 (id, nom) =
    option
        [ value id
        , selected ((Maybe.map ((==) id) v0) |> Maybe.withDefault False)
        ]
        [ text nom ]

{-| datalistView
-}
datalistView: (String -> msg) -> String -> (List String) -> Maybe String -> Html msg
datalistView msg listid elements currentValue = div []
    [ input [ onInput msg, list listid, type_ "text", value <| Maybe.withDefault "" currentValue ] []
    , datalist [ id listid ]
        <| buildOptionsDatalist elements
    ]

buildOptionsDatalist : List String -> List (Html msg)
buildOptionsDatalist list =
    let mapOption l = option [value l] []
    in (++) [option [] []]
        <| List.map mapOption list