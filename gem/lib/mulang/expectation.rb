module Mulang::Expectation
  SMELLS = %w(
    DiscardsExceptions
    DoesConsolePrint
    DoesNilTest
    DoesNullTest
    DoesTypeTest
    HasAssignmentCondition
    HasAssignmentReturn
    HasCodeDuplication
    HasDeclarationTypos
    HasEmptyIfBranches
    HasEmptyRepeat
    HasEqualIfBranches
    HasLongParameterList
    HasMisspelledBindings
    HasMisspelledIdentifiers
    HasRedundantBooleanComparison
    HasRedundantGuards
    HasRedundantIf
    HasRedundantLambda
    HasRedundantLocalVariableReturn
    HasRedundantParameter
    HasRedundantReduction
    HasRedundantRepeat
    HasTooManyMethods
    HasTooShortBindings
    HasTooShortIdentifiers
    HasUnreachableCode
    HasUsageTypos
    HasWrongCaseBinding
    HasWrongCaseIdentifiers
    IsLongCode
    OverridesEqualOrHashButNotBoth
    ReturnsNil
    ReturnsNull
    ShouldInvertIfCondition
    ShouldUseOtherwise
    ShouldUseStrictComparators
    UsesCut
    UsesFail
    UsesUnificationOperator)

  LOGIC_SMELLS = %w(
    UsesCut
    UsesFail
    UsesUnificationOperator
    HasRedundantReduction)

  FUNCTIONAL_SMELLS = %w(
    HasRedundantParameter
    HasRedundantGuards)

  OBJECT_ORIENTED_SMELLS = %w(
    DoesNullTest
    ReturnsNull)

  IMPERATIVE_SMELLS = %w(
    HasRedundantLocalVariableReturn
    HasAssignmentReturn)

  EXPRESSIVENESS_SMELLS = %w(
    HasTooShortIdentifiers
    HasWrongCaseIdentifiers
    HasMisspelledIdentifiers)

  GENERIC_SMELLS = %w(
    IsLongCode
    HasCodeDuplication
    HasRedundantLambda
    HasRedundantIf
    DoesTypeTest
    HasRedundantBooleanComparison
    HasEmptyIfBranches)


  def self.guess_type(expectation)
    if expectation[:binding] == '<<custom>>'
      Custom
    elsif expectation[:inspection] =~ /(Not\:)?Has.*/ && !has_smell?(expectation[:inspection])
      V0
    else
      V2
    end
  end

  def self.has_smell?(smell)
    SMELLS.include? smell.split(':').first
  end

  def self.parse(expectation)
    guess_type(expectation).parse(expectation)
  end

  def self.valid?(expectation)
    guess_type(expectation).valid?(expectation)
  end
end

require_relative './expectation/i18n'
require_relative './expectation/custom'
require_relative './expectation/standard'
