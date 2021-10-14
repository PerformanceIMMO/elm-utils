module Perfimmo.Http.RestNavigationLink exposing
    ( RestNavigationLink
    , setHref
    , setQueryParams
    , HttpVerb(..)
    )

{-| RestNavigationLink

@docs  RestNavigationLink, setHref, setQueryParams, HttpVerb
-}

import List.Nonempty as NEL
import Perfimmo.Collection.NonEmptyList exposing (NEL)

{-| RestNavigationLink
-}
type alias RestNavigationLink =
    { rel: String
    , href: String
    , method: HttpVerb
    }

{-| setHref
-}
setHref: RestNavigationLink -> String -> RestNavigationLink
setHref link href = { link| href = href }

{-| setQueryParams
-}
setQueryParams: RestNavigationLink -> NEL (String, String) -> RestNavigationLink
setQueryParams link params =
    let paramsS = (NEL.toList params) |> List.map (\(k,v) -> k ++ "=" ++ v) |> String.join "&"
        href = link.href ++ "?" ++ paramsS
    in { link| href = href }


{-| HttpVerb
-}
type HttpVerb = GET | POST | PATCH | DELETE | PUT
