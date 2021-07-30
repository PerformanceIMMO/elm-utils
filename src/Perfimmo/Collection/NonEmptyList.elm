module Perfimmo.Collection.NonEmptyList exposing
    ( NEL
    , nel
    , repeat
    , updateAt
    , decodeNEL
    , appendList
    , prependList
    )

import Json.Decode as D exposing (Decoder)
import List.Extra as ListE
import List.Nonempty exposing (Nonempty(..), fromList)

type alias NEL a = Nonempty a

nel = Nonempty

-- ToDO forcer un Int >= 1
repeat: Int -> a -> NEL a
repeat i elem = nel elem (List.repeat (i - 1) elem)

updateAt: Int -> (a -> a) -> Nonempty a -> Nonempty a
updateAt index f (Nonempty h t) = case index of
    0 -> nel (f h) t
    _ -> Nonempty h (ListE.updateAt (index - 1) f t)

decodeNEL: D.Decoder a -> Decoder (Nonempty a)
decodeNEL = D.list
    >> D.map fromList
    >> D.andThen
        ( Maybe.map D.succeed
        >> Maybe.withDefault (D.fail "should not be empty list")
        )

appendList: NEL a -> List a -> NEL a
appendList (Nonempty a l) listA =
    Nonempty a (l ++ listA)

prependList: List a -> NEL a -> NEL a
prependList xs (Nonempty a l) = case xs of
    [] -> (Nonempty a l)
    h :: t -> Nonempty h (t ++ [a] ++ l)
