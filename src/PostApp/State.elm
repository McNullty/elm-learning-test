module PostApp.State exposing (..)

import PostApp.Rest exposing (fetchPostsCommand)
import PostApp.Types exposing (..)
import RemoteData

update : Msg -> Model -> ( Model, Cmd Msg)
update msg model =
    case msg of
        FetchPosts ->
            ( { model | posts = RemoteData.Loading }, fetchPostsCommand)

        DataReceived response ->
            ( { model
                | posts = response
              }
            , Cmd.none
            )


init : flag -> ( Model, Cmd Msg )
init _ =
    ( { posts = RemoteData.Loading
      }
    , fetchPostsCommand
    )
