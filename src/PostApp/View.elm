module PostApp.View exposing (..)

import Browser exposing (Document)
import Html exposing (Html, button, div, text)
import Html.Events exposing (onClick)
import PostApp.Types as Types
import PostApp.Views.List as List

view : Types.Model -> Document Types.Msg
view model =
    { title = "Http get example"
    , body = [ viewBody model ]
    }

viewBody : Types.Model -> Html Types.Msg
viewBody model =
    div []
        [ button [ onClick Types.FetchPosts ]
            [ text "Refresh posts" ]
        , List.viewPostsOrError model
        ]