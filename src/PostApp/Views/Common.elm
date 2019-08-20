module PostApp.Views.Common exposing (showNetworkOperation)

import Bootstrap.Spinner as Spinner
import Html exposing (Html, div)
import PostApp.Types exposing (Model, Msg)
import RemoteData


showNetworkOperation : Model -> Html Msg
showNetworkOperation model =
    case model.networkOperation of
        RemoteData.Loading ->
            div []
                [Spinner.spinner [] []]
        _ ->
            div []
                []