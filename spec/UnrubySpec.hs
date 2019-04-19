module UnrubySpec (spec) where

import           Test.Hspec
import           Language.Mulang

import           Language.Mulang.Unparsers.Ruby (unrb)

spec :: Spec
spec = do
  describe "unrb" $ do
    let itWorksWith expr expectedCode = it (show expr) (unrb expr `shouldBe` expectedCode)

    describe "literals" $ do
      itWorksWith (MuNumber 1.0) "1.0"
      itWorksWith (MuNumber 1) "1"
      itWorksWith MuTrue "true"
      itWorksWith MuFalse "false"
      itWorksWith (MuString "some string") "\"some string\""
      itWorksWith (MuList [MuNumber 1.0, MuNumber 2.0, MuNumber 3.0]) "[1.0,2.0,3.0]"

    itWorksWith (Assignment "one" (MuNumber 1.0)) "one = 1.0"
    itWorksWith ((Reference "x")) "x"
    itWorksWith ((Application (Reference "f") [MuNumber 2.0])) "f(2.0)"
    itWorksWith ((Send (Reference "o") (Reference "f") [(MuNumber 2)])) "o.f(2.0)"
    itWorksWith ((Assignment "x" (Application (Reference "+") [Reference "x",MuNumber 8.0]))) "x = (x + 8.0)"
    itWorksWith ((Application (Reference "+") [Reference "x",Reference "y"])) "(x + y)"
    itWorksWith (Sequence [MuNumber 1, MuNumber 2, MuNumber 3]) "1.0\n2.0\n3.0"
    itWorksWith ((Application (Primitive Negation) [MuTrue])) "(!true)"

    describe "classes" $ do
      itWorksWith (Class "DerivedClassName" Nothing None) "class DerivedClassName\nend\n"
      itWorksWith (Class "DerivedClassName" (Just "BaseClassName") None) "class DerivedClassName < BaseClassName\nend\n"

    itWorksWith (If MuTrue (MuNumber 1.0) (MuNumber 3.0)) "if true\n\t1.0\nelse\n\t3.0\nend\n"

    describe "functions and procedures" $ do
      itWorksWith (SimpleFunction "foo" [] (Return (MuNumber 1.0))) "def foo()\n\treturn 1.0\nend\n"
      itWorksWith (SimpleFunction "foo" [VariablePattern "x"] (Return (Reference "x"))) "def foo(x)\n\treturn x\nend\n"
      itWorksWith (SimpleProcedure "foo" [] (Print (Reference "param"))) "def foo()\n\tputs(param)\nend\n"
      itWorksWith (SimpleProcedure "foo" [VariablePattern "param"] (Print (Reference "param"))) "def foo(param)\n\tputs(param)\nend\n"

    describe "while" $ do
      itWorksWith (While MuTrue None) "while true\nend\n"
      itWorksWith (While MuTrue (Print (MuString "hi"))) "while true\n\tputs(\"hi\")\nend\n"

    describe "raise" $ do
      itWorksWith (Raise None) "raise"
      itWorksWith (Raise (MuString "something")) "raise \"something\""

    describe "lambda" $ do
      itWorksWith (Lambda [VariablePattern "x"] (Reference "x")) "lambda { |x| x }"
      itWorksWith (Lambda [VariablePattern "x", VariablePattern "y"] (MuNumber 1)) "lambda { |x,y| 1.0 }"
      itWorksWith (Lambda [] MuNil) "lambda { || nil }"

    itWorksWith (Yield (MuNumber 1.0)) "yield 1.0"
    itWorksWith MuNil "nil"

    describe "boolean operations" $ do
      let muand x y = (Application (Primitive And) [x, y])
      let muor  x y = (Application (Primitive Or) [x, y])
      let muneg x = (Application (Primitive Negation) [x])

      itWorksWith ((Reference "a") `muand` (Reference "b")) "(a && b)"
      itWorksWith ((Reference "a") `muor` (Reference "b")) "(a || b)"
      itWorksWith ((muneg (Reference "a")) `muor` (Reference "b")) "((!a) || b)"
      itWorksWith (muneg ((Reference "a") `muor` (Reference "b"))) "(!(a || b))"
      itWorksWith (muneg ((Reference "a") `muand` (Reference "b")) `muor` (Reference "c")) "((!(a && b)) || c)"
      itWorksWith ((Reference "a") `muand` ((Reference "b") `muor` (Reference "c"))) "(a && (b || c))"
