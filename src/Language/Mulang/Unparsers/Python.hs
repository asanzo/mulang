{-# LANGUAGE ViewPatterns #-}

module Language.Mulang.Unparsers.Python (unpy) where
import Language.Mulang.Unparsers (Unparser)
import Language.Mulang.Ast

import Data.List (intercalate)

unpy :: Unparser
unpy = unparse

unparse MuNil                                                         = "None"
unparse (Return body)                                                 = "return " ++ unparse body
unparse (Print exp)                                                   = "print(" ++ unparse exp ++ ")"
unparse (MuNumber n)                                                  = show n
unparse (MuBool b)                                                    = show b
unparse (MuString s)                                                  = show s
unparse (MuList xs)                                                   = "[" ++ unparseMany xs ++ "]"
unparse (Assignment id value)                                         = id ++ " = " ++ unparse value
unparse (Reference id)                                                = id
unparse (Application (Primitive Negation) [bool])                     = "not " ++ unparse bool
unparse (Application (Reference "+") [arg1, arg2])                    = unparse arg1 ++ " + " ++ unparse arg2
unparse (Application (Reference "*") [arg1, arg2])                    = unparse arg1 ++ " * " ++ unparse arg2
unparse (Application (Reference "/") [arg1, arg2])                    = unparse arg1 ++ " / " ++ unparse arg2
unparse (Application (Reference "-") [arg1, arg2])                    = unparse arg1 ++ " - " ++ unparse arg2
unparse (Application (Reference id) args)                             = id ++ "(" ++ unparseMany args ++ ")"
unparse (Sequence xs)                                                 = intercalate "\n" . map unparse $ xs
unparse (While cond body)                                             = "while "++ unparse cond ++ ":\n" ++ (tab . unparse) body
unparse  (For [Generator (TuplePattern [VariablePattern "x"]) generator] None) = "for x in "++ unparse generator ++": pass"
unparse (Raise None)                                                   = "raise"
unparse (Raise arg)                                                    = "raise " ++ unparse arg
unparse (Lambda params body)                                           = "lambda "++ unparseParams params++ ": " ++ unparse body
unparse (MuTuple args)                                                 = "("++ unparseMany args++")"
unparse (Yield value)                                                  = "yield " ++ unparse value
unparse (Class id Nothing body)                                        = "class "++ id ++":\n" ++ (tab . unparse) body
unparse (Class id (Just parent) body)                                  = "class "++ id ++"("++parent++"):\n" ++ (tab . unparse) body
unparse None                                                           = "pass"
unparse (Send receptor (Reference id) args)                            =  unparse receptor ++ "."++ id ++"("++ unparseMany args ++")"
unparse (If cond trueBody falseBody)                                   = "if "++ unparse cond ++":\n"++ (tab . unparse) trueBody ++ "\nelse:\n" ++ (tab . unparse) falseBody
unparse (SimpleFunction id args body)                                 = unparseDef id args body
unparse (SimpleProcedure id args body)                                = unparseDef id args body
unparse other = error . show $ other

unparseDef :: String -> [Pattern] -> Expression -> String
unparseDef id args body = "def "++ id ++"("++ unparseParams args++"):\n" ++ (tab . unparse) body

unparseParams :: [Pattern] -> String
unparseParams = intercalate "," . map unparseParam

unparseParam :: Pattern -> String
unparseParam (VariablePattern id) = id
unparseParam other = error . show $ other


tab :: String -> String
tab = unlines . map ("\t"++) . lines

unparseMany :: [Expression] -> String
unparseMany = intercalate "," . map unparse