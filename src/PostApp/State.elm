module PostApp.State exposing (..)

import Browser
import Browser.Navigation as Nav
import PostApp.Rest exposing (fetchPostsCommand)
import PostApp.Types exposing (..)
import RemoteData
import Url exposing (Url)

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

        LinkClicked (Browser.Internal url) ->
            case url.fragment of
                Nothing ->
                    (model, Cmd.none)
                Just _ ->
                    ( model, Nav.pushUrl model.key (Url.toString url) )

        LinkClicked (Browser.External href) ->
            (model, Nav.load href)

        UrlChanged url ->
            ({model | url = url}, Cmd.none)


init : flag -> Url.Url -> Nav.Key -> ( Model, Cmd Msg )
init _ url key =
    ( { posts = RemoteData.Loading
      , key = key
      , url = url
      }
    , fetchPostsCommand
    )
