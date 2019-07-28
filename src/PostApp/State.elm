module PostApp.State exposing (..)

import Browser
import Browser.Navigation as Nav
import PostApp.Rest exposing (fetchPostsCommand)
import PostApp.Routing as Route
import PostApp.Types exposing (Model, Msg(..), PostId, WebData, Post)
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
            ( model, Nav.pushUrl model.key (Url.toString url) )

        LinkClicked (Browser.External href) ->
            (model, Nav.load href)

        UrlChanged url ->
            ({model | route = Route.fromUrl url}, Cmd.none)

        UpdateTitle postId newTitle ->
            updateField postId newTitle setTitle model

        UpdateAuthorName postId newName ->
            updateField postId newName setAuthorName model

        UpdateAuthorUrl postId newUrl ->
            updateField postId newUrl setAuthorUrl model

init : flag -> Url.Url -> Nav.Key -> ( Model, Cmd Msg )
init _ url key =
    ( { posts = RemoteData.Loading
      , key = key
      , route = Route.fromUrl url
      }
    , fetchPostsCommand
    )


updateField :
    PostId
    -> String
    -> (String -> Post -> Post)
    -> Model
    -> ( Model, Cmd Msg )
updateField postId newValue updateFunction model =
    let
        updatePost post =
            if post.id == postId then
                updateFunction newValue post
            else
                post

        updatePosts posts =
            List.map updatePost posts

        updatedPosts =
            RemoteData.map updatePosts model.posts
    in
        ( { model | posts = updatedPosts }, Cmd.none )

setTitle : String -> Post -> Post
setTitle newTitle post =
    { post | title = newTitle }


setAuthorName : String -> Post -> Post
setAuthorName newName post =
    let
        oldAuthor =
            post.author
    in
        { post | author = { oldAuthor | name = newName } }


setAuthorUrl : String -> Post -> Post
setAuthorUrl newUrl post =
    let
        oldAuthor =
            post.author
    in
        { post | author = { oldAuthor | url = newUrl } }


