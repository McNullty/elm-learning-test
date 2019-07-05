module Main exposing (main)

import Bootstrap.Button as Button
import Bootstrap.CDN as CDN
import Bootstrap.Form as Form
import Bootstrap.Form.Input as Input
import Bootstrap.Grid as Grid
import Bootstrap.Grid.Col as Col
import Browser
import Html exposing (..)
import Html.Attributes exposing (..)


type alias User =
    { name : String
    , email : String
    , password : String
    , loggedIn : Bool
    }


initialModel : User
initialModel =
    { name = ""
    , email = ""
    , password = ""
    , loggedIn = False
    }


view : User -> Html msg
view user =
    Grid.container []
        [ CDN.stylesheet -- creates an inline style node with the Bootstrap CSS. TODO: Remove before deploying
        , Grid.row []
            [ Grid.col [ Col.md6, Col.offsetMd3 ]
                [ h1 [ class "text-center" ] [ text "Sign up" ]
                , Form.form []
                    [ Form.group []
                        [ Form.label [ for "name" ] [ text "Name" ]
                        , Input.text [ Input.id "name" ]
                        , Form.help [] [ text "Your name." ]
                        ]
                    , Form.group []
                        [ Form.label [ for "email" ] [ text "Email" ]
                        , Input.email [ Input.id "email", Input.attrs [ placeholder "test@example.com" ] ]
                        , Form.help [] [ text "Your email." ]
                        ]
                    , Form.group []
                        [ Form.label [ for "password" ] [ text "Password" ]
                        , Input.password [ Input.id "password" ]
                        ]
                    , Button.button [ Button.primary ] [ text "Create my account" ]
                    ]
                ]
            ]
        ]


update : msg -> User -> User
update msg model =
    initialModel


main =
    Browser.sandbox
        { init = initialModel
        , update = update
        , view = view
        }
