module Signup exposing (..)

import Bootstrap.Button as Button exposing (button)
import Bootstrap.Form exposing (form, group, label)
import Bootstrap.Form.Input as Input exposing (email, id, password)
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
    div [ class "container" ]
        [ h1 [] [ text "Sign up"]
        , form []
            [ group []
                [ label [ for "name"] [ text "Name" ]
                , Input.text [ id "name" ]
                ]
            , group []
                [ label [ for "email"] [ text "Email" ]
                , email [ id "email" ]
                ]
            , group []
                [ label [ for "password"] [ text "Password" ]
                , password [ id "password" ]
                ]
            , group []
                [ button
                    [ Button.primary ]
                    [ text "Create my account" ]
                ]
            ]
        ]

main : Program () User msg
main =
  Browser.sandbox { init = init, update = update, view = view }