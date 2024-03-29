module EventListener exposing (Model, Msg(..), init, main, subscriptions, update, view)

import Browser exposing (Document)
import Browser.Events exposing (onClick, onKeyPress)
import Html exposing (div, text)
import Json.Decode exposing (succeed)


type alias Model =
    Int


type Msg
    = KeyPressed
    | MouseClicked


init : flags -> ( Model, Cmd Msg )
init _ =
    ( 0, Cmd.none )


view : Model -> Document Msg
view model =
    { title = "Keyboard listener"
    , body =
        [ div []
            [ text (String.fromInt model)
            ]
        ]
    }


update : Msg -> Model -> ( Model, Cmd Msg )
update message model =
    case message of
        KeyPressed ->
            ( model + 1, Cmd.none )

        MouseClicked ->
            ( model - 1, Cmd.none )


subscriptions : Model -> Sub Msg
subscriptions _ =
    Sub.batch
        [ onKeyPress (succeed KeyPressed)
        , onClick (succeed MouseClicked)
        ]


main : Program () Model Msg
main =
    Browser.document
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }
