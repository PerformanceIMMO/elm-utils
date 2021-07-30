module Perfimmo.Cmd.ActionToCmd exposing (msgToElmCmd)

{-| Launch action in one line

@docs msgToElmCmd
-}

import Task

{-|  Launch action in one line

-}
msgToElmCmd : a -> Cmd a
msgToElmCmd = Task.succeed >> Task.perform identity