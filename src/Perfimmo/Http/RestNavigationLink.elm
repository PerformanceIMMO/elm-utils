module Perfimmo.Http.RestNavigationLink exposing
    ( RestNavigationLink
    , setHref
    , HttpVerb(..)
    )

{-| RestNavigationLink

@docs  RestNavigationLink, setHref, HttpVerb
-}

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

{-| HttpVerb
-}
type HttpVerb = GET | POST | PATCH | DELETE | PUT
