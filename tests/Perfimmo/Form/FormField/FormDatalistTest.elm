module Perfimmo.Form.FormField.FormDatalistTest exposing (..)

import Perfimmo.Form.FormField.FormDatalist as FormDatalist exposing (ValueState(..))
import Test exposing (..)
import Expect

suite = describe "TEST FormDatalist"
    [ describe "test init"
        [ test "init datalist result nothing value state" <| \_ ->
            let values = [("toto"), ("tutu")]
                datalist = FormDatalist.init values [] Just identity
                result = FormDatalist.getValue datalist
            in result |> Expect.equal Nothing
        ]

    , describe "test setValue"
        [ test "set value existing in values result to ChosenItem value state" <| \_ ->
            let values = [("toto"), ("tutu")]
                datalist = FormDatalist.init values [] Just identity |> FormDatalist.setValue "toto"
                result = FormDatalist.getValue datalist
            in result |> Expect.equal (Just <| ChosenItem "toto")

        , test "set value not verify exactness of the input" <| \_ ->
            let values = [("toto"), ("tutu")]
                datalist = FormDatalist.init values [] Just identity |> FormDatalist.setValue "to"
                result = FormDatalist.getValue datalist
            in result |> Expect.equal (Just <| ChosenItem "to")
        ]

    , describe "test setValuFromS"
        [ test "set value from S existing in values result to ChosenItem value state" <| \_ ->
            let values = [("toto"), ("tutu")]
                datalist = FormDatalist.init values [] Just identity |> FormDatalist.setValueFromS "tutu"
                result = FormDatalist.getValue datalist
            in result |> Expect.equal (Just <| ChosenItem "tutu")

        , test "set value from S non existing in values result to InputSearch value state" <| \_ ->
            let values = [("toto"), ("tutu")]
                datalist = FormDatalist.init values [] Just identity |> FormDatalist.setValueFromS "tu"
                result = FormDatalist.getValue datalist
            in result |> Expect.equal (Just <| InputSearch "tu")
        ]

    , describe "test getValue"
        [ test "get value for a ChosenItem state, return the value" <| \_ ->
            let values = [("toto"), ("tutu")]
                datalist = FormDatalist.init values [] Just identity |> FormDatalist.setValueFromS "tutu"
                result = FormDatalist.getValue datalist
            in result |> Expect.equal (Just <| ChosenItem "tutu")

        , test "get value for a InputSearch state, return Nothing" <| \_ ->
            let values = [("toto"), ("tutu")]
                datalist = FormDatalist.init values [] Just identity |> FormDatalist.setValueFromS "tu"
                result = FormDatalist.getValue datalist
            in result |> Expect.equal (Just <| InputSearch "tu")
        ]

    , describe "test getStringValue"
        [ test "getStringValue for a ChosenItem state, return the string value" <| \_ ->
            let values = [("toto"), ("tutu")]
                datalist = FormDatalist.init values [] Just identity |> FormDatalist.setValueFromS "tutu"
                result = FormDatalist.getStringValue datalist
            in result |> Expect.equal (Just "tutu")

        , test "getStringValue for a InputSearch state, return empty string" <| \_ ->
            let values = [("toto"), ("tutu")]
                datalist = FormDatalist.init values [] Just identity |> FormDatalist.setValueFromS "tu"
                result = FormDatalist.getStringValue datalist
            in result |> Expect.equal (Just "")
        ]
    ]