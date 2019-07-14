module PostApp.Rest exposing (fetchPostsCommand)

import Http
import Json.Decode as Decode exposing (Decoder, int, list, string)
import Json.Decode.Pipeline exposing (optional, required)
import PostApp.Types exposing (..)
import RemoteData

authorDecoder : Decoder Author
authorDecoder =
    Decode.succeed Author
        |> required "name" string
        |> optional "url" string "http://dudeism.com"


postDecoder : Decoder Post
postDecoder =
    Decode.succeed Post
        |> required "id" int
        |> required "title" string
        |> required "author" authorDecoder


fetchPostsCommand : Cmd Msg
fetchPostsCommand =
    Http.get
        { url = "http://localhost:5019/posts"
        , expect = Http.expectJson (RemoteData.fromResult >> DataReceived) (list postDecoder)
        }