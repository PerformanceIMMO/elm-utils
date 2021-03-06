module Perfimmo.Http.NavigationLinkUtils exposing (findNavLink)

{-| NavigationLinkUtils

@docs findNavLink
-}

import Perfimmo.Http.RestNavigationLink exposing (RestNavigationLink)
import List.Extra as List

{-| findNavLink
-}
findNavLink: String -> List RestNavigationLink -> Maybe RestNavigationLink
findNavLink rel links = List.find (\l -> rel == l.rel) links