module PostApp.View exposing (..)

import Bootstrap.CDN as CDN
import Bootstrap.Grid as Grid
import Bootstrap.Grid.Col as Col
import Browser exposing (Document)
import Html exposing (Html, h3, text)
import Html.Attributes exposing (class)
import PostApp.Misc exposing (findPostById)
import PostApp.Routing as Route
import PostApp.Types as Types exposing (WebData)
import PostApp.Views.Edit as Edit
import PostApp.Views.List as List
import PostApp.Views.New as New


view : Types.Model -> Document Types.Msg
view model =
    { title = "Http get example"
    , body = [ viewBody model ]
    }


viewBody : Types.Model -> Html Types.Msg
viewBody model =
    Grid.container []
            [ CDN.stylesheet -- creates an inline style node with the Bootstrap CSS. TODO: Remove before deploying
            , Grid.row []
                [ Grid.col [ Col.md6, Col.offsetMd3 ]
                     [
                        case model.route of
                            Route.PostsRoute ->
                                List.view model

                            Route.PostRoute postId ->
                                case findPostById postId model.posts of
                                    Just post ->
                                        Edit.view post

                                    Nothing ->
                                        waitingForResponseView

                            Route.NewPostRoute ->
                                New.view

                            Route.NotFoundRoute ->
                                notFoundView
                     ]
                ]
            ]



notFoundView : Html msg
notFoundView =
    h3 [ class "text-center" ] [ text "Oops! The page you requested was not found!" ]

waitingForResponseView : Html msg
waitingForResponseView =
    h3 [ class "text-center" ] [ text "Waiting for response from servers!" ]