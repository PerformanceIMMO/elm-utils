module Perfimmo.Form.FormField.FormFloatTest exposing (..)

import Perfimmo.Form.FormField.FormFloat as FormFloat
import Test exposing (..)
import Expect

suite = describe "FormFloat Test"
    [ describe "FormFloat.build"
        [ test "test FormFloat.build with empty String" <| \_ ->
            let result = FormFloat.setValueFromS "" FormFloat.empty
            in result |> FormFloat.toFloat |> Expect.equal Nothing

        , test "test FormFloat.build with 42" <| \_ ->
            let result = FormFloat.setValueFromS "42" FormFloat.empty |> FormFloat.toFloat
                expected = Just <| 42
            in result |> Expect.equal expected

        , test "test FormFloat.build with 42.3" <| \_ ->
            let result = FormFloat.setValueFromS "42.3" FormFloat.empty |> FormFloat.toFloat
                expected = Just <| 42.3
            in result |> Expect.equal expected

        , test "'42.' is a valid input for an user input in elm form" <| \_ ->
            let result = FormFloat.setValueFromS "42." FormFloat.empty |> FormFloat.toFloat
                expected = Just <| 42
            in result |> Expect.equal expected

        , test "'42.s' is an invalid input" <| \_ ->
            let result = FormFloat.setValueFromS "42.s" FormFloat.empty
                expected = Nothing
            in result |> FormFloat.toFloat |> Expect.equal expected

        , test "'42.2.1' is an invalid input" <| \_ ->
            let result = FormFloat.setValueFromS "42.2.1" FormFloat.empty
                expected = Nothing
            in result |> FormFloat.toFloat |> Expect.equal expected

        , test "'42..' is an invalid input" <| \_ ->
            let result = FormFloat.setValueFromS "42.." FormFloat.empty
                expected = Nothing
            in result |> FormFloat.toFloat |> Expect.equal expected

        , test "'42,2' is a valid input for an user input in elm form" <| \_ ->
            let result = FormFloat.setValueFromS "42,2" FormFloat.empty |> FormFloat.toFloat
                expected = Just <| 42.2
            in result |> Expect.equal expected

        , test "'42,' is a valid input for an user input in elm form" <| \_ ->
            let result = FormFloat.setValueFromS "42," FormFloat.empty |> FormFloat.toFloat
                expected = Just <| 42
            in result |> Expect.equal expected
        ]

    , describe "FormFloat.toString"
        [ test "test FormFloat.toString with 42" <| \_ ->
            let result = FormFloat.setValueFromS "42" FormFloat.empty |> FormFloat.toString
                expected = "42"
            in result |> Expect.equal expected

        , test "test FormFloat.toString with 42.3" <| \_ ->
            let result = FormFloat.setValueFromS "42.3" FormFloat.empty |> FormFloat.toString
                expected = "42.3"
            in result |> Expect.equal expected

        , test "test FormFloat.toString with 42." <| \_ ->
            let result = FormFloat.setValueFromS "42." FormFloat.empty |> FormFloat.toString
                expected = "42."
            in result |> Expect.equal expected

        , test "test FormFloat.toString with 42,3" <| \_ ->
            let result = FormFloat.setValueFromS "42,3" FormFloat.empty |> FormFloat.toString
                expected = "42,3"
            in result |> Expect.equal expected

        , test "test FormFloat.toString with 42," <| \_ ->
            let result = FormFloat.setValueFromS "42," FormFloat.empty |> FormFloat.toString
                expected = "42,"
            in result |> Expect.equal expected
        ]

    , describe "FormFloat.fromFloat"
        [ test "test FormFloat.fromFloat with 42" <| \_ ->
             let result = FormFloat.setValue 42 FormFloat.empty |> FormFloat.toFloat
                 expected = Just 42
             in result |> Expect.equal expected

        ]
    ]