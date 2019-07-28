module PostApp.Views.List exposing (view)

import Html exposing (Html, a, button, div, h3, table, td, text, th, tr)
import Html.Attributes exposing (href)
import Html.Events exposing (onClick)
import Http
import PostApp.Types exposing (..)
import RemoteData

view : Model -> Html Msg
view model =
    div []
        [ button [ onClick FetchPosts ]
            [ text "Refresh posts" ]
        , viewPostsOrError model
        ]

viewPostsOrError : Model -> Html Msg
viewPostsOrError model =
    case model.posts of
        RemoteData.NotAsked ->
            text ""

        RemoteData.Loading ->
            text "Loading..."

        RemoteData.Failure httpError ->
            viewError (createErrorMessageFromHttpError httpError)

        RemoteData.Success posts ->
            viewPosts posts


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
        , table []
            ([ viewTableHeader ] ++ List.map viewPost posts)
        ]


viewTableHeader : Html Msg
viewTableHeader =
    tr []
        [ th []
            [ text "ID" ]
        , th []
            [ text "Title" ]
        , th []
            [ text "Author" ]
        ]


viewPost : Post -> Html Msg
viewPost post =
    let
        postPath =
            "/posts/" ++ (String.fromInt post.id)
    in
        tr []
            [ td []
                [ text (String.fromInt post.id) ]
            , td []
                [ text post.title ]
            , td []
                [ a [ href post.author.url ] [ text post.author.name ] ]
            , td []
                [ a [ href postPath] [text "Edit"]]
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
