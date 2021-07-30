module Perfimmo.Http.Headers exposing (ContentRange, fieldFromContentRangeHeader)

import Http
import Maybe.FlatMap exposing (flatMap)
import Dict exposing (Dict)
import List.Extra exposing (last)

type alias ContentRange = { {-start: Int, end: Int, -}total: Int }

fieldFromContentRangeHeader : (ContentRange -> Int) -> Http.Metadata -> Int
fieldFromContentRangeHeader f m =
    let contentRangeHeader = Dict.get "content-range" m.headers
    in (flatMap (contentRange >> Maybe.map f) contentRangeHeader) |> Maybe.withDefault 0

contentRange : String -> Maybe ContentRange
contentRange s =
    let
        xs = String.split "/" s
        -- range = (List.head xs |> Maybe.map String.split)
        total = last xs |> flatMap String.toInt
    in
        Maybe.map (\t -> { {-start = 0, end = 0, -}total = t } ) total