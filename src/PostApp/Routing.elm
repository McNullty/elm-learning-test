module PostApp.Routing exposing (Route(..), fromUrl)

import Browser.Navigation as Nav
import Url as Url
import Url.Builder as Builder
import Url.Parser as Parser exposing ((</>))


type Route
    = PostsRoute
    | PostRoute Int
    | NotFoundRoute


fromUrl : Url.Url -> Route
fromUrl url =
    Maybe.withDefault NotFoundRoute (Parser.parse parser url)


parser : Parser.Parser (Route -> a) a
parser =
    Parser.oneOf
        [ Parser.map PostsRoute Parser.top
        , Parser.map PostsRoute (Parser.s "posts")
        , Parser.map PostRoute (Parser.s "posts" </> Parser.int)
        ]


changeUrl : Nav.Key -> Route -> Cmd msg
changeUrl key route =
    Nav.replaceUrl key (toString route)


pushUrl : Nav.Key -> Route -> Cmd msg
pushUrl key route =
    Nav.pushUrl key (toString route)


toString : Route -> String
toString route =
    case route of
        PostsRoute ->
            Builder.relative [ "/posts" ] []

        PostRoute postId->
            Builder.relative [ "/posts", String.fromInt postId ] []

        NotFoundRoute ->
            "not-found"