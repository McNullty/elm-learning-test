module PatchExample exposing (..)

import Browser exposing (Document)
import Html exposing (Html, button, div, h3, input, li, text, ul)
import Html.Attributes exposing (type_, value)
import Html.Events exposing (onClick, onInput)
import Http exposing (Response)
import Json.Decode as Decode exposing (Decoder, int, list, string)
import Json.Decode.Pipeline exposing (required)
import Json.Encode as Encode
import RemoteData exposing (RemoteData)


type alias Post =
    { id : Int
    , title : String
    }


type Msg
    = UpdateTitle Int String
    | PatchPost Int
--    | PostUpdated (RemoteData Http.Error Post)
--    | DataReceived (Result Http.Error String)


init : flag -> ( Post, Cmd Msg )
init _ =
    ( { id = 1, title = ""}, Cmd.none )


view : Post -> Document Msg
view post =
    { title = "Http get example"
    , body =
        [ div []
            [ input
                [ type_ "text"
                , value post.title
                , onInput (UpdateTitle post.id)
                ]
                []
            , button
                [ onClick (PatchPost post.id) ]
                [ text "Patch request" ]
            ]
        ]
    }


url : String
url =
    "http://localhost:5019/posts"


--createErrorMessageFromHttpError : Http.Error -> String
--createErrorMessageFromHttpError httpError =
--    case httpError of
--        Http.BadUrl message ->
--            message
--
--        Http.Timeout ->
--            "Server is taking too long to respond. Please try again later."
--
--        Http.NetworkError ->
--            "It appears you don't have an Internet connection right now."
--
--        Http.BadStatus response ->
--            String.fromInt response
--
--        Http.BadBody response ->
--            response

--postEncoder : Post -> Encode.Value
--postEncoder post =
--    Encode.object
--        [ ( "id", Encode.int post.id )
--        , ( "title", Encode.string post.title )
--        ]
--
--postDecoder : Decoder Post
--postDecoder =
--    Decode.succeed Post
--        |> required "id" int
--        |> required "title" string
--
--
--updatePostCommand : Post -> Cmd Msg
--updatePostCommand post =
--    Http.request
--        { method = "PATCH"
--        , headers = []
--        , url = "http://localhost:5019/posts/" ++ (String.fromInt post.id)
--        , body = Http.jsonBody (postEncoder post)
--        , expect = Http.expectJson (RemoteData.fromResult >> PostUpdated) postDecoder
--        , timeout = Nothing
--        , tracker = Nothing
--        }

--update : Msg -> Model -> ( Model, Cmd Msg )
--update msg model =
--    case msg of
--        SendHttpRequest post ->
--            ( model, updatePostCommand post)
--
--        DataReceived (Ok title) ->
--            ( { model | title = title }, Cmd.none )
--
--        DataReceived (Err error) ->
--            ( { model | errorMessage = Just (createErrorMessageFromHttpError error) }, Cmd.none )
--

update : Msg -> Post -> ( Post, Cmd Msg )
update msg post =
    let
        _ = Debug.log "Msg: " msg
        _ = Debug.log "Post: " post
    in
    case msg of
        UpdateTitle id title ->
            ( { post | title = title }, Cmd.none)
        PatchPost id ->
            (post, Cmd.none)

main : Program () Post Msg
main =
    Browser.document
        { init = init
        , view = view
        , update = update
        , subscriptions = \_ -> Sub.none
        }
