module Perfimmo.Http.NavigationLinkUtils exposing (..)

import RestNavigationLink exposing (RestNavigationLink)
import List.Extra as List

findNavLink: String -> List RestNavigationLink -> Maybe RestNavigationLink
findNavLink rel links = List.find (\l -> rel == l.rel) links