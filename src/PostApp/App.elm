module PostApp.App exposing (..)

import Browser
import Platform exposing (Program)
import PostApp.State as State
import PostApp.Types exposing (..)
import PostApp.View as View

main : Program () Model Msg
main =
    Browser.application
        { init = State.init
        , view = View.view
        , update = State.update
        , subscriptions = \_ -> Sub.none
        , onUrlRequest = LinkClicked
        , onUrlChange = UrlChanged
        }