module Perfimmo.Json.Json exposing (cleanJson)

import Json.Value exposing (..)
import Tuple exposing (second)

type alias ValueToUpate = JsonValue
type alias Path = List String
type alias PathValue = JsonValue

cleanJson: JsonValue -> JsonValue
cleanJson json =
    case json of
        ObjectValue [] -> NullValue
        NullValue -> NullValue
        ArrayValue [] -> NullValue
                
        ObjectValue list ->
            let rec = List.map (\(k, v) -> (k, cleanJson v)) list
                erased = List.filter (second >> isNull >> not) rec

            in if List.isEmpty erased then NullValue else ObjectValue erased
        ArrayValue jsonValues ->
            let rec = List.map cleanJson jsonValues
                erased = List.filter (isNull >> not) rec

            in if List.isEmpty erased then NullValue else ArrayValue erased

        StringValue s -> if isBlank s then NullValue else json

        BoolValue _ -> json
        NumericValue _ -> json


isNull: JsonValue -> Bool
isNull json =
    case json of
        NullValue -> True
        _ -> False

isBlank = (String.trim >> String.isEmpty)