module Perfimmo.Form.FormField.FormFieldInfoTest exposing (..)

import Perfimmo.Form.FormField.Common exposing (FormFieldInfo(..), formFieldComparable)
import Test exposing (..)
import Expect
import Perfimmo.Form.FormField.FormField as FormField

suite = describe "FormFieldInfo Test"
    [ describe "for FormField"
        [ test "add FieldIsMandatory info" <| \_ ->
            let formField = FormField.init Nothing []
                result = FormField.addInfo FieldIsMandatory formField
            in FormField.getInfos result |> Expect.equal [FieldIsMandatory]

        , test "add already existing FieldIsMandatory info" <| \_ ->
            let formField = FormField.init Nothing [FieldIsMandatory]
                result = FormField.addInfo FieldIsMandatory formField
            in FormField.getInfos result |> Expect.equal [FieldIsMandatory]

        , test "remove FieldIsMandatory info" <| \_ ->
            let formField = FormField.init Nothing [FieldIsMandatory]
                result = FormField.removeInfo FieldIsMandatory formField
            in FormField.getInfos result |> Expect.equal []

        , test "add CustomDecorator info" <| \_ ->
            let formField = FormField.init Nothing []
                result = FormField.addInfo (CustomDecorator "toto" identity) formField
            in getInfos result |> Expect.equal ["CustomDecorator_toto"]

        , test "add already existing CustomDecorator info" <| \_ ->
            let formField = FormField.init Nothing [CustomDecorator "toto" identity]
                result = FormField.addInfo (CustomDecorator "toto" identity) formField
            in getInfos result |> Expect.equal ["CustomDecorator_toto"]

        , test "remove CustomDecorator info" <| \_ ->
            let formField = FormField.init Nothing [CustomDecorator "toto" identity]
                result = FormField.removeInfo (CustomDecorator "toto" identity) formField
            in getInfos result |> Expect.equal []

        , test "fail to remove CustomDecorator info" <| \_ ->
            let formField = FormField.init Nothing [CustomDecorator "toto" (\_ -> "jiji")]
                result = FormField.removeInfo (CustomDecorator "toto" identity) formField
            in getInfos result |> Expect.equal ["CustomDecorator_jiji"]
        ]
    ]

getInfos f = FormField.getInfos f |> List.map formFieldComparable