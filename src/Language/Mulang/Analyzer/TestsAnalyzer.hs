module Language.Mulang.Analyzer.TestsAnalyzer (
  analyseTests) where

import Language.Mulang
import Language.Mulang.Analyzer.Analysis (TestAnalysisType(..))
import Language.Mulang.Interpreter.Runner (runTests, TestResult(..))

import Data.Maybe (fromMaybe)

analyseTests :: Expression -> Maybe TestAnalysisType -> IO [TestResult]
analyseTests e analysis = analyseTests' e (fromMaybe IgnoreTests analysis)

analyseTests' _ IgnoreTests    = return []
analyseTests' e (RunTests _ _) = return [] -- TODO actually run tests
