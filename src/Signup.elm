module Signup exposing (..)

import Bootstrap.Button as Button exposing (button)
import Bootstrap.CDN as CDN
import Bootstrap.Form exposing (form, group, label)
import Bootstrap.Form.Input as Input exposing (email, id, password)
import Bootstrap.Grid as Grid
import Bootstrap.Grid.Col as Col
import Browser
import Html exposing (Html, div, h1, text)
import Html.Attributes exposing (class, for)


type alias User =
    { name : String
    , email : String
    , password : String
    , loggedIn : Bool
    }

init : User
init =
    { name = ""
    , email = ""
    , password = ""
    , loggedIn = False
    }

update : msg -> User -> User
update _ _ =
    init

view : User -> Html msg
view _ =
    Grid.container []
        [ CDN.stylesheet -- css embedded inline. TODO: Remove before deploy
        , Grid.row [ ]
            [ Grid.col [ Col.md6, Col.offsetMd3 ]
                [ h1 [ class "text-center" ] [ text "Sign up"]
                , form []
                    [ group []
                        [ label [ for "name" ] [ text "Name" ]
                        , Input.text [ id "name" ]
                        ]
                    , group []
                        [ label [ for "email" ] [ text "Email" ]
                        , email [ id "email" ]
                        ]
                    , group []
                        [ label [ for "password" ] [ text "Password" ]
                        , password [ id "password" ]
                        ]
                    , div [ class "text-center" ]
                        [ button
                            [ Button.large, Button.primary ]
                            [ text "Create my account" ]
                        ]
                    ]
                ]
            ]
        ]

main : Program () User msg
main =
  Browser.sandbox { init = init, update = update, view = view }