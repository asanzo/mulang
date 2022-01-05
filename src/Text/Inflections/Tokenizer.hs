module Text.Inflections.Tokenizer (
  CaseStyle,
  camelCase,
  snakeCase,
  rubyCase,
  canTokenize,
  tokenize) where

import Data.Char (toLower, isDigit, isLower)
import Data.Either (isRight)

import Text.Inflections
import Text.Inflections.Parse.Types
import Text.Parsec.Error (ParseError)

import Control.Fallible

type CaseStyle = String -> Either Text.Parsec.Error.ParseError [Text.Inflections.Parse.Types.Word]

camelCase      :: CaseStyle
camelCase      = parseCamelCase [] . filter (not.isDigit)

snakeCase      :: CaseStyle
snakeCase      = parseSnakeCase []

rubyCase       :: CaseStyle
rubyCase word@(i:_) | i == '_' = snakeCase . unprivatize $ baseWord
                    | isLower i = snakeCase baseWord
                    | otherwise = camelCase baseWord

                    where

                      baseWord = filter (`notElem` "!?+-=[]<>|&*/") word

                      unprivatize = unprivatizeRight . unprivatizeLeft

                      unprivatizeLeft ('_':'_':xs) = xs
                      unprivatizeLeft ('_':xs)     = xs
                      unprivatizeLeft xs           = xs

                      unprivatizeRight = reverse .  unprivatizeLeft . reverse

canTokenize :: CaseStyle -> String -> Bool
canTokenize style = isRight . style

tokenize :: CaseStyle -> String -> [String]
tokenize style s | Just words <- (wordsOrNothing . style) s = concatMap toToken words
                 | otherwise = []
                  where toToken = return . map toLower


wordsOrNothing = fmap (concatMap c) . orNothing
                where c (Word w) = [w]
                      c _        = []
