module PostApp.Types exposing (..)

import Browser
import Browser.Navigation exposing (Key)
import Http exposing (Response)
import PostApp.Routing exposing (Route)
import RemoteData exposing (RemoteData)
import Url exposing (Url)

type alias Author =
    { name : String
    , url : String
    }


type alias Post =
    { id : Int
    , title : String
    , author : Author
    }


type alias Model =
    { posts: WebData (List Post)
    , key: Key
    , route: Route
    }


type alias WebData a =
    RemoteData Http.Error a

type alias PostId =
    Int

type Msg
    = FetchPosts
    | DataReceived (WebData (List Post))
    | UrlChanged Url
    | LinkClicked Browser.UrlRequest
    | UpdateTitle PostId String
    | UpdateAuthorName PostId String
    | UpdateAuthorUrl PostId String