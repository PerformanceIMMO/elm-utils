module Perfimmo.Http.RestNavigationLinkDecoder exposing
    (restNavigationLinksDecoder, restNavigationLinkDecoder)

{-| RestNavigationLinkDecoder

@docs restNavigationLinksDecoder, restNavigationLinkDecoder
-}

import Json.Decode as D exposing (Decoder, andThen, fail, list, string, succeed)
import Json.Decode.Pipeline as DP
import Perfimmo.Http.RestNavigationLink exposing (HttpVerb(..), RestNavigationLink)

{-| restNavigationLinkDecoder
-}
restNavigationLinkDecoder: Decoder RestNavigationLink
restNavigationLinkDecoder =
    D.succeed RestNavigationLink
        |> DP.required "rel" string
        |> DP.required "href" string
        |> DP.required "method" httpVerbDecoder

{-| restNavigationLinksDecoder
-}
restNavigationLinksDecoder: Decoder (List RestNavigationLink)
restNavigationLinksDecoder = D.succeed A
    |> DP.required "_links" (list restNavigationLinkDecoder)
    |> D.map .links

type alias A =
    { links : List RestNavigationLink
    }

httpVerbDecoder: Decoder HttpVerb
httpVerbDecoder = string |> andThen string2HttpVerbDecoder

string2HttpVerbDecoder: String -> Decoder HttpVerb
string2HttpVerbDecoder s =
    case s of
        "GET" -> succeed GET
        "POST" -> succeed POST
        "PATCH" -> succeed PATCH
        "DELETE" -> succeed DELETE
        "PUT" -> succeed PUT
        other -> fail (other ++ " is not an known http verb in app")