module Perfimmo.Cmd.ActionToCmd exposing (msgToElmCmd)

{-
Launch action in one line
-}

import Task

msgToElmCmd : a -> Cmd a
msgToElmCmd = Task.succeed >> Task.perform identity