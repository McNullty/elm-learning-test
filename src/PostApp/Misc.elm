module PostApp.Misc exposing (..)

import PostApp.Types as Types exposing (WebData)
import RemoteData

findPostById : Types.PostId -> WebData (List Types.Post) -> Maybe Types.Post
findPostById postId postsList =
    case RemoteData.toMaybe postsList of
        Just posts ->
            posts
                |> List.filter (\post -> post.id == postId)
                |> List.head

        Nothing ->
            Nothing