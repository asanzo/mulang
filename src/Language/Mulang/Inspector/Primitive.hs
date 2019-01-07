module Language.Mulang.Inspector.Primitive (
  containsExpression,
  containsDeclaration,
  containsBody,
  matchesType,
  Inspection) where

import           Language.Mulang.Ast
import           Language.Mulang.Identifier (IdentifierPredicate)
import           Language.Mulang.Generator (expressions, equationBodies, declarations)

import           Data.List.Extra (has)

type Inspection = Expression -> Bool

containsExpression :: (Expression -> Bool) -> Inspection
containsExpression f = has f expressions

containsBody :: (EquationBody -> Bool)-> Inspection
containsBody f = has f equationBodies

containsDeclaration :: (Expression -> Bool) -> Inspection
containsDeclaration f = has f declarations

matchesType :: IdentifierPredicate -> Pattern -> Bool
matchesType predicate (TypePattern n)               = predicate n
matchesType predicate (AsPattern _ (TypePattern n)) = predicate n
matchesType predicate (UnionPattern patterns)       = any (matchesType predicate) patterns
matchesType _         _                             = False
