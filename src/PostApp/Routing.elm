module PostApp.Routing exposing (Route(..), fromUrl)

import Url as Url
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