module Perfimmo.Http.RestNavigationLink exposing
    ( RestNavigationLink
    , setHref
    , HttpVerb(..)
    )

type alias RestNavigationLink =
    { rel: String
    , href: String
    , method: HttpVerb
    }

setHref: RestNavigationLink -> String -> RestNavigationLink
setHref link href = { link| href = href }

type HttpVerb = GET | POST | PATCH | DELETE | PUT
