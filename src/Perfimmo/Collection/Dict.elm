module Perfimmo.Collection.Dict exposing (nonemptyGroupBy)

{-| function to index a List to a Dict of Nonempty List

@docs nonemptyGroupBy

-}

import Dict exposing (Dict)
import Dict.Extra as DictE
import List.Nonempty as NEL

{-| nonemptyGroupBy takes a key-fn and a list.
                    Creates a `Dict` which maps the key to a Nonempty list of matching elements.
-}
nonemptyGroupBy : (a -> comparable) -> List a -> Dict comparable (NEL.Nonempty a)
nonemptyGroupBy keyfn =
    DictE.groupBy keyfn >> DictE.filterMap (\_ v -> v |> NEL.fromList)
