module Utils exposing (fuzzFilterMap)

import Fuzz


fuzzFilterMap : (a -> Maybe b) -> Fuzz.Fuzzer a -> Fuzz.Fuzzer b
fuzzFilterMap f fuzzer =
    let
        go : Int -> Fuzz.Fuzzer b
        go rejectionCount =
            if rejectionCount > 15 then
                Fuzz.invalid "Too many values were filtered out"

            else
                fuzzer
                    |> Fuzz.andThen
                        (\value ->
                            case f value of
                                Just b ->
                                    Fuzz.constant b

                                Nothing ->
                                    go (rejectionCount + 1)
                        )
    in
    go 0
