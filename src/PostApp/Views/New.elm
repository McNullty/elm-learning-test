module PostApp.Views.New exposing (..)

import Bootstrap.Alert as Alert
import Bootstrap.Button as Button exposing (button, onClick)
import Bootstrap.Form as Form
import Bootstrap.Form.Input as Input
import Bootstrap.Spinner as Spinner
import Html exposing (Html, div, h3, text)
import Html.Attributes exposing (for, href)
import PostApp.Types exposing (Model, Msg(..))
import RemoteData

view : Model -> Html Msg
view model =
    div []
        [ Alert.link [ href "/posts" ] [ text "Back" ]
        , h3 [] [ text "Create New Post" ]
        , newPostForm
        , showNetworkOperation model
        ]


newPostForm : Html Msg
newPostForm =
    div []
        [ Form.form []
            [ Form.group []
                [ Form.label [ for "title" ] [ text "Title" ]
                , Input.text
                      [ Input.id "title"
                      , Input.onInput NewPostTitle
                      ]
                ]
            , Form.group []
                [ Form.label [ for "authorName" ] [ text "Author name" ]
                , Input.text
                    [ Input.id "authorName"
                    , Input.onInput NewAuthorName
                    ]
                ]
            , Form.group []
                [ Form.label [ for "authorUrl" ] [ text "Author URL" ]
                , Input.text
                    [ Input.id "authorUrl"
                    , Input.onInput NewAuthorUrl
                    ]
                ]
            ]
        , div []
            [ button [ onClick CreateNewPost, Button.large, Button.primary ]
                [text "Submit"]
            ]
        ]


showNetworkOperation : Model -> Html Msg
showNetworkOperation model =
    case model.networkOperation of
        RemoteData.Loading ->
            div []
                [Spinner.spinner [] []]
        _ ->
            div []
                []