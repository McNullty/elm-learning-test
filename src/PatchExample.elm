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
    | PostUpdated (RemoteData Http.Error Post)


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
    "http://localhost:5019/posts/"


postEncoder : Post -> Encode.Value
postEncoder post =
    Encode.object
        [ ( "id", Encode.int post.id )
        , ( "title", Encode.string post.title )
        ]


postDecoder : Decoder Post
postDecoder =
    Decode.succeed Post
        |> required "id" int
        |> required "title" string


updatePostCommand : Post -> Cmd Msg
updatePostCommand post =
    Http.request
        { method = "PATCH"
        , headers = []
        , url = url ++ (String.fromInt post.id)
        , body = Http.jsonBody (postEncoder post)
        , expect = Http.expectJson (RemoteData.fromResult >> PostUpdated) postDecoder
        , timeout = Nothing
        , tracker = Nothing
        }


update : Msg -> Post -> ( Post, Cmd Msg )
update msg post =
    let
        _ = Debug.log "Msg: " msg
        _ = Debug.log "Post: " post
    in
    case msg of
        UpdateTitle _ title ->
            ( { post | title = title }, Cmd.none)
        PatchPost _ ->
            (post, updatePostCommand post)
        PostUpdated _ ->
            (post, Cmd.none)

main : Program () Post Msg
main =
    Browser.document
        { init = init
        , view = view
        , update = update
        , subscriptions = \_ -> Sub.none
        }