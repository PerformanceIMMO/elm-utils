module Perfimmo.Http.HttpRequest exposing
    ( Request(..)
    , withAuthReq
    , expectJsonResponse
    , expectWhateverResponse
    , HttpResult
    , BodyResponse(..)
    , HttpError(..)
    , ResponseDecoder
    , expectJsonResponse2
    , expectWhateverOkResult
    , request
    , authRequest
    , bool2Uri
    , printHttpError)
{-| HttpRequest

# Types
@docs Request, BodyResponse, HttpError, HttpResult, ResponseDecoder

# Functions
@docs withAuthReq, request, authRequest

# Helper
@docs printHttpError

# Expect
@docs expectJsonResponse, expectWhateverResponse, expectJsonResponse2, expectWhateverOkResult

# Transformations
@docs bool2Uri

-}
import Perfimmo.Http.RestNavigationLink exposing (HttpVerb(..), RestNavigationLink)
import Http exposing (Error(..), Expect, Response, expectStringResponse)
import Json.Decode as D

{-| Request
-}
type Request a =
    Get String (Http.Expect a)
    | Delete String (Http.Expect a)
    | Post String Http.Body (Http.Expect a)
    | Put String Http.Body (Http.Expect a)
    | Patch String Http.Body (Http.Expect a)

{-| withAuthReq
-}
withAuthReq: Request a -> Cmd a
withAuthReq req =
    case req of
       Get url msg -> executeRequest "GET" [] url Http.emptyBody msg
       Delete url msg -> executeRequest "DELETE" [] url Http.emptyBody msg
       Post url body msg -> executeRequest "POST" [] url body msg
       Put url body msg -> executeRequest "PUT" [] url body msg
       Patch url body msg -> executeRequest "PATCH" [] url body msg

{-| request
-}
request: RestNavigationLink -> Http.Body -> (Http.Expect a) -> Request a
request link body exp = case link.method of
    GET -> Get link.href exp
    POST -> Post link.href body exp
    PATCH -> Patch link.href body exp
    DELETE -> Delete link.href exp
    PUT -> Put link.href body exp

{-| authRequest
-}
authRequest: RestNavigationLink -> Http.Body -> (Http.Expect a) -> Cmd a
authRequest link body exp = withAuthReq <| request link body exp

{-| executeRequest
-}
executeRequest : String -> List Http.Header -> String -> Http.Body -> Expect msg -> Cmd msg
executeRequest method headers url body expect =
    Http.riskyRequest
     { method = method
     , headers = headers
     , url = url
     , body = body
     , expect = expect
     , timeout = Nothing
     , tracker = Nothing
     }

{-| expectJsonResponse
-}
expectJsonResponse : (Result Http.Error (Http.Metadata, a) -> msg) -> D.Decoder a -> Expect msg
expectJsonResponse toMsg decoder =
  expectStringResponse toMsg <|
    \response ->
      case response of
        Http.BadUrl_ url ->
          Err (Http.BadUrl url)

        Http.Timeout_ ->
          Err Http.Timeout

        Http.NetworkError_ ->
          Err Http.NetworkError

        Http.BadStatus_ metadata body ->    -- TODO retourner le body dans la réponse
          Err (Http.BadStatus metadata.statusCode)

        Http.GoodStatus_ metadata body ->
          case D.decodeString decoder body of
            Ok value -> Ok (metadata, value)

            Err err ->
              Err (Http.BadBody (D.errorToString err))

{-| expectWhateverResponse
-}
expectWhateverResponse: (Result Http.Error (Http.Metadata) -> msg) -> Expect msg
expectWhateverResponse toMsg =
     expectStringResponse toMsg <|
       \response ->
         case response of
           Http.BadUrl_ url ->
             Err (Http.BadUrl url)

           Http.Timeout_ ->
             Err Http.Timeout

           Http.NetworkError_ ->
             Err Http.NetworkError

           Http.BadStatus_ metadata _ ->
             Err (Http.BadStatus metadata.statusCode)

           Http.GoodStatus_ metadata _ ->
               Ok metadata

{-| HttpResult
-}
type alias HttpResult e a = Result (HttpError e) (BodyResponse a)

{-| BodyResponse
-}
type BodyResponse a = BodyResponse Http.Metadata a

{-| HttpError
-}
type HttpError e = TechnicalError String | DomainError (BodyResponse e)

{-| ResponseDecoder
-}
type alias ResponseDecoder e a =
    { koDecoder: D.Decoder e
    , okDecoder: D.Decoder a
    }

{-| expectWhateverOkResult
-}
expectWhateverOkResult : (HttpResult e () -> msg) -> D.Decoder e -> Expect msg
expectWhateverOkResult toMsg decoder =
    expectStringResponse toMsg <|
        \response ->
          case response of
            Http.BadUrl_ url ->
              Err <| TechnicalError ("Http.BadUrl" ++ url)

            Http.Timeout_ ->
              Err <| TechnicalError "Http.Timeout"

            Http.NetworkError_ ->
              Err <| TechnicalError "Http.NetworkError"

            Http.BadStatus_ metadata body ->
              let
                result = case D.decodeString decoder body of
                            Ok value -> DomainError <| BodyResponse metadata value
                            Err _ -> TechnicalError body
              in Err result

            Http.GoodStatus_ metadata _ -> Ok <| BodyResponse metadata ()


{-|expectJsonResponse2
-}
expectJsonResponse2 : (HttpResult e a -> msg) -> ResponseDecoder e a -> Expect msg
expectJsonResponse2 toMsg decoders =
  expectStringResponse toMsg <|
    \response ->
      case response of
        Http.BadUrl_ url ->
          Err <| TechnicalError ("Http.BadUrl" ++ url)

        Http.Timeout_ ->
          Err <| TechnicalError "Http.Timeout"

        Http.NetworkError_ ->
          Err <| TechnicalError "Http.NetworkError"

        Http.BadStatus_ metadata body ->
          let
            result = case D.decodeString decoders.koDecoder body of
                        Ok value -> DomainError <| BodyResponse metadata value
                        Err _ -> TechnicalError "json parsing error"
          in Err result

        Http.GoodStatus_ metadata body -> decodeJsonBody body metadata decoders

decodeJsonBody body metadata decoders =
    case D.decodeString decoders.okDecoder body of
        Ok value -> Ok <| BodyResponse metadata value
        Err err -> Err <| TechnicalError (D.errorToString err)

{-| bool2Uri
-}
bool2Uri: Bool -> String
bool2Uri b = case b of
    True -> "false"
    False -> "true"

{-| printHttpError
-}
printHttpError : Http.Error -> String
printHttpError error =
    case error of
        BadUrl url -> "bad url : " ++ url
        Timeout -> "timeout"
        NetworkError -> "network error"
        BadStatus s -> "bad status : " ++ String.fromInt s
        BadBody s -> "bad body : " ++ s