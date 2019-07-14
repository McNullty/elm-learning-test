module PostApp.Types exposing (..)

import Http exposing (Response)
import RemoteData exposing (RemoteData)

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
    }


type alias WebData a =
    RemoteData Http.Error a


type Msg
    = FetchPosts
    | DataReceived (WebData (List Post))