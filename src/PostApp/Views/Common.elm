module PostApp.Views.Common exposing (showNetworkOperation)

import Bootstrap.Spinner as Spinner
import Html exposing (Html, br, div)
import PostApp.Types exposing (Model, Msg, NetworkOperations(..))


showNetworkOperation : Model -> Html Msg
showNetworkOperation model =
    case model.networkOperation of
        Loading ->
            div []
                [ br [] []
                , Spinner.spinner [] []]
        Done ->
            div []
                []