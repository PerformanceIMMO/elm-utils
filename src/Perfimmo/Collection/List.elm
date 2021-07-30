module Perfimmo.Collection.List exposing
    ( insertAt
    , splitIf
    , flatten
    , collectFirst
    )
{-| Utils function on list
-}
import List.Extra as ListE
import List.FlatMap as ListF

{-| insertAtRec
-}
insertAtRec : Int -> a -> List a -> List a
insertAtRec index element list =
    if index <= 0 then element :: list
    else List.take index list ++ (element :: List.drop index list)

{-| splitIf
-}
splitIf: (a -> Bool) -> List a -> List (List a)        -- TODO l'élément splitter doit etre avant et non après
splitIf predicate list =
    List.foldl (\elem acc ->
        if predicate elem then acc ++ [[elem]]
        else case acc of
            [] -> [[elem]]
            _ -> ListE.updateAt (List.length acc - 1) (\x -> x ++ [elem]) acc
    ) [] list

flatten = ListF.flatMap identity

{-| insertAt
-}
insertAt: Int -> a -> List a -> List a
insertAt i x l =
    let (before, after) = ListE.splitAt i l
    in before ++ [x] ++ after

{-| collectFirst
-}
collectFirst: (a -> Maybe b) -> List a -> Maybe b
collectFirst predicate list = List.filterMap predicate list |> List.head