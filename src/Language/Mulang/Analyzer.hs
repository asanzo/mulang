module Language.Mulang.Analyzer (
  noSmells,
  allSmells,

  emptyDomainLanguage,
  emptyAnalysisSpec,

  emptyAnalysis,
  domainLanguageAnalysis,
  expectationsAnalysis,
  smellsAnalysis,
  signaturesAnalysis,
  astsGenerationAnalysis,

  analyse,

  module Language.Mulang.Analyzer.Analysis) where

import Language.Mulang
import Language.Mulang.Generator (expressions)
import Language.Mulang.Analyzer.Analysis
import Language.Mulang.Analyzer.SampleParser (parseSample)
import Language.Mulang.Analyzer.SignaturesAnalyzer  (analyseSignatures)
import Language.Mulang.Analyzer.ExpectationsAnalyzer (analyseExpectations)
import Language.Mulang.Analyzer.SmellsAnalyzer (analyseSmells)
import Language.Mulang.Analyzer.DomainLanguageCompiler (emptyDomainLanguage, compileDomainLanguage)
import Data.Maybe (fromMaybe)
--
-- Builder functions
--
noSmells :: SmellsSet
noSmells = NoSmells Nothing

allSmells :: SmellsSet
allSmells = AllSmells Nothing

emptyAnalysisSpec :: AnalysisSpec
emptyAnalysisSpec = AnalysisSpec [] noSmells Nothing Nothing Nothing

emptyAnalysis :: Sample -> Analysis
emptyAnalysis code = Analysis code emptyAnalysisSpec

domainLanguageAnalysis :: Sample -> DomainLanguage -> Analysis
domainLanguageAnalysis code domainLanguage = Analysis code (emptyAnalysisSpec { domainLanguage = Just domainLanguage, smellsSet = allSmells })

expectationsAnalysis :: Sample -> [Expectation] -> Analysis
expectationsAnalysis code es = Analysis code (emptyAnalysisSpec { expectations = es })

smellsAnalysis :: Sample -> SmellsSet -> Analysis
smellsAnalysis code set = Analysis code (emptyAnalysisSpec { smellsSet = set })

signaturesAnalysis :: Sample -> SignatureStyle -> Analysis
signaturesAnalysis code style = Analysis code (emptyAnalysisSpec { signatureAnalysisType = Just (StyledSignatures style) })

astsGenerationAnalysis :: Sample -> AstsGenerationType -> Analysis
astsGenerationAnalysis code generationType = Analysis code (emptyAnalysisSpec { astsGenerationType = Just generationType })
--
-- Analysis running
--
analyse :: Analysis -> IO AnalysisResult
analyse (Analysis sample spec) = analyseSample (parseSample sample)
  where analyseSample (Right ast)    = analyseAst ast spec
        analyseSample (Left message) = return $ AnalysisFailed message

analyseAst :: Expression -> AnalysisSpec -> IO AnalysisResult
analyseAst ast spec = do
  language <- compileDomainLanguage (domainLanguage spec)
  return $ AnalysisCompleted (analyseExpectations ast (expectations spec))
                             (analyseSmells ast language (smellsSet spec))
                             (analyseSignatures ast (signatureAnalysisType spec))
                             (generateAsts ast spec)

generateAsts :: Expression -> AnalysisSpec -> [Expression]
generateAsts ast spec = generateAsts (fromMaybe NoAst (astsGenerationType spec))
  where
    generateAsts NoAst              = []
    generateAsts RootExpressionAst  = [ast]
    generateAsts AllExpressionsAsts = expressions ast
