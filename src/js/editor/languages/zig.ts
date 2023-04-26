const zig = {
  keywords: [
    'const', 'pub', 'fn', 'comptime', 'break', 'return', 'continue', 'while',
    'for', 'if', 'else', 'switch', 'union', 'enum', 'struct', 'use',
    'defer', 'try', 'catch', 'throw', 'error', 'usingnamespace', 'export',
    'extern', 'packed', 'align', 'switcherr', 'unreachable', 'var',

    // Built-in functions
    'anyframe', 'asm',  'cmpxchg', 'cImport', 'cInclude', 'comptimeCall',
    'errSetCast', 'errorName', 'errorReturnTrace', 'errorToInt', 'export',
    'fence', 'frame', 'frameAddress', 'import', 'intToError', 'offsetof',
    'setAlignStack', 'setCold', 'setEvalBranchQuota', 'setFloatMode',
    'setRuntimeSafety', 'shlExact', 'shrExact', 'sub', 'aligncast',
  ],

  typeKeywords: [
    'bool', 'u0', 'i0', 'u1', 'i1', 'u8', 'i8', 'u16', 'i16', 'u32', 'i32', 'u64', 'i64', 'u128',
    'i128', 'usize', 'isize', 'c_short', 'c_ushort', 'c_int', 'c_uint', 'c_long',
    'c_ulong', 'c_longlong', 'c_ulonglong', 'c_longdouble', 'c_void',
    'f16', 'f32', 'f64', 'f128', 'noreturn', 'type', 'anyerror', 'void'
  ],

  operators: [
    '=', '==', '!=', '>', '>=', '<', '<=', '|', '&', '||', '&&', '^', '<<',
    '>>', '+', '-', '++', '--', '*', '/', '%', '!', '~', '..', '...', '=>',
    '@', '?', ':'
  ],

  symbols:  /[=><!~?:&|+\-*\/\^%]+/,

  escapes: /\\(?:[abfnrtv\\"']|x[0-9A-Fa-f]{1,4}|u[0-9A-Fa-f]{4}|U[0-9A-Fa-f]{8})/,

  tokenizer: {
    root: [
      [/\/\/.*$/, 'comment'],
      [/"([^"\\]|\\.)*$/, 'string.invalid'], // single-line string with unmatched quotes
      [/"/, { token: 'string.quote', bracket: '@open', next: '@string' }],
      [/\\\\/, { token: 'string', next: '@multiline_string' }], // Modified: switch to multiline string state
      [/\b(?:u\d+|i\d+|f\d+|isize|usize|c_\w+|bool|void|noreturn|type|error|anyerror|anyframe|anytype|anyopaque)\b/, 'keyword.type'],
      [/\b(?:\w+(?=\s*\())/, { token: 'keyword.function' }],
      [/\b[0-9]+(?:\.[0-9]+)?(?:[eE][+-]?[0-9]+)?\b/, 'number.float'],
      [/\b0(?:[xX][0-9a-fA-F]+|[oO][0-7]+|[bB][01]+)[0-9_]*\b/, 'number.hex'],
      [/\b(?:[1-9][0-9_]*|0)\b/, 'number'],
      [/[+_\-*/%|=!><&|^;:@~?.,]+/, 'delimiter'],
      [/[{}()\[\]]+/, 'bracket'],
      [/@?([a-zA-Z_$][\w$]*)/, {
				cases: {
					'@keywords': { token: 'keyword.$1' },
					'@default': 'identifier'
				}
			}],
    ],

    string: [
      [/\\./, { token: 'constant.character.escape' }],
      [/"/, { token: 'string.quote', bracket: '@close', next: '@pop' }],
      [/[^\\"]+/, 'string'],
    ],

    multiline_string: [
      // Match a line with a double backslash, followed by any characters on the same line
      [/\\\\.*$/, 'string'], // This covers any subsequent lines starting with double backslashes
      [/.*$/, { token: 'string', next: '@pop' }], // When the current line doesn't start with a double backslash, return to the root state
    ],
  }
};

export default zig;