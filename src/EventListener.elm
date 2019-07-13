module EventListener exposing (..)

import Browser exposing (Document)
import Browser.Events exposing (onClick, onKeyPress)
import Html exposing (div, text)
import Json.Decode as Decode exposing (succeed)

type alias  Model = Int

type Msg
    = KeyPressed
    | MouseClicked

init : flags -> ( Model, Cmd Msg )
init _ =
    ( 0, Cmd.none )

view : Model -> Document Msg
view model =
    { title = "Keyboard listener"
    , body = [ div []
                [ text (String.fromInt model)
                ]
             ]
    }

update : Msg -> Model -> ( Model, Cmd Msg )
update message model =
    case message of
        KeyPressed -> ( model + 1, Cmd.none )
        MouseClicked -> ( model - 1, Cmd.none )

keyDecoder : Decode.Decoder Msg
keyDecoder =
  Decode.map toMsg (Decode.field "key" Decode.string)

toMsg : String -> Msg
toMsg _ =
  KeyPressed

subscriptions : Model -> Sub Msg
subscriptions _ =
    Sub.batch
    [ onKeyPress keyDecoder
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