module PostApp.Views.Edit exposing (view)

import Html exposing (Html, a, br, button, div, h3, input, text)
import Html.Attributes exposing (href, type_, value)
import Html.Events exposing (onInput)
import PostApp.Types exposing (Msg(..), Post)

view : Post -> Html Msg
view post =
    div []
        [ a [ href "/posts" ] [ text "Back" ]
        , h3 [] [ text "Edit Post"]
        , editForm post
        ]


editForm : Post -> Html Msg
editForm post =
    Html.form []
        [ div []
            [ text "Title"
            , br [] []
            , input
                [ type_ "text"
                , value post.title
                , onInput (UpdateTitle post.id)
                ]
                []
            ]
        , br [] []
        , div []
            [ text "Author name"
            , br [] []
            , input
                [ type_ "text"
                , value post.author.name
                , onInput (UpdateAuthorName post.id)
                ]
                []
            ]
        , br [] []
        , div []
            [ text "Author URL"
            , br [] []
            , input
                [ type_ "text"
                , value post.author.url
                , onInput (UpdateAuthorUrl post.id)
                ]
                []
            ]
        , br [] []
        , div []
            [ button []
                [text "Submit"]
            ]
        ]
