module PostApp.App exposing (..)

import Browser
import Platform exposing (Program)
import PostApp.State as State exposing (receiveData)
import PostApp.Types exposing (..)
import PostApp.View as View

subscriptions : Model -> Sub Msg
subscriptions _ =
    receiveData ReceivedDataFromJS

main : Program () Model Msg
main =
    Browser.application
        { init = State.init
        , view = View.view
        , update = State.updateWithStorage
        , subscriptions = subscriptions
        , onUrlRequest = LinkClicked
        , onUrlChange = UrlChanged
        }