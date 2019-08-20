module PostApp.Views.New exposing (..)

import Html exposing (Html, a, br, button, div, h3, input, text)
import Html.Attributes exposing (href, type_)
import Html.Events exposing (onClick, onInput)
import PostApp.Types exposing (Msg(..))

view : Html Msg
view =
    div []
        [ a [ href "/posts" ] [ text "Back" ]
        , h3 [] [ text "Create New Post" ]
        , newPostForm
        ]


newPostForm : Html Msg
newPostForm =
    div []
        [ div []
            [ text "Title"
            , br [] []
            , input
                [ type_ "text"
                , onInput NewPostTitle
                ]
                []
            ]
        , br [] []
        , div []
            [ text "Author Name"
            , br [] []
            , input
                [ type_ "text"
                , onInput NewAuthorName
                ]
                []
            ]
        , br [] []
        , div []
            [ text "Author URL"
            , br [] []
            , input
                [ type_ "text"
                , onInput NewAuthorUrl
                ]
                []
            ]
        , br [] []
        , div []
            [ button [ onClick CreateNewPost ]
                [ text "Submit" ]
            ]
        ]