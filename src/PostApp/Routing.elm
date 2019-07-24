module PostApp.Routing exposing (..)

import Url as Url
import Url.Parser as Parser exposing ((</>))


type Route
    = PostsRoute
    | PostRoute Int
    | NotFoundRoute


extractRoute : Url.Url -> Maybe Route
extractRoute url =
    -- The RealWorld spec treats the fragment like a path.
    -- This makes it *literally* the path, so we can proceed
    -- with parsing as if it had been a normal path all along.
    { url | path = Maybe.withDefault "" url.fragment, fragment = Nothing }
        |> Parser.parse routeParser


routeParser : Parser.Parser (Route -> a) a
routeParser =
    Parser.oneOf
        [ Parser.map PostsRoute Parser.top
        , Parser.map PostsRoute (Parser.s "posts")
        , Parser.map PostRoute (Parser.s "posts" </> Parser.int)
        ]