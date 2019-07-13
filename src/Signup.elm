module Signup exposing (..)

import Bootstrap.Button as Button exposing (button, onClick)
import Bootstrap.CDN as CDN
import Bootstrap.Form exposing (form, group, label)
import Bootstrap.Form.Input as Input exposing (email, id, onInput, password)
import Bootstrap.Grid as Grid
import Bootstrap.Grid.Col as Col
import Browser
import Debug exposing (log)
import Html exposing (Html, div, h1, text)
import Html.Attributes exposing (class, for)


type alias User =
    { name : String
    , email : String
    , password : String
    , loggedIn : Bool
    }

type Msg
    = SaveName String
    | SaveEmail String
    | SavePassword String
    | Signup

init : User
init =
    { name = ""
    , email = ""
    , password = ""
    , loggedIn = False
    }

update : Msg -> User -> User
update message user =
    case message of
        SaveName name ->
            { user | name = log "name: " name }
        SaveEmail email ->
            { user | email = log "email: " email }
        SavePassword password ->
            { user | password = log "password: " password }
        Signup ->
            { user | loggedIn = log "logged: " True }

view : User -> Html Msg
view _ =
    Grid.container []
        [ CDN.stylesheet -- css embedded inline. TODO: Remove before deploy
        , Grid.row [ ]
            [ Grid.col [ Col.md6, Col.offsetMd3 ]
                [ h1 [ class "text-center" ] [ text "Sign up"]
                , form []
                    [ group []
                        [ label [ for "name" ] [ text "Name" ]
                        , Input.text [ id "name", onInput SaveName]
                        ]
                    , group []
                        [ label [ for "email" ] [ text "Email" ]
                        , email [ id "email", onInput SaveEmail ]
                        ]
                    , group []
                        [ label [ for "password" ] [ text "Password" ]
                        , password [ id "password", onInput SavePassword ]
                        ]
                    , div [ class "text-center" ]
                        [ button
                            [ onClick Signup, Button.large, Button.primary ]
                            [ text "Create my account" ]
                        ]
                    ]
                ]
            ]
        ]

main : Program () User Msg
main =
  Browser.sandbox { init = init, update = update, view = view }