module HttpExamples exposing (Model, Msg(..), main, update, url, view, viewNickname)

import Browser exposing (Document)
import Html exposing (Html, button, div, h3, li, text, ul)
import Html.Events exposing (onClick)
import Http


type alias Model =
    List String


type Msg
    = SendHttpRequest
    | DataReceived (Result Http.Error String)


view : Model -> Document Msg
view model =
    { title = "Http get example"
    , body =
        [ div []
            [ button [ onClick SendHttpRequest ]
                [ text "Get data from server" ]
            , h3 [] [ text "Old School Main Characters" ]
            , ul [] (List.map viewNickname model)
            ]
        ]
    }


viewNickname : String -> Html Msg
viewNickname nickname =
    li [] [ text nickname ]


url : String
url =
    "http://localhost:5016/old-school.txt"


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        SendHttpRequest ->
            ( model, Http.get { url = url, expect = Http.expectString DataReceived } )

        DataReceived (Ok nicknamesStr) ->
            let
                nicknames =
                    String.split "," nicknamesStr
            in
            ( nicknames, Cmd.none )

        DataReceived (Err _) ->
            ( [ "Error" ], Cmd.none )


main : Program () Model Msg
main =
    Browser.document
        { init = \_ -> ( [], Cmd.none )
        , view = view
        , update = update
        , subscriptions = \_ -> Sub.none
        }
