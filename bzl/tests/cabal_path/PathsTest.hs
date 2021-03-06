-- Copyright 2018 Google LLC
--
-- Licensed under the Apache License, Version 2.0 (the "License");
-- you may not use this file except in compliance with the License.
-- You may obtain a copy of the License at
--
--    https://www.apache.org/licenses/LICENSE-2.0
--
-- Unless required by applicable law or agreed to in writing, software
-- distributed under the License is distributed on an "AS IS" BASIS,
-- WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
-- See the License for the specific language governing permissions and
-- limitations under the License.

module Main where

import qualified Paths_foo
import qualified Paths_bar

import Data.Version (versionBranch)
import System.FilePath ((</>))
import Control.Exception (assert)

main = do
    -- Test getDataDir for a cabal_paths rule with a trivial data_dir.
    fooDir <- Paths_foo.getDataDir
    fooContents <- readFile (fooDir </> "foo.txt")
    assert (fooContents == "foo\n")
        $ assert (versionBranch Paths_foo.version == [1, 2])
        $ return ()
    -- Test getDataDir with a nontrivial data_dir.
    barDir <- Paths_bar.getDataDir
    barContents <- readFile (barDir </> "bar.txt")
    assert (barContents == "bar\n")
        $ assert (versionBranch Paths_bar.version == [3, 4])
        $ return ()
    -- Test getDataFileName.
    fooByName <- Paths_bar.getDataFileName "bar.txt" >>= readFile
    assert (fooByName == "bar\n") $ return ()
