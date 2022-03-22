module Perfimmo.Form.FormField.FormPourcentTest exposing (..)

import Perfimmo.Form.FormField.FormPourcent as FormPourcent
import Test exposing (..)
import Expect

suite = describe "FormPourcent Test"
    [ describe "FormPourcent.build"
        [ test "test FormPourcent.build with empty String" <| \_ ->
            let result = FormPourcent.setValueFromS "" FormPourcent.empty
            in result |> FormPourcent.toFloat |> Expect.equal Nothing

        , test "test FormPourcent.build with 42" <| \_ ->
            let result = FormPourcent.setValueFromS "42" FormPourcent.empty |> FormPourcent.toFloat
                expected = Just <| 42
            in result |> Expect.equal expected

        , test "test FormPourcent.build with 42.3" <| \_ ->
            let result = FormPourcent.setValueFromS "42.3" FormPourcent.empty |> FormPourcent.toFloat
                expected = Just <| 42.3
            in result |> Expect.equal expected

        , test "test FormPourcent.build with 0" <| \_ ->
            let result = FormPourcent.setValueFromS "0" FormPourcent.empty |> FormPourcent.toFloat
                expected = Just <| 0
            in result |> Expect.equal expected

        , test "test FormPourcent.build with 100" <| \_ ->
            let result = FormPourcent.setValueFromS "100" FormPourcent.empty |> FormPourcent.toFloat
                expected = Just <| 100
            in result |> Expect.equal expected

        , test "100.1 is an invalid input" <| \_ ->
            let result = FormPourcent.setValueFromS "100.1" FormPourcent.empty |> FormPourcent.toFloat
                expected = Nothing
            in result |> Expect.equal expected

        , test "'42.' is a valid input for an user input in elm form" <| \_ ->
            let result = FormPourcent.setValueFromS "42." FormPourcent.empty |> FormPourcent.toFloat
                expected = Just <| 42
            in result |> Expect.equal expected

        , test "'42.s' is an invalid input" <| \_ ->
            let result = FormPourcent.setValueFromS "42.s" FormPourcent.empty
                expected = Nothing
            in result |> FormPourcent.toFloat |> Expect.equal expected

        , test "'42.2.1' is an invalid input" <| \_ ->
            let result = FormPourcent.setValueFromS "42.2.1" FormPourcent.empty
                expected = Nothing
            in result |> FormPourcent.toFloat |> Expect.equal expected

        , test "'42..' is an invalid input" <| \_ ->
            let result = FormPourcent.setValueFromS "42.." FormPourcent.empty
                expected = Nothing
            in result |> FormPourcent.toFloat |> Expect.equal expected

        , test "'42,2' is a valid input for an user input in elm form" <| \_ ->
            let result = FormPourcent.setValueFromS "42,2" FormPourcent.empty |> FormPourcent.toFloat
                expected = Just <| 42.2
            in result |> Expect.equal expected

        , test "'42,' is a valid input for an user input in elm form" <| \_ ->
            let result = FormPourcent.setValueFromS "42," FormPourcent.empty |> FormPourcent.toFloat
                expected = Just <| 42
            in result |> Expect.equal expected
        ]

    , describe "FormPourcent.toString"
        [ test "test FormPourcent.toString with 42" <| \_ ->
            let result = FormPourcent.setValueFromS "42" FormPourcent.empty |> FormPourcent.toString
                expected = "42"
            in result |> Expect.equal expected

        , test "test FormPourcent.toString with 42.3" <| \_ ->
            let result = FormPourcent.setValueFromS "42.3" FormPourcent.empty |> FormPourcent.toString
                expected = "42.3"
            in result |> Expect.equal expected

        , test "test FormPourcent.toString with 42." <| \_ ->
            let result = FormPourcent.setValueFromS "42." FormPourcent.empty |> FormPourcent.toString
                expected = "42."
            in result |> Expect.equal expected

        , test "test FormPourcent.toString with 42,3" <| \_ ->
            let result = FormPourcent.setValueFromS "42,3" FormPourcent.empty |> FormPourcent.toString
                expected = "42,3"
            in result |> Expect.equal expected

        , test "test FormPourcent.toString with 42," <| \_ ->
            let result = FormPourcent.setValueFromS "42," FormPourcent.empty |> FormPourcent.toString
                expected = "42,"
            in result |> Expect.equal expected
        ]

    , describe "FormPourcent.fromFloat"
        [ test "test FormPourcent.fromFloat with 42" <| \_ ->
             let result = FormPourcent.setValue 42 FormPourcent.empty |> FormPourcent.toFloat
                 expected = Just 42
             in result |> Expect.equal expected

        ]
    ]