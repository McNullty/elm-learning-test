module PostApp.View exposing (..)

import Browser exposing (Document)
import Html exposing (Html, h3, text)
import PostApp.Routing as Route
import PostApp.Types as Types exposing (WebData)
import PostApp.Views.Edit as Edit
import PostApp.Views.List as List
import RemoteData exposing (RemoteData)


view : Types.Model -> Document Types.Msg
view model =
    { title = "Http get example"
    , body = [ viewBody model ]
    }


viewBody : Types.Model -> Html Types.Msg
viewBody model =
    case model.route of
        Route.PostsRoute ->
            List.view model

        Route.PostRoute postId ->
            case findPostById postId model.posts of
                Just post ->
                    Edit.view post

                Nothing ->
                    notFoundView

        Route.NotFoundRoute ->
            notFoundView


findPostById : Int -> WebData (List Types.Post) -> Maybe Types.Post
findPostById postId postsList =
    case RemoteData.toMaybe postsList of
        Just posts ->
            posts
                |> List.filter (\post -> post.id == postId)
                |> List.head

        Nothing ->
            Nothing

notFoundView : Html msg
notFoundView =
    h3 [] [ text "Oops! The page you requested was not found!" ]