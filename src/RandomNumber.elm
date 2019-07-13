module RandomNumber exposing (..)

import Browser exposing (Document)
import Html exposing (Html, button, div, text)
import Platform exposing (Program)

type alias Model = Int

init : flags -> ( Model, Cmd msg )
init _ =
    ( 0, Cmd.none )

view : Model -> Document msg
view model =
    { title = ""
    , body = [ div []
                [ button [] [ text "Generate Random Number" ]
                , text (String.fromInt model)
                ]
             ]
    }

update : msg -> Model -> ( Model, Cmd msg )
update _ _ =
    ( 0, Cmd.none )

main : Program () Model msg
main =
  Browser.document
  { init = init
  , view = view
  , update = update
  , subscriptions = (\_ -> Sub.none)
  }