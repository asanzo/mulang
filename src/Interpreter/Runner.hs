module Interpreter.Runner where

import           Control.Monad (forM)
import           Control.Monad.State.Class
import           Control.Monad.State.Strict
import           Control.Monad.Cont (callCC)
import           Data.Maybe (fromMaybe, fromJust)
import           Data.List (intercalate)

import qualified Language.Mulang as Mu
import Language.Mulang.Parsers.JavaScript (parseJavaScript)
import Interpreter.Mulang
import Interpreter.Mulang.Tests


data TestResult = Success
                | Failure String
                deriving (Show, Eq)

runTestsForDir :: String -> String -> IO ()
runTestsForDir solutionPath testPath = do
  solution <- fromJust <$> parseJavaScript <$> readFile solutionPath
  tests <- getTests <$> fromJust <$> parseJavaScript <$> readFile testPath
  results <- runTests solution tests
  forM_ results $ \result -> case result of
    (desc, Success) -> do
      putStrLn $ "PASS : " ++ intercalate " > " desc
    (desc, Failure reason) -> do
      putStrLn $ "FAIL : " ++ intercalate " > " desc
      putStrLn $ "       " ++ show reason

runTests :: Mu.Expression -> [MuTest] -> IO [([String], TestResult)]
runTests expr tests = do
  (_ref, context) <- eval defaultContext expr
  forM tests $ \(MuTest desc testExpr) -> do
    (exceptionRef, testContext) <- eval' context $ do
      _ <- callCC $ \raiseCallback -> do
        put (context { currentRaiseCallback = raiseCallback })
        evalExpr testExpr
        return nullRef
      fromMaybe nullRef <$> gets currentException
    let exception = dereference' (globalObjects testContext) exceptionRef
    case exception of
      MuNull -> return (desc, Success)
      v -> return (desc, Failure $ show v)

