module PostApp.Views.List exposing (view)

import Bootstrap.Alert as Alert
import Bootstrap.Button as Button exposing (button, onClick)
import Bootstrap.Spinner as Spinner
import Bootstrap.Table as Table exposing (Row, THead)
import Html exposing (Html, br, div, h3, text)
import Html.Attributes exposing (href)
import Http
import PostApp.Types exposing (..)
import PostApp.Views.Common exposing (showNetworkOperation)
import RemoteData

view : Model -> Html Msg
view model =
    div []
        [ button [ onClick FetchPosts, Button.large, Button.primary ]
            [ text "Refresh posts" ]
        , br [] []
        , br [] []
        , Alert.link [href "/posts/new"] [text "Create new post"]
        , br [] []
        , br [] []
        , viewPostsOrError model
        , showNetworkOperation model
        ]

viewPostsOrError : Model -> Html Msg
viewPostsOrError model =
    case model.posts of
        RemoteData.NotAsked ->
            text ""

        RemoteData.Loading ->
            div []
                [Spinner.spinner [] []]

        RemoteData.Failure httpError ->
            viewError (createErrorMessageFromHttpError httpError)

        RemoteData.Success posts ->
            div []
                [ viewPosts posts]


viewError : String -> Html Msg
viewError errorMessage =
    let
        errorHeading =
            "Couldn't fetch data at this time."
    in
        div []
            [ h3 [] [ text errorHeading ]
            , text ("Error: " ++ errorMessage)
            ]


viewPosts : List Post -> Html Msg
viewPosts posts =
    div []
        [ h3 [] [ text "Posts" ]
        , Table.simpleTable
            ( viewTableHeader
            , Table.tbody []
                (List.map viewPost posts)
            )
        ]


viewTableHeader : THead Msg
viewTableHeader =
    Table.simpleThead
        [ Table.th [] [ text "ID" ]
        , Table.th [] [ text "Title" ]
        , Table.th [] [ text "Author" ]
        ]


viewPost : Post -> Row Msg
viewPost post =
    let
        postPath =
            "/posts/" ++ (String.fromInt post.id)
    in
        Table.tr []
            [ Table.td []
                [ text (String.fromInt post.id) ]
            , Table.td []
                [ text post.title ]
            , Table.td []
                [ Alert.link [ href post.author.url ] [ text post.author.name ] ]
            , Table.td []
                [ Alert.link [ href postPath] [text "Edit"]]
            , Table.td []
                [ button [onClick (DeletePost post.id), Button.large, Button.primary ] [text "Delete"]]
            ]


createErrorMessageFromHttpError : Http.Error -> String
createErrorMessageFromHttpError httpError =
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
