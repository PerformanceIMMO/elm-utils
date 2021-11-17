module Perfimmo.Http.RestAPIUtils exposing
    ( SeqAPIResult
    , CRUDResult
    , seqAPIResultJsonDecoder
    , crudResultJsonDecoder
    )

{-| RestAPIUtils

@docs  SeqAPIResult, CRUDResult, seqAPIResultJsonDecoder, crudResultJsonDecoder
-}

import Json.Decode as D exposing (Decoder, list, string)
import Json.Decode.Pipeline exposing (required)
import Perfimmo.Http.RestNavigationLink exposing (RestNavigationLink)
import Perfimmo.Http.RestNavigationLinkDecoder exposing (restNavigationLinkDecoder)

{-| SeqAPIResult
-}
type alias SeqAPIResult a = { result: List a , links: List RestNavigationLink}

{-| CRUDResult
-}
type alias CRUDResult = { uid: String }

{-| seqAPIResultJsonDecoder
-}
seqAPIResultJsonDecoder : Decoder a -> Decoder (SeqAPIResult a)
seqAPIResultJsonDecoder decoder = D.succeed SeqAPIResult
    |> required "result" (list decoder)
    |> required "_links" (list restNavigationLinkDecoder)

{-| crudResultJsonDecoder
-}
crudResultJsonDecoder : Decoder CRUDResult
crudResultJsonDecoder = D.succeed CRUDResult
    |> required "uid" string

