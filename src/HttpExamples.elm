module HttpExamples exposing (Model, Msg(..), main, update, url, view, viewNickname)

import Browser exposing (Document)
import Html exposing (Html, button, div, h3, li, text, ul)
import Html.Events exposing (onClick)
import Http exposing (Response)


type alias Model =
    { nicknames: List String
    , errorMessage: Maybe String
    }

type Msg
    = SendHttpRequest
    | DataReceived (Result Http.Error String)

init : flag -> (Model, Cmd Msg)
init _ =
    ( {nicknames = [], errorMessage = Nothing}, Cmd.none )

view : Model -> Document Msg
view model =
    { title = "Http get example"
    , body =
        [ div []
            [ button [ onClick SendHttpRequest ]
                [ text "Get data from server" ]
            , viewNicknamesOrError model
            ]
        ]
    }

viewNicknamesOrError : Model -> Html Msg
viewNicknamesOrError model =
    case model.errorMessage of
        Just message ->
            viewError message

        Nothing ->
            viewNicknames model.nicknames

viewError : String -> Html Msg
viewError errorMessage =
    div []
        [ h3 [] [ text "Couldn't fetch nicknames at this time." ]
        , text ("Error: " ++ errorMessage)
        ]


viewNicknames : List String -> Html Msg
viewNicknames nicknames =
    div []
        [ h3 [] [ text "Old School Main Characters" ]
        , ul [] (List.map viewNickname nicknames)
        ]


viewNickname : String -> Html Msg
viewNickname nickname =
    li [] [ text nickname ]


url : String
url =
    "http://localhost:5016/old-school.txt"
--    "http://localhost:5016/invalid.txt"

createErrorMessage : Http.Error -> String
createErrorMessage httpError =
    case httpError of
        Http.BadUrl message ->
            message

        Http.Timeout ->
            "Server is taking too long to respond. Please try again later."

        Http.NetworkError ->
            "It appears you don't have an Internet connection right now."

        Http.BadStatus response ->
            String.fromInt response

        Http.BadBody response ->
            response

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
            ( {model | nicknames = nicknames}, Cmd.none )

        DataReceived (Err error) ->
            ( {model | errorMessage = Just (createErrorMessage error)}, Cmd.none )


main : Program () Model Msg
main =
    Browser.document
        { init = init
        , view = view
        , update = update
        , subscriptions = \_ -> Sub.none
        }
