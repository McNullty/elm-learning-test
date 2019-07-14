module PostApp.App exposing (..)

import Browser
import Platform exposing (Program)
import PostApp.State as State
import PostApp.Types exposing (..)
import PostApp.Views.List as List

main : Program () Model Msg
main =
    Browser.document
        { init = State.init
        , view = List.view
        , update = State.update
        , subscriptions = \_ -> Sub.none
        }