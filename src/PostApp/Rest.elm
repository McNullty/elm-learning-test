module PostApp.Rest exposing (fetchPostsCommand, updatePostCommand, deletePostCommand, createPostCommand)

import Http
import Json.Decode as Decode exposing (Decoder, int, list, string)
import Json.Decode.Pipeline exposing (optional, required)
import Json.Encode as Encode
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


postEncoder : Post -> Encode.Value
postEncoder post =
    Encode.object
        [ ( "id", Encode.int post.id )
        , ( "title", Encode.string post.title )
        , ( "author", authorEncoder post.author )
        ]


newPostEncoder : Post -> Encode.Value
newPostEncoder post =
    Encode.object
        [ ( "title", Encode.string post.title )
        , ( "author", authorEncoder post.author )
        ]


authorEncoder : Author -> Encode.Value
authorEncoder author =
    Encode.object
        [ ( "name", Encode.string author.name )
        , ( "url", Encode.string author.url )
        ]

fetchPostsCommand : Cmd Msg
fetchPostsCommand =
    Http.get
        { url = "http://localhost:5019/posts"
        , expect = Http.expectJson (RemoteData.fromResult >> DataReceived) (list postDecoder)
        }


updatePostCommand : Post -> Cmd Msg
updatePostCommand post =
    Http.request
        { method = "PATCH"
        , headers = []
        , url = "http://localhost:5019/posts/" ++ (String.fromInt post.id)
        , body = Http.jsonBody (postEncoder post)
        , expect = Http.expectJson (RemoteData.fromResult >> PostUpdated) postDecoder
        , timeout = Nothing
        , tracker = Nothing
        }

deletePostCommand : Post -> Cmd Msg
deletePostCommand post =
    Http.request
        { method = "DELETE"
        , headers = []
        , url = "http://localhost:5019/posts/" ++ (String.fromInt post.id)
        , body = Http.emptyBody
        , expect = Http.expectString (RemoteData.fromResult >> PostDeleted)
        , timeout = Nothing
        , tracker = Nothing
        }

createPostCommand : Post -> Cmd Msg
createPostCommand post =
    Http.post
        { url = "http://localhost:5019/posts"
        , body = Http.jsonBody (newPostEncoder post)
        , expect = Http.expectJson (RemoteData.fromResult >> PostCreated) postDecoder
        }