module Signup exposing (..)

import Browser
import Html exposing (Html, button, div, form, h1, input, text)
import Html.Attributes exposing (id, type_)

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
    div []
        [ h1 [] [ text "Sign up"]
        , form []
            [ div []
                [ text "Name"
                , input
                    [ id "name"
                    , type_ "text"
                    ]
                    []
                ]
            , div []
                [ text "Email"
                , input
                    [ id "email"
                    , type_ "email"
                    ]
                    []
                ]
            , div []
                [ text "Password"
                , input
                    [ id "password"
                    , type_ "password"
                    ]
                    []
                ]
            , div []
                [ button
                    [ type_ "submit" ]
                    [ text "Create my account" ]
                ]
            ]
        ]

main : Program () User msg
main =
  Browser.sandbox { init = init, update = update, view = view }