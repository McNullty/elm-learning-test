port module PostApp.State exposing (..)

import Browser
import Browser.Navigation as Nav
import Json.Decode exposing (Value, decodeValue, string)
import PostApp.Misc exposing (findPostById)
import PostApp.Rest exposing (createPostCommand, deletePostCommand, fetchPostsCommand, updatePostCommand)
import PostApp.Routing as Route
import PostApp.Types exposing (Author, Model, Msg(..), NetworkOperations(..), Post, PostId, WebData)
import RemoteData
import Url exposing (Url)


port sendData : String -> Cmd msg


port receiveData : (Value -> msg) -> Sub msg


port storePosts : List Post -> Cmd msg


updateWithStorage : Msg -> Model -> ( Model, Cmd Msg )
updateWithStorage msg model =
    let
        ( newModel, commands ) =
            update msg model

        extractedPosts =
            RemoteData.toMaybe newModel.posts
                |> Maybe.withDefault []
    in
        ( newModel
        , Cmd.batch [ commands, storePosts extractedPosts ]
        )


update : Msg -> Model -> ( Model, Cmd Msg)
update msg model =
    let
        _ = Debug.log "Msg: " msg
        _ = Debug.log "Model: " msg
    in
    case msg of
        FetchPosts ->
            ( { model | posts = RemoteData.Loading
                      , networkOperation = Loading}
            , fetchPostsCommand)

        DataReceived response ->
            ( { model
                | posts = response
                , networkOperation = Done
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

        SubmitUpdatedPost postId ->
            case findPostById postId model.posts of
                Just post ->
                    ( { model | networkOperation = Loading }
                    , updatePostCommand post)

                Nothing ->
                    ( model, Cmd.none )

        PostUpdated _ ->
            ( { model | networkOperation = Done }
            , Cmd.none )

        DeletePost postId ->
            case findPostById postId model.posts of
                Just post ->
                    ( { model | networkOperation = Loading }
                    , deletePostCommand post)

                Nothing ->
                    ( model, Cmd.none )

        PostDeleted _ ->
            ( model, fetchPostsCommand )

        NewPostTitle newTitle ->
            updateNewPost newTitle setTitle model

        NewAuthorName newName ->
            updateNewPost newName setAuthorName model

        NewAuthorUrl newUrl ->
            updateNewPost newUrl setAuthorUrl model

        CreateNewPost ->
            ( { model | networkOperation = Loading }
            , createPostCommand model.newPost)

        PostCreated (RemoteData.Success createdPost) ->
            ( {model
                | posts = addNewPost createdPost model.posts
                , newPost = emptyPost
                , networkOperation = Done}
            , Cmd.none )

        PostCreated _ ->
            ( model, Cmd.none )

        SendDataToJS ->
            ( model, sendData "Hello JavaScript!")

        ReceivedDataFromJS data ->
            case decodeValue string data of
                Ok stringData ->
                    ( {model | received = stringData }, Cmd.none )

                Err _ ->
                    ( model, Cmd.none )


addNewPost : Post -> WebData (List Post) -> WebData (List Post)
addNewPost newPost posts =
    let
        appendPost : List Post -> List Post
        appendPost listOfPosts =
            List.append listOfPosts [ newPost ]
    in
        RemoteData.map appendPost posts


tempPostId =
    -1


emptyPost : Post
emptyPost =
    Author "" ""
        |> Post tempPostId ""


init : Maybe (List Post) -> Url.Url -> Nav.Key -> ( Model, Cmd Msg )
init flags url key =
    let
        posts =
            case flags of
                Just listOfPosts ->
                    RemoteData.Success listOfPosts

                Nothing ->
                    RemoteData.Loading
    in
        ( { posts = posts
          , key = key
          , route = Route.fromUrl url
          , newPost = emptyPost
          , networkOperation = Done
          , received = ""
          }
        , fetchPostsCommand
        )


updateNewPost :
    String
    -> (String -> Post -> Post)
    -> Model
    -> ( Model, Cmd Msg )
updateNewPost newValue updateFunction model =
    let
        updatedNewPost =
            updateFunction newValue model.newPost
    in
        ( { model | newPost = updatedNewPost }, Cmd.none )


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


