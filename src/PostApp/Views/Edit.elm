module PostApp.Views.Edit exposing (view)

import Bootstrap.Alert as Alert
import Bootstrap.Button as Button exposing (button, onClick)
import Bootstrap.Form as Form
import Bootstrap.Form.Input as Input
import Html exposing (Html, div, h3, text)
import Html.Attributes exposing (for, href)
import PostApp.Types exposing (Msg(..), Post)

view : Post -> Html Msg
view post =
    div []
        [ Alert.link [ href "/posts" ] [ text "Back" ]
        , h3 [] [ text "Edit Post"]
        , editForm post
        ]


editForm : Post -> Html Msg
editForm post =
    div []
        [ Form.form []
            [ Form.group []
                [ Form.label [ for "title" ] [ text "Title" ]
                , Input.text
                      [ Input.id "title"
                      , Input.value post.title
                      , Input.onInput (UpdateTitle post.id)
                      ]
                ]
            , Form.group []
                [ Form.label [ for "authorName" ] [ text "Author name" ]
                , Input.text
                    [ Input.id "authorName"
                    , Input.value post.author.name
                    , Input.onInput (UpdateAuthorName post.id)
                    ]
                ]
            , Form.group []
                [ Form.label [ for "authorUrl" ] [ text "Author URL" ]
                , Input.text
                    [ Input.id "authorUrl"
                    , Input.value post.author.url
                    , Input.onInput (UpdateAuthorUrl post.id)
                    ]
                ]
            ]
        , div []
            [ button [ onClick (SubmitUpdatedPost post.id), Button.large, Button.primary ]
                [text "Submit"]
            ]
        ]
