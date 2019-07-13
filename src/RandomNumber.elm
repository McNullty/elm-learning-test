module RandomNumber exposing (Model, Msg(..), init, main, update, view)

import Browser exposing (Document)
import Html exposing (Html, button, div, text)
import Html.Events exposing (onClick)
import Platform exposing (Program)
import Random


type alias Model =
    Int


type Msg
    = GenerateRandomNumber
    | NewRandomNumber Int


init : flags -> ( Model, Cmd Msg )
init _ =
    ( 0, Cmd.none )


view : Model -> Document Msg
view model =
    { title = "Random generator page"
    , body =
        [ div []
            [ button [ onClick GenerateRandomNumber ] [ text "Generate Random Number" ]
            , text (String.fromInt model)
            ]
        ]
    }


update : Msg -> Model -> ( Model, Cmd Msg )
update message model =
    case message of
        GenerateRandomNumber ->
            ( model, Random.generate NewRandomNumber (Random.int 0 100) )

        NewRandomNumber number ->
            ( number, Cmd.none )


main : Program () Model Msg
main =
    Browser.document
        { init = init
        , view = view
        , update = update
        , subscriptions = \_ -> Sub.none
        }
