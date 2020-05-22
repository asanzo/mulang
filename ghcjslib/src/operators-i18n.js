(() => {
  const OPERATORS_LOCALES = {
    en: {
      UsesAnd: (binding, must, target, tokens) => `${binding} ${must} use <code>${operator_And}</code>`,
      UsesBackwardComposition: (binding, must, target, tokens) => `${binding} ${must} use <code>${operator_BackwardComposition}</code>`,
      UsesBitwiseAnd: (binding, must, target, tokens) => `${binding} ${must} use <code>${operator_BitwiseAnd}</code>`,
      UsesBitwiseLeftShift: (binding, must, target, tokens) => `${binding} ${must} use <code>${operator_BitwiseLeftShift}</code>`,
      UsesBitwiseOr: (binding, must, target, tokens) => `${binding} ${must} use <code>${operator_BitwiseOr}</code>`,
      UsesBitwiseRightShift: (binding, must, target, tokens) => `${binding} ${must} use <code>${operator_BitwiseRightShift}</code>`,
      UsesBitwiseXor: (binding, must, target, tokens) => `${binding} ${must} use <code>${operator_BitwiseXor}</code>`,
      UsesDivide: (binding, must, target, tokens) => `${binding} ${must} use <code>${operator_Divide}</code>`,
      UsesEqual: (binding, must, target, tokens) => `${binding} ${must} use <code>${operator_Equal}</code>`,
      UsesForwardComposition: (binding, must, target, tokens) => `${binding} ${must} use <code>${operator_ForwardComposition}</code>`,
      UsesGreatherOrEqualThan: (binding, must, target, tokens) => `${binding} ${must} use <code>${operator_GreatherOrEqualThan}</code>`,
      UsesGreatherThan: (binding, must, target, tokens) => `${binding} ${must} use <code>${operator_GreatherThan}</code>`,
      UsesHash: (binding, must, target, tokens) => `${binding} ${must} use <code>${operator_Hash}</code>`,
      UsesLessOrEqualThan: (binding, must, target, tokens) => `${binding} ${must} use <code>${operator_LessOrEqualThan}</code>`,
      UsesLessThan: (binding, must, target, tokens) => `${binding} ${must} use <code>${operator_LessThan}</code>`,
      UsesMinus: (binding, must, target, tokens) => `${binding} ${must} use <code>${operator_Minus}</code>`,
      UsesModulo: (binding, must, target, tokens) => `${binding} ${must} use <code>${operator_Modulo}</code>`,
      UsesMultiply: (binding, must, target, tokens) => `${binding} ${must} use <code>${operator_Multiply}</code>`,
      UsesNegation: (binding, must, target, tokens) => `${binding} ${must} use <code>${operator_Negation}</code>`,
      UsesNotEqual: (binding, must, target, tokens) => `${binding} ${must} use <code>${operator_NotEqual}</code>`,
      UsesOr: (binding, must, target, tokens) => `${binding} ${must} use <code>${operator_Or}</code>`,
      UsesOtherwise: (binding, must, target, tokens) => `${binding} ${must} use <code>${operator_Otherwise}</code>`,
      UsesPlus: (binding, must, target, tokens) => `${binding} ${must} use <code>${operator_Plus}</code>`,
    },
    es: {
      UsesAnd: (binding, must, target, tokens) => `${binding} ${must} utilizar <code>${operator_And}</code>`,
      UsesBackwardComposition: (binding, must, target, tokens) => `${binding} ${must} utilizar <code>${operator_BackwardComposition}</code>`,
      UsesBitwiseAnd: (binding, must, target, tokens) => `${binding} ${must} utilizar <code>${operator_BitwiseAnd}</code>`,
      UsesBitwiseLeftShift: (binding, must, target, tokens) => `${binding} ${must} utilizar <code>${operator_BitwiseLeftShift}</code>`,
      UsesBitwiseOr: (binding, must, target, tokens) => `${binding} ${must} utilizar <code>${operator_BitwiseOr}</code>`,
      UsesBitwiseRightShift: (binding, must, target, tokens) => `${binding} ${must} utilizar <code>${operator_BitwiseRightShift}</code>`,
      UsesBitwiseXor: (binding, must, target, tokens) => `${binding} ${must} utilizar <code>${operator_BitwiseXor}</code>`,
      UsesDivide: (binding, must, target, tokens) => `${binding} ${must} utilizar <code>${operator_Divide}</code>`,
      UsesEqual: (binding, must, target, tokens) => `${binding} ${must} utilizar <code>${operator_Equal}</code>`,
      UsesForwardComposition: (binding, must, target, tokens) => `${binding} ${must} utilizar <code>${operator_ForwardComposition}</code>`,
      UsesGreatherOrEqualThan: (binding, must, target, tokens) => `${binding} ${must} utilizar <code>${operator_GreatherOrEqualThan}</code>`,
      UsesGreatherThan: (binding, must, target, tokens) => `${binding} ${must} utilizar <code>${operator_GreatherThan}</code>`,
      UsesHash: (binding, must, target, tokens) => `${binding} ${must} utilizar <code>${operator_Hash}</code>`,
      UsesLessOrEqualThan: (binding, must, target, tokens) => `${binding} ${must} utilizar <code>${operator_LessOrEqualThan}</code>`,
      UsesLessThan: (binding, must, target, tokens) => `${binding} ${must} utilizar <code>${operator_LessThan}</code>`,
      UsesMinus: (binding, must, target, tokens) => `${binding} ${must} utilizar <code>${operator_Minus}</code>`,
      UsesModulo: (binding, must, target, tokens) => `${binding} ${must} utilizar <code>${operator_Modulo}</code>`,
      UsesMultiply: (binding, must, target, tokens) => `${binding} ${must} utilizar <code>${operator_Multiply}</code>`,
      UsesNegation: (binding, must, target, tokens) => `${binding} ${must} utilizar <code>${operator_Negation}</code>`,
      UsesNotEqual: (binding, must, target, tokens) => `${binding} ${must} utilizar <code>${operator_NotEqual}</code>`,
      UsesOr: (binding, must, target, tokens) => `${binding} ${must} utilizar <code>${operator_Or}</code>`,
      UsesOtherwise: (binding, must, target, tokens) => `${binding} ${must} utilizar <code>${operator_Otherwise}</code>`,
      UsesPlus: (binding, must, target, tokens) => `${binding} ${must} utilizar <code>${operator_Plus}</code>`,
    },
    pt: {
      UsesAnd: (binding, must, target, tokens) => `${binding} ${must} utilizar <code>${operator_And}</code>`,
      UsesBackwardComposition: (binding, must, target, tokens) => `${binding} ${must} utilizar <code>${operator_BackwardComposition}</code>`,
      UsesBitwiseAnd: (binding, must, target, tokens) => `${binding} ${must} utilizar <code>${operator_BitwiseAnd}</code>`,
      UsesBitwiseLeftShift: (binding, must, target, tokens) => `${binding} ${must} utilizar <code>${operator_BitwiseLeftShift}</code>`,
      UsesBitwiseOr: (binding, must, target, tokens) => `${binding} ${must} utilizar <code>${operator_BitwiseOr}</code>`,
      UsesBitwiseRightShift: (binding, must, target, tokens) => `${binding} ${must} utilizar <code>${operator_BitwiseRightShift}</code>`,
      UsesBitwiseXor: (binding, must, target, tokens) => `${binding} ${must} utilizar <code>${operator_BitwiseXor}</code>`,
      UsesDivide: (binding, must, target, tokens) => `${binding} ${must} utilizar <code>${operator_Divide}</code>`,
      UsesEqual: (binding, must, target, tokens) => `${binding} ${must} utilizar <code>${operator_Equal}</code>`,
      UsesForwardComposition: (binding, must, target, tokens) => `${binding} ${must} utilizar <code>${operator_ForwardComposition}</code>`,
      UsesGreatherOrEqualThan: (binding, must, target, tokens) => `${binding} ${must} utilizar <code>${operator_GreatherOrEqualThan}</code>`,
      UsesGreatherThan: (binding, must, target, tokens) => `${binding} ${must} utilizar <code>${operator_GreatherThan}</code>`,
      UsesHash: (binding, must, target, tokens) => `${binding} ${must} utilizar <code>${operator_Hash}</code>`,
      UsesLessOrEqualThan: (binding, must, target, tokens) => `${binding} ${must} utilizar <code>${operator_LessOrEqualThan}</code>`,
      UsesLessThan: (binding, must, target, tokens) => `${binding} ${must} utilizar <code>${operator_LessThan}</code>`,
      UsesMinus: (binding, must, target, tokens) => `${binding} ${must} utilizar <code>${operator_Minus}</code>`,
      UsesModulo: (binding, must, target, tokens) => `${binding} ${must} utilizar <code>${operator_Modulo}</code>`,
      UsesMultiply: (binding, must, target, tokens) => `${binding} ${must} utilizar <code>${operator_Multiply}</code>`,
      UsesNegation: (binding, must, target, tokens) => `${binding} ${must} utilizar <code>${operator_Negation}</code>`,
      UsesNotEqual: (binding, must, target, tokens) => `${binding} ${must} utilizar <code>${operator_NotEqual}</code>`,
      UsesOr: (binding, must, target, tokens) => `${binding} ${must} utilizar <code>${operator_Or}</code>`,
      UsesOtherwise: (binding, must, target, tokens) => `${binding} ${must} utilizar <code>${operator_Otherwise}</code>`,
      UsesPlus: (binding, must, target, tokens) => `${binding} ${must} utilizar <code>${operator_Plus}</code>`,
    }
  }
  ghcjsExports.I18n.OPERATORS_LOCALES = OPERATORS_LOCALES;
})();
