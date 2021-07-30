module Perfimmo.Cmd.ActionToCmd exposing (..)

import Task

msgToElmCmd : a -> Cmd a
msgToElmCmd = Task.succeed >> Task.perform identity