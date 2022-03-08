/* A Bison parser, made by GNU Bison 3.5.1.  */

/* Bison implementation for Yacc-like parsers in C

   Copyright (C) 1984, 1989-1990, 2000-2015, 2018-2020 Free Software Foundation,
   Inc.

   This program is free software: you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation, either version 3 of the License, or
   (at your option) any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program.  If not, see <http://www.gnu.org/licenses/>.  */

/* As a special exception, you may create a larger work that contains
   part or all of the Bison parser skeleton and distribute that work
   under terms of your choice, so long as that work isn't itself a
   parser generator using the skeleton or a modified version thereof
   as a parser skeleton.  Alternatively, if you modify or redistribute
   the parser skeleton itself, you may (at your option) remove this
   special exception, which will cause the skeleton and the resulting
   Bison output files to be licensed under the GNU General Public
   License without this special exception.

   This special exception was added by the Free Software Foundation in
   version 2.2 of Bison.  */

/* C LALR(1) parser skeleton written by Richard Stallman, by
   simplifying the original so-called "semantic" parser.  */

/* All symbols defined below should begin with yy or YY, to avoid
   infringing on user name space.  This should be done even for local
   variables, as they might otherwise be expanded by user macros.
   There are some unavoidable exceptions within include files to
   define necessary library symbols; they are noted "INFRINGES ON
   USER NAME SPACE" below.  */

/* Undocumented macros, especially those whose name start with YY_,
   are private implementation details.  Do not rely on them.  */

/* Identify Bison output.  */
#define YYBISON 1

/* Bison version.  */
#define YYBISON_VERSION "3.5.1"

/* Skeleton name.  */
#define YYSKELETON_NAME "yacc.c"

/* Pure parsers.  */
#define YYPURE 0

/* Push parsers.  */
#define YYPUSH 0

/* Pull parsers.  */
#define YYPULL 1




/* First part of user prologue.  */
#line 1 "sintatica.y"

#include <iostream>
#include <string>
#include <sstream>
#include <stdlib.h>
#include <vector>

#define YYSTYPE atributos

using namespace std;

struct atributos
{
	string label;
	string traducao;
	string tipo;
	string conteudo;
};

typedef struct
{
	string nomeVariavel;
	string tipoVariavel;
} TIPO_SIMBOLO;

typedef struct
{
	int indice;
	char caracter;
} TABELA_ASCII;

int var_temp_qnt;
vector<TIPO_SIMBOLO> tabelaSimbolos;
vector<TABELA_ASCII> table_ascii; 


string gentempcode();
void print_table();
bool buscaVariavel(string nomeVariavel);
void addSimbolo(string nome, string tipo);
TIPO_SIMBOLO getSimbolo(string variavel);
string cast(TIPO_SIMBOLO var1, TIPO_SIMBOLO var2);
bool comparaTipo(string tipo1, string tipo2);
void inicializaAscii();


int yylex(void);
void yyerror(string);

#line 120 "y.tab.c"

# ifndef YY_CAST
#  ifdef __cplusplus
#   define YY_CAST(Type, Val) static_cast<Type> (Val)
#   define YY_REINTERPRET_CAST(Type, Val) reinterpret_cast<Type> (Val)
#  else
#   define YY_CAST(Type, Val) ((Type) (Val))
#   define YY_REINTERPRET_CAST(Type, Val) ((Type) (Val))
#  endif
# endif
# ifndef YY_NULLPTR
#  if defined __cplusplus
#   if 201103L <= __cplusplus
#    define YY_NULLPTR nullptr
#   else
#    define YY_NULLPTR 0
#   endif
#  else
#   define YY_NULLPTR ((void*)0)
#  endif
# endif

/* Enabling verbose error messages.  */
#ifdef YYERROR_VERBOSE
# undef YYERROR_VERBOSE
# define YYERROR_VERBOSE 1
#else
# define YYERROR_VERBOSE 0
#endif

/* Use api.header.include to #include this header
   instead of duplicating it here.  */
#ifndef YY_YY_Y_TAB_H_INCLUDED
# define YY_YY_Y_TAB_H_INCLUDED
/* Debug traces.  */
#ifndef YYDEBUG
# define YYDEBUG 0
#endif
#if YYDEBUG
extern int yydebug;
#endif

/* Token type.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
  enum yytokentype
  {
    TK_NUM = 258,
    TK_REAL = 259,
    TK_CARACTER = 260,
    TK_MAIN = 261,
    TK_ID = 262,
    TK_VAR = 263,
    TK_TIPO_INT = 264,
    TK_TIPO_FLOAT = 265,
    TK_TIPO_BOOL = 266,
    TK_TIPO_CHAR = 267,
    TK_FUNC = 268,
    TK_INCREMENT = 269,
    TK_FIM = 270,
    TK_ERROR = 271,
    TK_TRUE = 272,
    TK_FALSE = 273
  };
#endif
/* Tokens.  */
#define TK_NUM 258
#define TK_REAL 259
#define TK_CARACTER 260
#define TK_MAIN 261
#define TK_ID 262
#define TK_VAR 263
#define TK_TIPO_INT 264
#define TK_TIPO_FLOAT 265
#define TK_TIPO_BOOL 266
#define TK_TIPO_CHAR 267
#define TK_FUNC 268
#define TK_INCREMENT 269
#define TK_FIM 270
#define TK_ERROR 271
#define TK_TRUE 272
#define TK_FALSE 273

/* Value type.  */
#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
typedef int YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define YYSTYPE_IS_DECLARED 1
#endif


extern YYSTYPE yylval;

int yyparse (void);

#endif /* !YY_YY_Y_TAB_H_INCLUDED  */



#ifdef short
# undef short
#endif

/* On compilers that do not define __PTRDIFF_MAX__ etc., make sure
   <limits.h> and (if available) <stdint.h> are included
   so that the code can choose integer types of a good width.  */

#ifndef __PTRDIFF_MAX__
# include <limits.h> /* INFRINGES ON USER NAME SPACE */
# if defined __STDC_VERSION__ && 199901 <= __STDC_VERSION__
#  include <stdint.h> /* INFRINGES ON USER NAME SPACE */
#  define YY_STDINT_H
# endif
#endif

/* Narrow types that promote to a signed type and that can represent a
   signed or unsigned integer of at least N bits.  In tables they can
   save space and decrease cache pressure.  Promoting to a signed type
   helps avoid bugs in integer arithmetic.  */

#ifdef __INT_LEAST8_MAX__
typedef __INT_LEAST8_TYPE__ yytype_int8;
#elif defined YY_STDINT_H
typedef int_least8_t yytype_int8;
#else
typedef signed char yytype_int8;
#endif

#ifdef __INT_LEAST16_MAX__
typedef __INT_LEAST16_TYPE__ yytype_int16;
#elif defined YY_STDINT_H
typedef int_least16_t yytype_int16;
#else
typedef short yytype_int16;
#endif

#if defined __UINT_LEAST8_MAX__ && __UINT_LEAST8_MAX__ <= __INT_MAX__
typedef __UINT_LEAST8_TYPE__ yytype_uint8;
#elif (!defined __UINT_LEAST8_MAX__ && defined YY_STDINT_H \
       && UINT_LEAST8_MAX <= INT_MAX)
typedef uint_least8_t yytype_uint8;
#elif !defined __UINT_LEAST8_MAX__ && UCHAR_MAX <= INT_MAX
typedef unsigned char yytype_uint8;
#else
typedef short yytype_uint8;
#endif

#if defined __UINT_LEAST16_MAX__ && __UINT_LEAST16_MAX__ <= __INT_MAX__
typedef __UINT_LEAST16_TYPE__ yytype_uint16;
#elif (!defined __UINT_LEAST16_MAX__ && defined YY_STDINT_H \
       && UINT_LEAST16_MAX <= INT_MAX)
typedef uint_least16_t yytype_uint16;
#elif !defined __UINT_LEAST16_MAX__ && USHRT_MAX <= INT_MAX
typedef unsigned short yytype_uint16;
#else
typedef int yytype_uint16;
#endif

#ifndef YYPTRDIFF_T
# if defined __PTRDIFF_TYPE__ && defined __PTRDIFF_MAX__
#  define YYPTRDIFF_T __PTRDIFF_TYPE__
#  define YYPTRDIFF_MAXIMUM __PTRDIFF_MAX__
# elif defined PTRDIFF_MAX
#  ifndef ptrdiff_t
#   include <stddef.h> /* INFRINGES ON USER NAME SPACE */
#  endif
#  define YYPTRDIFF_T ptrdiff_t
#  define YYPTRDIFF_MAXIMUM PTRDIFF_MAX
# else
#  define YYPTRDIFF_T long
#  define YYPTRDIFF_MAXIMUM LONG_MAX
# endif
#endif

#ifndef YYSIZE_T
# ifdef __SIZE_TYPE__
#  define YYSIZE_T __SIZE_TYPE__
# elif defined size_t
#  define YYSIZE_T size_t
# elif defined __STDC_VERSION__ && 199901 <= __STDC_VERSION__
#  include <stddef.h> /* INFRINGES ON USER NAME SPACE */
#  define YYSIZE_T size_t
# else
#  define YYSIZE_T unsigned
# endif
#endif

#define YYSIZE_MAXIMUM                                  \
  YY_CAST (YYPTRDIFF_T,                                 \
           (YYPTRDIFF_MAXIMUM < YY_CAST (YYSIZE_T, -1)  \
            ? YYPTRDIFF_MAXIMUM                         \
            : YY_CAST (YYSIZE_T, -1)))

#define YYSIZEOF(X) YY_CAST (YYPTRDIFF_T, sizeof (X))

/* Stored state numbers (used for stacks). */
typedef yytype_int8 yy_state_t;

/* State numbers in computations.  */
typedef int yy_state_fast_t;

#ifndef YY_
# if defined YYENABLE_NLS && YYENABLE_NLS
#  if ENABLE_NLS
#   include <libintl.h> /* INFRINGES ON USER NAME SPACE */
#   define YY_(Msgid) dgettext ("bison-runtime", Msgid)
#  endif
# endif
# ifndef YY_
#  define YY_(Msgid) Msgid
# endif
#endif

#ifndef YY_ATTRIBUTE_PURE
# if defined __GNUC__ && 2 < __GNUC__ + (96 <= __GNUC_MINOR__)
#  define YY_ATTRIBUTE_PURE __attribute__ ((__pure__))
# else
#  define YY_ATTRIBUTE_PURE
# endif
#endif

#ifndef YY_ATTRIBUTE_UNUSED
# if defined __GNUC__ && 2 < __GNUC__ + (7 <= __GNUC_MINOR__)
#  define YY_ATTRIBUTE_UNUSED __attribute__ ((__unused__))
# else
#  define YY_ATTRIBUTE_UNUSED
# endif
#endif

/* Suppress unused-variable warnings by "using" E.  */
#if ! defined lint || defined __GNUC__
# define YYUSE(E) ((void) (E))
#else
# define YYUSE(E) /* empty */
#endif

#if defined __GNUC__ && ! defined __ICC && 407 <= __GNUC__ * 100 + __GNUC_MINOR__
/* Suppress an incorrect diagnostic about yylval being uninitialized.  */
# define YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN                            \
    _Pragma ("GCC diagnostic push")                                     \
    _Pragma ("GCC diagnostic ignored \"-Wuninitialized\"")              \
    _Pragma ("GCC diagnostic ignored \"-Wmaybe-uninitialized\"")
# define YY_IGNORE_MAYBE_UNINITIALIZED_END      \
    _Pragma ("GCC diagnostic pop")
#else
# define YY_INITIAL_VALUE(Value) Value
#endif
#ifndef YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN
# define YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN
# define YY_IGNORE_MAYBE_UNINITIALIZED_END
#endif
#ifndef YY_INITIAL_VALUE
# define YY_INITIAL_VALUE(Value) /* Nothing. */
#endif

#if defined __cplusplus && defined __GNUC__ && ! defined __ICC && 6 <= __GNUC__
# define YY_IGNORE_USELESS_CAST_BEGIN                          \
    _Pragma ("GCC diagnostic push")                            \
    _Pragma ("GCC diagnostic ignored \"-Wuseless-cast\"")
# define YY_IGNORE_USELESS_CAST_END            \
    _Pragma ("GCC diagnostic pop")
#endif
#ifndef YY_IGNORE_USELESS_CAST_BEGIN
# define YY_IGNORE_USELESS_CAST_BEGIN
# define YY_IGNORE_USELESS_CAST_END
#endif


#define YY_ASSERT(E) ((void) (0 && (E)))

#if ! defined yyoverflow || YYERROR_VERBOSE

/* The parser invokes alloca or malloc; define the necessary symbols.  */

# ifdef YYSTACK_USE_ALLOCA
#  if YYSTACK_USE_ALLOCA
#   ifdef __GNUC__
#    define YYSTACK_ALLOC __builtin_alloca
#   elif defined __BUILTIN_VA_ARG_INCR
#    include <alloca.h> /* INFRINGES ON USER NAME SPACE */
#   elif defined _AIX
#    define YYSTACK_ALLOC __alloca
#   elif defined _MSC_VER
#    include <malloc.h> /* INFRINGES ON USER NAME SPACE */
#    define alloca _alloca
#   else
#    define YYSTACK_ALLOC alloca
#    if ! defined _ALLOCA_H && ! defined EXIT_SUCCESS
#     include <stdlib.h> /* INFRINGES ON USER NAME SPACE */
      /* Use EXIT_SUCCESS as a witness for stdlib.h.  */
#     ifndef EXIT_SUCCESS
#      define EXIT_SUCCESS 0
#     endif
#    endif
#   endif
#  endif
# endif

# ifdef YYSTACK_ALLOC
   /* Pacify GCC's 'empty if-body' warning.  */
#  define YYSTACK_FREE(Ptr) do { /* empty */; } while (0)
#  ifndef YYSTACK_ALLOC_MAXIMUM
    /* The OS might guarantee only one guard page at the bottom of the stack,
       and a page size can be as small as 4096 bytes.  So we cannot safely
       invoke alloca (N) if N exceeds 4096.  Use a slightly smaller number
       to allow for a few compiler-allocated temporary stack slots.  */
#   define YYSTACK_ALLOC_MAXIMUM 4032 /* reasonable circa 2006 */
#  endif
# else
#  define YYSTACK_ALLOC YYMALLOC
#  define YYSTACK_FREE YYFREE
#  ifndef YYSTACK_ALLOC_MAXIMUM
#   define YYSTACK_ALLOC_MAXIMUM YYSIZE_MAXIMUM
#  endif
#  if (defined __cplusplus && ! defined EXIT_SUCCESS \
       && ! ((defined YYMALLOC || defined malloc) \
             && (defined YYFREE || defined free)))
#   include <stdlib.h> /* INFRINGES ON USER NAME SPACE */
#   ifndef EXIT_SUCCESS
#    define EXIT_SUCCESS 0
#   endif
#  endif
#  ifndef YYMALLOC
#   define YYMALLOC malloc
#   if ! defined malloc && ! defined EXIT_SUCCESS
void *malloc (YYSIZE_T); /* INFRINGES ON USER NAME SPACE */
#   endif
#  endif
#  ifndef YYFREE
#   define YYFREE free
#   if ! defined free && ! defined EXIT_SUCCESS
void free (void *); /* INFRINGES ON USER NAME SPACE */
#   endif
#  endif
# endif
#endif /* ! defined yyoverflow || YYERROR_VERBOSE */


#if (! defined yyoverflow \
     && (! defined __cplusplus \
         || (defined YYSTYPE_IS_TRIVIAL && YYSTYPE_IS_TRIVIAL)))

/* A type that is properly aligned for any stack member.  */
union yyalloc
{
  yy_state_t yyss_alloc;
  YYSTYPE yyvs_alloc;
};

/* The size of the maximum gap between one aligned stack and the next.  */
# define YYSTACK_GAP_MAXIMUM (YYSIZEOF (union yyalloc) - 1)

/* The size of an array large to enough to hold all stacks, each with
   N elements.  */
# define YYSTACK_BYTES(N) \
     ((N) * (YYSIZEOF (yy_state_t) + YYSIZEOF (YYSTYPE)) \
      + YYSTACK_GAP_MAXIMUM)

# define YYCOPY_NEEDED 1

/* Relocate STACK from its old location to the new one.  The
   local variables YYSIZE and YYSTACKSIZE give the old and new number of
   elements in the stack, and YYPTR gives the new location of the
   stack.  Advance YYPTR to a properly aligned location for the next
   stack.  */
# define YYSTACK_RELOCATE(Stack_alloc, Stack)                           \
    do                                                                  \
      {                                                                 \
        YYPTRDIFF_T yynewbytes;                                         \
        YYCOPY (&yyptr->Stack_alloc, Stack, yysize);                    \
        Stack = &yyptr->Stack_alloc;                                    \
        yynewbytes = yystacksize * YYSIZEOF (*Stack) + YYSTACK_GAP_MAXIMUM; \
        yyptr += yynewbytes / YYSIZEOF (*yyptr);                        \
      }                                                                 \
    while (0)

#endif

#if defined YYCOPY_NEEDED && YYCOPY_NEEDED
/* Copy COUNT objects from SRC to DST.  The source and destination do
   not overlap.  */
# ifndef YYCOPY
#  if defined __GNUC__ && 1 < __GNUC__
#   define YYCOPY(Dst, Src, Count) \
      __builtin_memcpy (Dst, Src, YY_CAST (YYSIZE_T, (Count)) * sizeof (*(Src)))
#  else
#   define YYCOPY(Dst, Src, Count)              \
      do                                        \
        {                                       \
          YYPTRDIFF_T yyi;                      \
          for (yyi = 0; yyi < (Count); yyi++)   \
            (Dst)[yyi] = (Src)[yyi];            \
        }                                       \
      while (0)
#  endif
# endif
#endif /* !YYCOPY_NEEDED */

/* YYFINAL -- State number of the termination state.  */
#define YYFINAL  4
/* YYLAST -- Last index in YYTABLE.  */
#define YYLAST   155

/* YYNTOKENS -- Number of terminals.  */
#define YYNTOKENS  36
/* YYNNTS -- Number of nonterminals.  */
#define YYNNTS  6
/* YYNRULES -- Number of rules.  */
#define YYNRULES  50
/* YYNSTATES -- Number of states.  */
#define YYNSTATES  116

#define YYUNDEFTOK  2
#define YYMAXUTOK   273


/* YYTRANSLATE(TOKEN-NUM) -- Symbol number corresponding to TOKEN-NUM
   as returned by yylex, with out-of-bounds checking.  */
#define YYTRANSLATE(YYX)                                                \
  (0 <= (YYX) && (YYX) <= YYMAXUTOK ? yytranslate[YYX] : YYUNDEFTOK)

/* YYTRANSLATE[TOKEN-NUM] -- Symbol number corresponding to TOKEN-NUM
   as returned by yylex.  */
static const yytype_int8 yytranslate[] =
{
       0,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,    33,    26,     2,     2,    30,    34,     2,
      20,    21,    28,    19,     2,    27,     2,    29,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,    24,
      31,    25,    32,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,    22,    35,    23,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     1,     2,     3,     4,
       5,     6,     7,     8,     9,    10,    11,    12,    13,    14,
      15,    16,    17,    18
};

#if YYDEBUG
  /* YYRLINE[YYN] -- Source line where rule number YYN was defined.  */
static const yytype_int16 yyrline[] =
{
       0,    64,    64,    70,    76,    81,    86,    88,   103,   118,
     133,   148,   164,   180,   196,   212,   233,   241,   253,   260,
     267,   279,   286,   293,   300,   307,   315,   321,   327,   333,
     339,   345,   352,   358,   364,   372,   391,   405,   419,   433,
     447,   453,   459,   465,   483,   489,   498,   506,   513,   534,
     540
};
#endif

#if YYDEBUG || YYERROR_VERBOSE || 0
/* YYTNAME[SYMBOL-NUM] -- String name of the symbol SYMBOL-NUM.
   First, the terminals, then, starting at YYNTOKENS, nonterminals.  */
static const char *const yytname[] =
{
  "$end", "error", "$undefined", "TK_NUM", "TK_REAL", "TK_CARACTER",
  "TK_MAIN", "TK_ID", "TK_VAR", "TK_TIPO_INT", "TK_TIPO_FLOAT",
  "TK_TIPO_BOOL", "TK_TIPO_CHAR", "TK_FUNC", "TK_INCREMENT", "TK_FIM",
  "TK_ERROR", "TK_TRUE", "TK_FALSE", "'+'", "'('", "')'", "'{'", "'}'",
  "';'", "'='", "'\"'", "'-'", "'*'", "'/'", "'%'", "'<'", "'>'", "'!'",
  "'&'", "'|'", "$accept", "S", "BLOCO", "COMANDOS", "COMANDO", "E", YY_NULLPTR
};
#endif

# ifdef YYPRINT
/* YYTOKNUM[NUM] -- (External) token number corresponding to the
   (internal) symbol number NUM (which must be that of a token).  */
static const yytype_int16 yytoknum[] =
{
       0,   256,   257,   258,   259,   260,   261,   262,   263,   264,
     265,   266,   267,   268,   269,   270,   271,   272,   273,    43,
      40,    41,   123,   125,    59,    61,    34,    45,    42,    47,
      37,    60,    62,    33,    38,   124
};
# endif

#define YYPACT_NINF (-24)

#define yypact_value_is_default(Yyn) \
  ((Yyn) == YYPACT_NINF)

#define YYTABLE_NINF (-1)

#define yytable_value_is_error(Yyn) \
  0

  /* YYPACT[STATE-NUM] -- Index in YYTABLE of the portion describing
     STATE-NUM.  */
static const yytype_int16 yypact[] =
{
       5,    24,     3,    14,   -24,    27,    35,    25,   -24,   -24,
     -24,   118,    39,    48,    40,    61,    42,    82,    47,    25,
      94,    -3,     2,    49,    50,    52,    53,    46,    57,    55,
     143,    74,    82,    67,    82,   106,   -24,   -24,    82,   -24,
      84,    82,    82,    82,    62,    60,   -24,   -24,    82,   -24,
     -24,   -24,    86,   -24,   -24,    82,    82,    82,    82,    82,
      82,   106,    82,   106,    82,   -23,   -11,    12,    30,    81,
      70,   -24,   106,    70,    42,   106,   106,   106,   106,    82,
      82,   106,   100,   106,   106,   106,   106,   106,   106,   106,
     106,   -24,   109,   -24,   110,   -24,   -10,   -24,    90,   -24,
     106,   106,    98,    96,   102,   103,   107,   125,   -24,   -24,
     -24,   -24,   -24,   112,   108,   -24
};

  /* YYDEFACT[STATE-NUM] -- Default reduction number in state STATE-NUM.
     Performed when YYTABLE does not specify something else to do.  Zero
     means the default is an error.  */
static const yytype_int8 yydefact[] =
{
       0,     0,     0,     0,     1,     0,     0,     5,     2,    45,
      46,    48,     0,     0,     0,     0,     0,     0,     0,     5,
       0,     0,     0,     0,     0,     0,     0,     0,     0,     0,
       0,     0,     0,     0,     0,    34,     3,     4,     0,     6,
       0,     0,     0,     0,     0,     0,    17,    22,     0,    36,
      37,    35,     0,    38,    39,     0,     0,     0,     0,     0,
       0,    26,     0,    27,     0,     0,     0,     0,     0,     0,
      24,    47,    25,    16,    23,    18,    19,    20,    21,     0,
       0,    40,     0,    30,    41,    42,    43,    44,    28,    29,
      31,     7,     0,     8,     0,     9,     0,    10,     0,    49,
      32,    33,     0,     0,     0,     0,     0,     0,    50,    13,
      14,    11,    12,     0,     0,    15
};

  /* YYPGOTO[NTERM-NUM].  */
static const yytype_int8 yypgoto[] =
{
     -24,   -24,   -24,   120,   -24,   -17
};

  /* YYDEFGOTO[NTERM-NUM].  */
static const yytype_int8 yydefgoto[] =
{
      -1,     2,     8,    18,    19,    20
};

  /* YYTABLE[YYPACT[STATE-NUM]] -- What to do in state STATE-NUM.  If
     positive, shift that token.  If negative, reduce the rule whose
     number is the opposite.  If YYTABLE_NINF, syntax error.  */
static const yytype_int8 yytable[] =
{
      35,    91,    92,     4,    46,    49,    50,   105,   106,    51,
      61,    63,    52,    93,    94,    70,    47,    72,     1,    53,
      54,    73,    48,    75,    76,    77,    78,    55,     9,    10,
       3,    81,    11,    12,     5,    13,    95,    96,    83,    84,
      85,    86,    87,    88,    14,    89,    30,    90,     6,     9,
      10,    15,    16,    11,    97,    98,    13,     7,    17,    32,
       9,    10,   100,   101,    11,    14,    33,    13,    31,    34,
      36,    60,    15,    16,    56,    57,    14,    58,    59,    17,
      64,    69,    62,    15,    16,     9,    10,     9,    10,    11,
      17,    11,    13,    71,    13,    80,    79,    40,    41,    42,
      43,    14,    99,    14,    44,    45,    82,   102,    15,    16,
      15,    74,   103,    38,   104,    17,   107,    17,    39,   108,
     109,    40,    41,    42,    43,    38,   110,   111,    44,    45,
     113,   112,   115,    40,    41,    42,    43,    21,   114,    37,
      44,    45,     0,    22,     0,    23,    24,    25,    26,    27,
      28,    29,    65,    66,    67,    68
};

static const yytype_int8 yycheck[] =
{
      17,    24,    25,     0,     7,     3,     4,    17,    18,     7,
      27,    28,    10,    24,    25,    32,    19,    34,    13,    17,
      18,    38,    25,    40,    41,    42,    43,    25,     3,     4,
       6,    48,     7,     8,    20,    10,    24,    25,    55,    56,
      57,    58,    59,    60,    19,    62,     7,    64,    21,     3,
       4,    26,    27,     7,    24,    25,    10,    22,    33,    19,
       3,     4,    79,    80,     7,    19,     5,    10,    20,    27,
      23,    25,    26,    27,    25,    25,    19,    25,    25,    33,
      25,     7,    25,    26,    27,     3,     4,     3,     4,     7,
      33,     7,    10,    26,    10,    35,    34,    27,    28,    29,
      30,    19,    21,    19,    34,    35,    20,     7,    26,    27,
      26,    27,     3,    19,     4,    33,    26,    33,    24,    21,
      24,    27,    28,    29,    30,    19,    24,    24,    34,    35,
       5,    24,    24,    27,    28,    29,    30,    19,    26,    19,
      34,    35,    -1,    25,    -1,    27,    28,    29,    30,    31,
      32,    33,     9,    10,    11,    12
};

  /* YYSTOS[STATE-NUM] -- The (internal number of the) accessing
     symbol of state STATE-NUM.  */
static const yytype_int8 yystos[] =
{
       0,    13,    37,     6,     0,    20,    21,    22,    38,     3,
       4,     7,     8,    10,    19,    26,    27,    33,    39,    40,
      41,    19,    25,    27,    28,    29,    30,    31,    32,    33,
       7,    20,    19,     5,    27,    41,    23,    39,    19,    24,
      27,    28,    29,    30,    34,    35,     7,    19,    25,     3,
       4,     7,    10,    17,    18,    25,    25,    25,    25,    25,
      25,    41,    25,    41,    25,     9,    10,    11,    12,     7,
      41,    26,    41,    41,    27,    41,    41,    41,    41,    34,
      35,    41,    20,    41,    41,    41,    41,    41,    41,    41,
      41,    24,    25,    24,    25,    24,    25,    24,    25,    21,
      41,    41,     7,     3,     4,    17,    18,    26,    21,    24,
      24,    24,    24,     5,    26,    24
};

  /* YYR1[YYN] -- Symbol number of symbol that rule YYN derives.  */
static const yytype_int8 yyr1[] =
{
       0,    36,    37,    38,    39,    39,    40,    40,    40,    40,
      40,    40,    40,    40,    40,    40,    41,    41,    41,    41,
      41,    41,    41,    41,    41,    41,    41,    41,    41,    41,
      41,    41,    41,    41,    41,    41,    41,    41,    41,    41,
      41,    41,    41,    41,    41,    41,    41,    41,    41,    41,
      41
};

  /* YYR2[YYN] -- Number of symbols on the right hand side of rule YYN.  */
static const yytype_int8 yyr2[] =
{
       0,     2,     5,     3,     2,     0,     2,     4,     4,     4,
       4,     6,     6,     6,     6,     8,     3,     3,     3,     3,
       3,     3,     3,     3,     3,     3,     3,     3,     4,     4,
       4,     4,     4,     4,     2,     3,     3,     3,     3,     3,
       4,     4,     4,     4,     4,     1,     1,     3,     1,     4,
       6
};


#define yyerrok         (yyerrstatus = 0)
#define yyclearin       (yychar = YYEMPTY)
#define YYEMPTY         (-2)
#define YYEOF           0

#define YYACCEPT        goto yyacceptlab
#define YYABORT         goto yyabortlab
#define YYERROR         goto yyerrorlab


#define YYRECOVERING()  (!!yyerrstatus)

#define YYBACKUP(Token, Value)                                    \
  do                                                              \
    if (yychar == YYEMPTY)                                        \
      {                                                           \
        yychar = (Token);                                         \
        yylval = (Value);                                         \
        YYPOPSTACK (yylen);                                       \
        yystate = *yyssp;                                         \
        goto yybackup;                                            \
      }                                                           \
    else                                                          \
      {                                                           \
        yyerror (YY_("syntax error: cannot back up")); \
        YYERROR;                                                  \
      }                                                           \
  while (0)

/* Error token number */
#define YYTERROR        1
#define YYERRCODE       256



/* Enable debugging if requested.  */
#if YYDEBUG

# ifndef YYFPRINTF
#  include <stdio.h> /* INFRINGES ON USER NAME SPACE */
#  define YYFPRINTF fprintf
# endif

# define YYDPRINTF(Args)                        \
do {                                            \
  if (yydebug)                                  \
    YYFPRINTF Args;                             \
} while (0)

/* This macro is provided for backward compatibility. */
#ifndef YY_LOCATION_PRINT
# define YY_LOCATION_PRINT(File, Loc) ((void) 0)
#endif


# define YY_SYMBOL_PRINT(Title, Type, Value, Location)                    \
do {                                                                      \
  if (yydebug)                                                            \
    {                                                                     \
      YYFPRINTF (stderr, "%s ", Title);                                   \
      yy_symbol_print (stderr,                                            \
                  Type, Value); \
      YYFPRINTF (stderr, "\n");                                           \
    }                                                                     \
} while (0)


/*-----------------------------------.
| Print this symbol's value on YYO.  |
`-----------------------------------*/

static void
yy_symbol_value_print (FILE *yyo, int yytype, YYSTYPE const * const yyvaluep)
{
  FILE *yyoutput = yyo;
  YYUSE (yyoutput);
  if (!yyvaluep)
    return;
# ifdef YYPRINT
  if (yytype < YYNTOKENS)
    YYPRINT (yyo, yytoknum[yytype], *yyvaluep);
# endif
  YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN
  YYUSE (yytype);
  YY_IGNORE_MAYBE_UNINITIALIZED_END
}


/*---------------------------.
| Print this symbol on YYO.  |
`---------------------------*/

static void
yy_symbol_print (FILE *yyo, int yytype, YYSTYPE const * const yyvaluep)
{
  YYFPRINTF (yyo, "%s %s (",
             yytype < YYNTOKENS ? "token" : "nterm", yytname[yytype]);

  yy_symbol_value_print (yyo, yytype, yyvaluep);
  YYFPRINTF (yyo, ")");
}

/*------------------------------------------------------------------.
| yy_stack_print -- Print the state stack from its BOTTOM up to its |
| TOP (included).                                                   |
`------------------------------------------------------------------*/

static void
yy_stack_print (yy_state_t *yybottom, yy_state_t *yytop)
{
  YYFPRINTF (stderr, "Stack now");
  for (; yybottom <= yytop; yybottom++)
    {
      int yybot = *yybottom;
      YYFPRINTF (stderr, " %d", yybot);
    }
  YYFPRINTF (stderr, "\n");
}

# define YY_STACK_PRINT(Bottom, Top)                            \
do {                                                            \
  if (yydebug)                                                  \
    yy_stack_print ((Bottom), (Top));                           \
} while (0)


/*------------------------------------------------.
| Report that the YYRULE is going to be reduced.  |
`------------------------------------------------*/

static void
yy_reduce_print (yy_state_t *yyssp, YYSTYPE *yyvsp, int yyrule)
{
  int yylno = yyrline[yyrule];
  int yynrhs = yyr2[yyrule];
  int yyi;
  YYFPRINTF (stderr, "Reducing stack by rule %d (line %d):\n",
             yyrule - 1, yylno);
  /* The symbols being reduced.  */
  for (yyi = 0; yyi < yynrhs; yyi++)
    {
      YYFPRINTF (stderr, "   $%d = ", yyi + 1);
      yy_symbol_print (stderr,
                       yystos[+yyssp[yyi + 1 - yynrhs]],
                       &yyvsp[(yyi + 1) - (yynrhs)]
                                              );
      YYFPRINTF (stderr, "\n");
    }
}

# define YY_REDUCE_PRINT(Rule)          \
do {                                    \
  if (yydebug)                          \
    yy_reduce_print (yyssp, yyvsp, Rule); \
} while (0)

/* Nonzero means print parse trace.  It is left uninitialized so that
   multiple parsers can coexist.  */
int yydebug;
#else /* !YYDEBUG */
# define YYDPRINTF(Args)
# define YY_SYMBOL_PRINT(Title, Type, Value, Location)
# define YY_STACK_PRINT(Bottom, Top)
# define YY_REDUCE_PRINT(Rule)
#endif /* !YYDEBUG */


/* YYINITDEPTH -- initial size of the parser's stacks.  */
#ifndef YYINITDEPTH
# define YYINITDEPTH 200
#endif

/* YYMAXDEPTH -- maximum size the stacks can grow to (effective only
   if the built-in stack extension method is used).

   Do not make this value too large; the results are undefined if
   YYSTACK_ALLOC_MAXIMUM < YYSTACK_BYTES (YYMAXDEPTH)
   evaluated with infinite-precision integer arithmetic.  */

#ifndef YYMAXDEPTH
# define YYMAXDEPTH 10000
#endif


#if YYERROR_VERBOSE

# ifndef yystrlen
#  if defined __GLIBC__ && defined _STRING_H
#   define yystrlen(S) (YY_CAST (YYPTRDIFF_T, strlen (S)))
#  else
/* Return the length of YYSTR.  */
static YYPTRDIFF_T
yystrlen (const char *yystr)
{
  YYPTRDIFF_T yylen;
  for (yylen = 0; yystr[yylen]; yylen++)
    continue;
  return yylen;
}
#  endif
# endif

# ifndef yystpcpy
#  if defined __GLIBC__ && defined _STRING_H && defined _GNU_SOURCE
#   define yystpcpy stpcpy
#  else
/* Copy YYSRC to YYDEST, returning the address of the terminating '\0' in
   YYDEST.  */
static char *
yystpcpy (char *yydest, const char *yysrc)
{
  char *yyd = yydest;
  const char *yys = yysrc;

  while ((*yyd++ = *yys++) != '\0')
    continue;

  return yyd - 1;
}
#  endif
# endif

# ifndef yytnamerr
/* Copy to YYRES the contents of YYSTR after stripping away unnecessary
   quotes and backslashes, so that it's suitable for yyerror.  The
   heuristic is that double-quoting is unnecessary unless the string
   contains an apostrophe, a comma, or backslash (other than
   backslash-backslash).  YYSTR is taken from yytname.  If YYRES is
   null, do not copy; instead, return the length of what the result
   would have been.  */
static YYPTRDIFF_T
yytnamerr (char *yyres, const char *yystr)
{
  if (*yystr == '"')
    {
      YYPTRDIFF_T yyn = 0;
      char const *yyp = yystr;

      for (;;)
        switch (*++yyp)
          {
          case '\'':
          case ',':
            goto do_not_strip_quotes;

          case '\\':
            if (*++yyp != '\\')
              goto do_not_strip_quotes;
            else
              goto append;

          append:
          default:
            if (yyres)
              yyres[yyn] = *yyp;
            yyn++;
            break;

          case '"':
            if (yyres)
              yyres[yyn] = '\0';
            return yyn;
          }
    do_not_strip_quotes: ;
    }

  if (yyres)
    return yystpcpy (yyres, yystr) - yyres;
  else
    return yystrlen (yystr);
}
# endif

/* Copy into *YYMSG, which is of size *YYMSG_ALLOC, an error message
   about the unexpected token YYTOKEN for the state stack whose top is
   YYSSP.

   Return 0 if *YYMSG was successfully written.  Return 1 if *YYMSG is
   not large enough to hold the message.  In that case, also set
   *YYMSG_ALLOC to the required number of bytes.  Return 2 if the
   required number of bytes is too large to store.  */
static int
yysyntax_error (YYPTRDIFF_T *yymsg_alloc, char **yymsg,
                yy_state_t *yyssp, int yytoken)
{
  enum { YYERROR_VERBOSE_ARGS_MAXIMUM = 5 };
  /* Internationalized format string. */
  const char *yyformat = YY_NULLPTR;
  /* Arguments of yyformat: reported tokens (one for the "unexpected",
     one per "expected"). */
  char const *yyarg[YYERROR_VERBOSE_ARGS_MAXIMUM];
  /* Actual size of YYARG. */
  int yycount = 0;
  /* Cumulated lengths of YYARG.  */
  YYPTRDIFF_T yysize = 0;

  /* There are many possibilities here to consider:
     - If this state is a consistent state with a default action, then
       the only way this function was invoked is if the default action
       is an error action.  In that case, don't check for expected
       tokens because there are none.
     - The only way there can be no lookahead present (in yychar) is if
       this state is a consistent state with a default action.  Thus,
       detecting the absence of a lookahead is sufficient to determine
       that there is no unexpected or expected token to report.  In that
       case, just report a simple "syntax error".
     - Don't assume there isn't a lookahead just because this state is a
       consistent state with a default action.  There might have been a
       previous inconsistent state, consistent state with a non-default
       action, or user semantic action that manipulated yychar.
     - Of course, the expected token list depends on states to have
       correct lookahead information, and it depends on the parser not
       to perform extra reductions after fetching a lookahead from the
       scanner and before detecting a syntax error.  Thus, state merging
       (from LALR or IELR) and default reductions corrupt the expected
       token list.  However, the list is correct for canonical LR with
       one exception: it will still contain any token that will not be
       accepted due to an error action in a later state.
  */
  if (yytoken != YYEMPTY)
    {
      int yyn = yypact[+*yyssp];
      YYPTRDIFF_T yysize0 = yytnamerr (YY_NULLPTR, yytname[yytoken]);
      yysize = yysize0;
      yyarg[yycount++] = yytname[yytoken];
      if (!yypact_value_is_default (yyn))
        {
          /* Start YYX at -YYN if negative to avoid negative indexes in
             YYCHECK.  In other words, skip the first -YYN actions for
             this state because they are default actions.  */
          int yyxbegin = yyn < 0 ? -yyn : 0;
          /* Stay within bounds of both yycheck and yytname.  */
          int yychecklim = YYLAST - yyn + 1;
          int yyxend = yychecklim < YYNTOKENS ? yychecklim : YYNTOKENS;
          int yyx;

          for (yyx = yyxbegin; yyx < yyxend; ++yyx)
            if (yycheck[yyx + yyn] == yyx && yyx != YYTERROR
                && !yytable_value_is_error (yytable[yyx + yyn]))
              {
                if (yycount == YYERROR_VERBOSE_ARGS_MAXIMUM)
                  {
                    yycount = 1;
                    yysize = yysize0;
                    break;
                  }
                yyarg[yycount++] = yytname[yyx];
                {
                  YYPTRDIFF_T yysize1
                    = yysize + yytnamerr (YY_NULLPTR, yytname[yyx]);
                  if (yysize <= yysize1 && yysize1 <= YYSTACK_ALLOC_MAXIMUM)
                    yysize = yysize1;
                  else
                    return 2;
                }
              }
        }
    }

  switch (yycount)
    {
# define YYCASE_(N, S)                      \
      case N:                               \
        yyformat = S;                       \
      break
    default: /* Avoid compiler warnings. */
      YYCASE_(0, YY_("syntax error"));
      YYCASE_(1, YY_("syntax error, unexpected %s"));
      YYCASE_(2, YY_("syntax error, unexpected %s, expecting %s"));
      YYCASE_(3, YY_("syntax error, unexpected %s, expecting %s or %s"));
      YYCASE_(4, YY_("syntax error, unexpected %s, expecting %s or %s or %s"));
      YYCASE_(5, YY_("syntax error, unexpected %s, expecting %s or %s or %s or %s"));
# undef YYCASE_
    }

  {
    /* Don't count the "%s"s in the final size, but reserve room for
       the terminator.  */
    YYPTRDIFF_T yysize1 = yysize + (yystrlen (yyformat) - 2 * yycount) + 1;
    if (yysize <= yysize1 && yysize1 <= YYSTACK_ALLOC_MAXIMUM)
      yysize = yysize1;
    else
      return 2;
  }

  if (*yymsg_alloc < yysize)
    {
      *yymsg_alloc = 2 * yysize;
      if (! (yysize <= *yymsg_alloc
             && *yymsg_alloc <= YYSTACK_ALLOC_MAXIMUM))
        *yymsg_alloc = YYSTACK_ALLOC_MAXIMUM;
      return 1;
    }

  /* Avoid sprintf, as that infringes on the user's name space.
     Don't have undefined behavior even if the translation
     produced a string with the wrong number of "%s"s.  */
  {
    char *yyp = *yymsg;
    int yyi = 0;
    while ((*yyp = *yyformat) != '\0')
      if (*yyp == '%' && yyformat[1] == 's' && yyi < yycount)
        {
          yyp += yytnamerr (yyp, yyarg[yyi++]);
          yyformat += 2;
        }
      else
        {
          ++yyp;
          ++yyformat;
        }
  }
  return 0;
}
#endif /* YYERROR_VERBOSE */

/*-----------------------------------------------.
| Release the memory associated to this symbol.  |
`-----------------------------------------------*/

static void
yydestruct (const char *yymsg, int yytype, YYSTYPE *yyvaluep)
{
  YYUSE (yyvaluep);
  if (!yymsg)
    yymsg = "Deleting";
  YY_SYMBOL_PRINT (yymsg, yytype, yyvaluep, yylocationp);

  YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN
  YYUSE (yytype);
  YY_IGNORE_MAYBE_UNINITIALIZED_END
}




/* The lookahead symbol.  */
int yychar;

/* The semantic value of the lookahead symbol.  */
YYSTYPE yylval;
/* Number of syntax errors so far.  */
int yynerrs;


/*----------.
| yyparse.  |
`----------*/

int
yyparse (void)
{
    yy_state_fast_t yystate;
    /* Number of tokens to shift before error messages enabled.  */
    int yyerrstatus;

    /* The stacks and their tools:
       'yyss': related to states.
       'yyvs': related to semantic values.

       Refer to the stacks through separate pointers, to allow yyoverflow
       to reallocate them elsewhere.  */

    /* The state stack.  */
    yy_state_t yyssa[YYINITDEPTH];
    yy_state_t *yyss;
    yy_state_t *yyssp;

    /* The semantic value stack.  */
    YYSTYPE yyvsa[YYINITDEPTH];
    YYSTYPE *yyvs;
    YYSTYPE *yyvsp;

    YYPTRDIFF_T yystacksize;

  int yyn;
  int yyresult;
  /* Lookahead token as an internal (translated) token number.  */
  int yytoken = 0;
  /* The variables used to return semantic value and location from the
     action routines.  */
  YYSTYPE yyval;

#if YYERROR_VERBOSE
  /* Buffer for error messages, and its allocated size.  */
  char yymsgbuf[128];
  char *yymsg = yymsgbuf;
  YYPTRDIFF_T yymsg_alloc = sizeof yymsgbuf;
#endif

#define YYPOPSTACK(N)   (yyvsp -= (N), yyssp -= (N))

  /* The number of symbols on the RHS of the reduced rule.
     Keep to zero when no symbol should be popped.  */
  int yylen = 0;

  yyssp = yyss = yyssa;
  yyvsp = yyvs = yyvsa;
  yystacksize = YYINITDEPTH;

  YYDPRINTF ((stderr, "Starting parse\n"));

  yystate = 0;
  yyerrstatus = 0;
  yynerrs = 0;
  yychar = YYEMPTY; /* Cause a token to be read.  */
  goto yysetstate;


/*------------------------------------------------------------.
| yynewstate -- push a new state, which is found in yystate.  |
`------------------------------------------------------------*/
yynewstate:
  /* In all cases, when you get here, the value and location stacks
     have just been pushed.  So pushing a state here evens the stacks.  */
  yyssp++;


/*--------------------------------------------------------------------.
| yysetstate -- set current state (the top of the stack) to yystate.  |
`--------------------------------------------------------------------*/
yysetstate:
  YYDPRINTF ((stderr, "Entering state %d\n", yystate));
  YY_ASSERT (0 <= yystate && yystate < YYNSTATES);
  YY_IGNORE_USELESS_CAST_BEGIN
  *yyssp = YY_CAST (yy_state_t, yystate);
  YY_IGNORE_USELESS_CAST_END

  if (yyss + yystacksize - 1 <= yyssp)
#if !defined yyoverflow && !defined YYSTACK_RELOCATE
    goto yyexhaustedlab;
#else
    {
      /* Get the current used size of the three stacks, in elements.  */
      YYPTRDIFF_T yysize = yyssp - yyss + 1;

# if defined yyoverflow
      {
        /* Give user a chance to reallocate the stack.  Use copies of
           these so that the &'s don't force the real ones into
           memory.  */
        yy_state_t *yyss1 = yyss;
        YYSTYPE *yyvs1 = yyvs;

        /* Each stack pointer address is followed by the size of the
           data in use in that stack, in bytes.  This used to be a
           conditional around just the two extra args, but that might
           be undefined if yyoverflow is a macro.  */
        yyoverflow (YY_("memory exhausted"),
                    &yyss1, yysize * YYSIZEOF (*yyssp),
                    &yyvs1, yysize * YYSIZEOF (*yyvsp),
                    &yystacksize);
        yyss = yyss1;
        yyvs = yyvs1;
      }
# else /* defined YYSTACK_RELOCATE */
      /* Extend the stack our own way.  */
      if (YYMAXDEPTH <= yystacksize)
        goto yyexhaustedlab;
      yystacksize *= 2;
      if (YYMAXDEPTH < yystacksize)
        yystacksize = YYMAXDEPTH;

      {
        yy_state_t *yyss1 = yyss;
        union yyalloc *yyptr =
          YY_CAST (union yyalloc *,
                   YYSTACK_ALLOC (YY_CAST (YYSIZE_T, YYSTACK_BYTES (yystacksize))));
        if (! yyptr)
          goto yyexhaustedlab;
        YYSTACK_RELOCATE (yyss_alloc, yyss);
        YYSTACK_RELOCATE (yyvs_alloc, yyvs);
# undef YYSTACK_RELOCATE
        if (yyss1 != yyssa)
          YYSTACK_FREE (yyss1);
      }
# endif

      yyssp = yyss + yysize - 1;
      yyvsp = yyvs + yysize - 1;

      YY_IGNORE_USELESS_CAST_BEGIN
      YYDPRINTF ((stderr, "Stack size increased to %ld\n",
                  YY_CAST (long, yystacksize)));
      YY_IGNORE_USELESS_CAST_END

      if (yyss + yystacksize - 1 <= yyssp)
        YYABORT;
    }
#endif /* !defined yyoverflow && !defined YYSTACK_RELOCATE */

  if (yystate == YYFINAL)
    YYACCEPT;

  goto yybackup;


/*-----------.
| yybackup.  |
`-----------*/
yybackup:
  /* Do appropriate processing given the current state.  Read a
     lookahead token if we need one and don't already have one.  */

  /* First try to decide what to do without reference to lookahead token.  */
  yyn = yypact[yystate];
  if (yypact_value_is_default (yyn))
    goto yydefault;

  /* Not known => get a lookahead token if don't already have one.  */

  /* YYCHAR is either YYEMPTY or YYEOF or a valid lookahead symbol.  */
  if (yychar == YYEMPTY)
    {
      YYDPRINTF ((stderr, "Reading a token: "));
      yychar = yylex ();
    }

  if (yychar <= YYEOF)
    {
      yychar = yytoken = YYEOF;
      YYDPRINTF ((stderr, "Now at end of input.\n"));
    }
  else
    {
      yytoken = YYTRANSLATE (yychar);
      YY_SYMBOL_PRINT ("Next token is", yytoken, &yylval, &yylloc);
    }

  /* If the proper action on seeing token YYTOKEN is to reduce or to
     detect an error, take that action.  */
  yyn += yytoken;
  if (yyn < 0 || YYLAST < yyn || yycheck[yyn] != yytoken)
    goto yydefault;
  yyn = yytable[yyn];
  if (yyn <= 0)
    {
      if (yytable_value_is_error (yyn))
        goto yyerrlab;
      yyn = -yyn;
      goto yyreduce;
    }

  /* Count tokens shifted since error; after three, turn off error
     status.  */
  if (yyerrstatus)
    yyerrstatus--;

  /* Shift the lookahead token.  */
  YY_SYMBOL_PRINT ("Shifting", yytoken, &yylval, &yylloc);
  yystate = yyn;
  YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN
  *++yyvsp = yylval;
  YY_IGNORE_MAYBE_UNINITIALIZED_END

  /* Discard the shifted token.  */
  yychar = YYEMPTY;
  goto yynewstate;


/*-----------------------------------------------------------.
| yydefault -- do the default action for the current state.  |
`-----------------------------------------------------------*/
yydefault:
  yyn = yydefact[yystate];
  if (yyn == 0)
    goto yyerrlab;
  goto yyreduce;


/*-----------------------------.
| yyreduce -- do a reduction.  |
`-----------------------------*/
yyreduce:
  /* yyn is the number of a rule to reduce with.  */
  yylen = yyr2[yyn];

  /* If YYLEN is nonzero, implement the default value of the action:
     '$$ = $1'.

     Otherwise, the following line sets YYVAL to garbage.
     This behavior is undocumented and Bison
     users should not rely upon it.  Assigning to YYVAL
     unconditionally makes the parser a bit smaller, and it avoids a
     GCC warning that YYVAL may be used uninitialized.  */
  yyval = yyvsp[1-yylen];


  YY_REDUCE_PRINT (yyn);
  switch (yyn)
    {
  case 2:
#line 65 "sintatica.y"
                        {
				cout << "\n\n/*Compilador GO*/\n" << "#include <iostream>\n#include<string.h>\n#include<stdio.h>\nint main(void)\n{\n" << yyvsp[0].traducao << "\treturn 0;\n}" << endl; 
			}
#line 1454 "y.tab.c"
    break;

  case 3:
#line 71 "sintatica.y"
                        {
				yyval.traducao = yyvsp[-1].traducao;
			}
#line 1462 "y.tab.c"
    break;

  case 4:
#line 77 "sintatica.y"
                        {
				yyval.traducao = yyvsp[-1].traducao + yyvsp[0].traducao;
			}
#line 1470 "y.tab.c"
    break;

  case 5:
#line 81 "sintatica.y"
                        {
				yyval.traducao + "";
			}
#line 1478 "y.tab.c"
    break;

  case 7:
#line 89 "sintatica.y"
                        {
				bool encontrei = buscaVariavel(yyvsp[-2].label);
			
				if(encontrei){
					yyerror("erro: a variavel '" + yyvsp[-2].label + "' já foi declarada");
					exit(1);
				}
				
				addSimbolo(yyvsp[-2].label, "int");
		
				yyval.traducao = yyvsp[-2].traducao + "\t" +  "int " + yyvsp[-2].label + ";\n";
				yyval.label = "int " + yyvsp[-2].label;
			}
#line 1496 "y.tab.c"
    break;

  case 8:
#line 104 "sintatica.y"
                        {
				bool encontrei = buscaVariavel(yyvsp[-2].label);
				
				if(encontrei){
					yyerror("erro: a variavel '" + yyvsp[-2].label + "' já foi declarada");
					exit(1);
				}
				
				addSimbolo(yyvsp[-2].label, "float");
		
				yyval.traducao = yyvsp[-2].traducao + "\t" +  "float " + yyvsp[-2].label + ";\n";
				yyval.label = "float " + yyvsp[-2].label;
			}
#line 1514 "y.tab.c"
    break;

  case 9:
#line 119 "sintatica.y"
                        {
				bool encontrei = buscaVariavel(yyvsp[-2].label);
				
				if(encontrei){
					yyerror("erro: a variavel '" + yyvsp[-2].label + "' já foi declarada");
					exit(1);
				}
				
				addSimbolo(yyvsp[-2].label, "bool");
		
				yyval.traducao = yyvsp[-2].traducao + "\t" +  "int " + yyvsp[-2].label + ";\n";
				yyval.label = "int " + yyvsp[-2].label;
			}
#line 1532 "y.tab.c"
    break;

  case 10:
#line 134 "sintatica.y"
                        {
				bool encontrei = buscaVariavel(yyvsp[-2].label); 
				
				if(encontrei){
					yyerror("erro: a variavel '" + yyvsp[-2].label + "' já foi declarada");
					exit(1);
				}
				
				addSimbolo(yyvsp[-2].label, "char");
		
				yyval.traducao = yyvsp[-2].traducao + "\t" +  "char " + yyvsp[-2].label + ";\n";
				yyval.label = "char " + yyvsp[-2].label;
			}
#line 1550 "y.tab.c"
    break;

  case 11:
#line 149 "sintatica.y"
                        {
				bool encontrei = buscaVariavel(yyvsp[-4].label); 
				
				if(encontrei){
					yyerror("erro: a variavel '" + yyvsp[-4].label + "' já foi declarada");
					exit(1);
				}
				
				addSimbolo(yyvsp[-4].label, "bool");
		
				yyval.traducao = yyvsp[-4].traducao + "\t" +  "int " + yyvsp[-4].label + " = 1" + ";\n";
				yyval.label = "int " + yyvsp[-4].label + " = " + yyvsp[-1].label;
				yyval.conteudo = yyvsp[-1].label;
			}
#line 1569 "y.tab.c"
    break;

  case 12:
#line 165 "sintatica.y"
                        {
				bool encontrei = buscaVariavel(yyvsp[-4].label); 
				
				if(encontrei){
					yyerror("erro: a variavel '" + yyvsp[-4].label + "' já foi declarada");
					exit(1);
				}
				
				addSimbolo(yyvsp[-4].label, "bool");
		
				yyval.traducao = yyvsp[-4].traducao + "\t" +  "int " + yyvsp[-4].label + " = 0" + ";\n";
				yyval.label = "int " + yyvsp[-4].label + " = " + yyvsp[-1].label;
				yyval.conteudo = yyvsp[-1].label;
			}
#line 1588 "y.tab.c"
    break;

  case 13:
#line 181 "sintatica.y"
                        {
				bool encontrei = buscaVariavel(yyvsp[-4].label); 
				
				if(encontrei){
					yyerror("erro: a variavel '" + yyvsp[-4].label + "' já foi declarada");
					exit(1);
				}
				
				addSimbolo(yyvsp[-4].label, "int");
		
				yyval.traducao = yyvsp[-4].traducao + "\t" +  "int " + yyvsp[-4].label + " = " + yyvsp[-1].label + ";\n";
				yyval.label = "int " + yyvsp[-4].label + " = " + yyvsp[-1].label;
				yyval.conteudo = yyvsp[-1].label;
			}
#line 1607 "y.tab.c"
    break;

  case 14:
#line 197 "sintatica.y"
                        {
				bool encontrei = buscaVariavel(yyvsp[-4].label); 
				
				if(encontrei){
					yyerror("erro: a variavel '" + yyvsp[-4].label + "' já foi declarada");
					exit(1);
				}
				
				addSimbolo(yyvsp[-4].label, "float");
		
				yyval.traducao = yyvsp[-4].traducao + "\t" +  "float " + yyvsp[-4].label + " = " + yyvsp[-1].label + ";\n";
				yyval.label = "float " + yyvsp[-4].label + " = " + yyvsp[-1].label;
				yyval.conteudo = yyvsp[-1].label;
			}
#line 1626 "y.tab.c"
    break;

  case 15:
#line 213 "sintatica.y"
                        {
				bool encontrei = buscaVariavel(yyvsp[-6].label); 
				
				if(encontrei){
					yyerror("erro: a variavel '" + yyvsp[-6].label + "' já foi declarada");
					exit(1);
				}
				
				addSimbolo(yyvsp[-6].label, "char");
		
				yyval.traducao = yyvsp[-6].traducao + "\t" +  "char " + yyvsp[-6].label + " = " + '"' + yyvsp[-2].label + '"' + ";\n";
				yyval.label = "char " + yyvsp[-6].label + " = " + yyvsp[-2].label;
				yyval.conteudo = yyvsp[-2].label;
			}
#line 1645 "y.tab.c"
    break;

  case 16:
#line 234 "sintatica.y"
                        {

				yyval.label = gentempcode();
				yyval.traducao = yyvsp[-2].traducao + yyvsp[0].traducao + "\t" + yyval.label +
					" = " + yyvsp[-2].label + " + " + yyvsp[0].label + ";\n";
			}
#line 1656 "y.tab.c"
    break;

  case 17:
#line 242 "sintatica.y"
                        {
				TIPO_SIMBOLO var1 = getSimbolo(yyvsp[-2].label);
				TIPO_SIMBOLO var2 = getSimbolo(yyvsp[0].label);

				string result = cast(var1, var2);

				yyval.label = gentempcode();
				yyval.traducao = yyvsp[-2].traducao + yyvsp[0].traducao + "\t" + yyval.label +
					" = " + result + " + " + yyvsp[0].label + ";\n";
			}
#line 1671 "y.tab.c"
    break;

  case 18:
#line 254 "sintatica.y"
                        {
				yyval.label = gentempcode();
				yyval.traducao = yyvsp[-2].traducao + yyvsp[0].traducao + "\t" + yyval.label +
					" = " + yyvsp[-2].label + " - " + yyvsp[0].label + ";\n";
			}
#line 1681 "y.tab.c"
    break;

  case 19:
#line 261 "sintatica.y"
                        {
				yyval.label = gentempcode();
				yyval.traducao = yyvsp[-2].traducao + yyvsp[0].traducao + "\t" + yyval.label +
					" = " + yyvsp[-2].label + " * " + yyvsp[0].label + ";\n";
			}
#line 1691 "y.tab.c"
    break;

  case 20:
#line 268 "sintatica.y"
                        {
				if (yyvsp[0].conteudo == "0"){
					yyerror("Erro: Divisão por Zero");
					exit(1);
				}

				yyval.label = gentempcode();
				yyval.traducao = yyvsp[-2].traducao + yyvsp[0].traducao + "\t" + yyval.label +
					" = " + yyvsp[-2].label + " / " + yyvsp[0].label + ";\n";
			}
#line 1706 "y.tab.c"
    break;

  case 21:
#line 280 "sintatica.y"
                        {
				yyval.label = gentempcode();
				yyval.traducao = yyvsp[-2].traducao + yyvsp[0].traducao + "\t" + yyval.label +
					" = " + yyvsp[-2].label + " % " + yyvsp[0].label + ";\n";
			}
#line 1716 "y.tab.c"
    break;

  case 22:
#line 287 "sintatica.y"
                        {
				yyval.label = gentempcode();
				yyval.traducao = yyvsp[-2].traducao + yyvsp[-1].traducao + "\t" + yyval.label + " = " + yyvsp[-2].label +
					'+' + '+' + ";\n";
			}
#line 1726 "y.tab.c"
    break;

  case 23:
#line 294 "sintatica.y"
                        {
				yyval.label = gentempcode();
				yyval.traducao = yyvsp[-2].traducao + "\t" + yyval.label + " = " + yyvsp[-2].label + 
					"-" + "-" + ";\n";
			}
#line 1736 "y.tab.c"
    break;

  case 24:
#line 301 "sintatica.y"
                        {
				yyval.label = gentempcode();
				yyval.traducao = yyvsp[0].traducao + "\t" + yyval.label + " = " +
					'+' + '+' + yyvsp[0].label + ";\n";
			}
#line 1746 "y.tab.c"
    break;

  case 25:
#line 308 "sintatica.y"
                        {
				yyval.label = gentempcode();
				yyval.traducao = yyvsp[0].traducao + "\t" + yyval.label + " = " +
					'-' + '-' + yyvsp[0].label + ";\n";
			}
#line 1756 "y.tab.c"
    break;

  case 26:
#line 316 "sintatica.y"
                        {
				yyval.label = gentempcode();
				yyval.traducao = yyvsp[-2].traducao + yyvsp[0].traducao + "\t" + yyvsp[-2].label + " < " + yyvsp[0].label + ";\n";
			}
#line 1765 "y.tab.c"
    break;

  case 27:
#line 322 "sintatica.y"
                        {
				yyval.label = gentempcode();
				yyval.traducao = yyvsp[-2].traducao + yyvsp[0].traducao + "\t" + yyvsp[-2].label + " > " + yyvsp[0].label + ";\n";
			}
#line 1774 "y.tab.c"
    break;

  case 28:
#line 328 "sintatica.y"
                        {
				yyval.label = gentempcode();
				yyval.traducao = yyvsp[-3].traducao + yyvsp[0].traducao + "\t" + yyvsp[-3].label + " <= " + yyvsp[0].label + ";\n";
			}
#line 1783 "y.tab.c"
    break;

  case 29:
#line 334 "sintatica.y"
                        {
				yyval.label = gentempcode();
				yyval.traducao = yyvsp[-3].traducao + yyvsp[0].traducao + "\t" + yyvsp[-3].label + " >= " + yyvsp[0].label + ";\n";
			}
#line 1792 "y.tab.c"
    break;

  case 30:
#line 340 "sintatica.y"
                        {
				yyval.label = gentempcode();
				yyval.traducao = yyvsp[-3].traducao + yyvsp[0].traducao + "\t" + yyvsp[-3].label + " == " + yyvsp[0].label + ";\n";
			}
#line 1801 "y.tab.c"
    break;

  case 31:
#line 346 "sintatica.y"
                        {
				yyval.label = gentempcode();
				yyval.traducao = yyvsp[-3].traducao + yyvsp[0].traducao + "\t" + yyvsp[-3].label + " != " + yyvsp[0].label + ";\n";
			}
#line 1810 "y.tab.c"
    break;

  case 32:
#line 353 "sintatica.y"
                        {
				yyval.label = gentempcode();
				yyval.traducao = yyvsp[-3].traducao + yyvsp[0].traducao + "\t" + yyvsp[-3].label + " && " + yyvsp[0].label + ";\n";
			}
#line 1819 "y.tab.c"
    break;

  case 33:
#line 359 "sintatica.y"
                        {
				yyval.label = gentempcode();
				yyval.traducao = yyvsp[-3].traducao + yyvsp[0].traducao + "\t" + yyvsp[-3].label + " || " + yyvsp[0].label + ";\n";
			}
#line 1828 "y.tab.c"
    break;

  case 34:
#line 365 "sintatica.y"
                        {
				yyval.label = gentempcode();
				yyval.traducao = yyvsp[0].traducao + "\t" + " !" + yyvsp[0].label + ";\n";
			}
#line 1837 "y.tab.c"
    break;

  case 35:
#line 373 "sintatica.y"
                        {
				TIPO_SIMBOLO var1 = getSimbolo(yyvsp[-2].label);
				TIPO_SIMBOLO var2 = getSimbolo(yyvsp[0].label);



				bool validador = comparaTipo(var1.tipoVariavel, var2.tipoVariavel);

				if (validador)
					yyval.traducao = yyvsp[-2].traducao + yyvsp[0].traducao + "\t" + yyvsp[-2].label + " = " + yyvsp[0].label + ";\n";
				
				else{

					string result = cast(var1, var2);
					yyval.traducao = yyvsp[-2].traducao + yyvsp[0].traducao + "\t" + yyvsp[-2].label + " = " + result + ";\n";
				}
			}
#line 1859 "y.tab.c"
    break;

  case 36:
#line 392 "sintatica.y"
                        {
				TIPO_SIMBOLO var1 = getSimbolo(yyvsp[-2].label);

				bool validador = comparaTipo(var1.tipoVariavel, "int");
				if (validador)
					yyval.traducao = yyvsp[-2].traducao + yyvsp[0].traducao + "\t" + yyvsp[-2].label + " = " + yyvsp[0].label + ";\n";
				
				else{
					yyerror("erro: atribuição inválida");
					exit(1);
				}
			}
#line 1876 "y.tab.c"
    break;

  case 37:
#line 406 "sintatica.y"
                        {
				TIPO_SIMBOLO var1 = getSimbolo(yyvsp[-2].label);

				bool validador = comparaTipo(var1.tipoVariavel, "float");
				if (validador)
					yyval.traducao = yyvsp[-2].traducao + yyvsp[0].traducao + "\t" + yyvsp[-2].label + " = " + yyvsp[0].label + ";\n";
				
				else{
					yyerror("erro: atribuição inválida");
					exit(1);
				}
			}
#line 1893 "y.tab.c"
    break;

  case 38:
#line 420 "sintatica.y"
                        {
				TIPO_SIMBOLO var1 = getSimbolo(yyvsp[-2].label);

				bool validador = comparaTipo(var1.tipoVariavel, "bool");
				if (validador)
					yyval.traducao = yyvsp[-2].traducao + yyvsp[0].traducao + "\t" + yyvsp[-2].label + " = " + "1" + ";\n";
				
				else{
					yyerror("erro: atribuição inválida");
					exit(1);
				}
			}
#line 1910 "y.tab.c"
    break;

  case 39:
#line 434 "sintatica.y"
                        {
				TIPO_SIMBOLO var1 = getSimbolo(yyvsp[-2].label);

				bool validador = comparaTipo(var1.tipoVariavel, "bool");
				if (validador)
					yyval.traducao = yyvsp[-2].traducao + yyvsp[0].traducao + "\t" + yyvsp[-2].label + " = " + "0" + ";\n";
				
				else{
					yyerror("erro: atribuição inválida");
					exit(1);
				}
			}
#line 1927 "y.tab.c"
    break;

  case 40:
#line 448 "sintatica.y"
                        {
				yyval.label = gentempcode();
				yyval.traducao = yyvsp[-3].traducao + yyvsp[0].traducao + "\t" + yyvsp[-3].label + " += " + yyvsp[0].label + ";\n";
			}
#line 1936 "y.tab.c"
    break;

  case 41:
#line 454 "sintatica.y"
                        {
				yyval.label = gentempcode();
				yyval.traducao = yyvsp[-3].traducao + yyvsp[0].traducao + "\t" + yyvsp[-3].label + " -= " + yyvsp[0].label + ";\n";
			}
#line 1945 "y.tab.c"
    break;

  case 42:
#line 460 "sintatica.y"
                        {
				yyval.label = gentempcode();
				yyval.traducao = yyvsp[-3].traducao + yyvsp[0].traducao + "\t" + yyvsp[-3].label + " *= " + yyvsp[0].label + ";\n";
			}
#line 1954 "y.tab.c"
    break;

  case 43:
#line 466 "sintatica.y"
                        {
				if (yyvsp[0].conteudo == "0"){
					yyerror("Erro: Divisão por Zero");
					exit(1);
				}

				TIPO_SIMBOLO var1 = getSimbolo(yyvsp[-3].label);
	
				bool validador = comparaTipo(var1.tipoVariavel, yyvsp[0].tipo);
				if (!validador){
					yyerror("Erro: Associação inválida");
				}
					
				yyval.label = gentempcode();
				yyval.traducao = yyvsp[-3].traducao + yyvsp[0].traducao + "\t" + yyvsp[-3].label + " /= " + yyvsp[0].label + ";\n";
			}
#line 1975 "y.tab.c"
    break;

  case 44:
#line 484 "sintatica.y"
                        {
				yyval.label = gentempcode();
				yyval.traducao = yyvsp[-3].traducao + yyvsp[0].traducao + "\t" + yyvsp[-3].label + " %= " + yyvsp[0].label + ";\n";
			}
#line 1984 "y.tab.c"
    break;

  case 45:
#line 490 "sintatica.y"
                        {
				yyval.tipo = "int";
				yyval.conteudo = yyvsp[0].label;
				yyval.label = gentempcode();
				yyval.traducao = "\t" + yyval.label + " = " + yyvsp[0].label + ";\n";

			}
#line 1996 "y.tab.c"
    break;

  case 46:
#line 499 "sintatica.y"
                        {
				yyval.tipo = "float";
				yyval.conteudo = yyvsp[0].label;
				yyval.label = gentempcode();
				yyval.traducao = "\t" + yyval.label + " = " + yyvsp[0].label + ";\n";
			}
#line 2007 "y.tab.c"
    break;

  case 47:
#line 507 "sintatica.y"
                        {
				yyval.tipo = "char";
				yyval.label = gentempcode();
				yyval.traducao = "\t" + yyval.label + " = " + '"' + yyvsp[-1].label + '"' + ";\n";
			}
#line 2017 "y.tab.c"
    break;

  case 48:
#line 514 "sintatica.y"
                        {
				bool encontrei = false;
				TIPO_SIMBOLO variavel;
				for (int i = 0; i < tabelaSimbolos.size(); i++){
					if(tabelaSimbolos[i].nomeVariavel == yyvsp[0].label){
						variavel = tabelaSimbolos[i];
						encontrei = true;
					} 
				}

				if(!encontrei){
					yyerror(" erro: a variável '" + yyvsp[0].label + "' não foi declarada");
				}

				yyval.tipo = variavel.tipoVariavel;
				yyval.label = gentempcode();
				yyval.traducao = "\t" + yyval.label + " = " + yyvsp[0].label + ";\n";
			}
#line 2040 "y.tab.c"
    break;

  case 49:
#line 535 "sintatica.y"
                        {
				yyval.label = gentempcode();
				yyval.traducao = "\t" + yyval.label + " = " + "(float) " + yyvsp[-1].label + ";\n";   
			}
#line 2049 "y.tab.c"
    break;

  case 50:
#line 541 "sintatica.y"
                        {
				TIPO_SIMBOLO var1 = getSimbolo(yyvsp[-5].label);

				bool validador = comparaTipo(var1.tipoVariavel, "float");
				if (validador)
					yyval.traducao = "\t" + yyvsp[-5].label + " = "+ "(float) " + yyvsp[-1].label + ";\n";
				
				else{
					yyerror("erro: atribuição inválida");
					exit(1);
				}
			}
#line 2066 "y.tab.c"
    break;


#line 2070 "y.tab.c"

      default: break;
    }
  /* User semantic actions sometimes alter yychar, and that requires
     that yytoken be updated with the new translation.  We take the
     approach of translating immediately before every use of yytoken.
     One alternative is translating here after every semantic action,
     but that translation would be missed if the semantic action invokes
     YYABORT, YYACCEPT, or YYERROR immediately after altering yychar or
     if it invokes YYBACKUP.  In the case of YYABORT or YYACCEPT, an
     incorrect destructor might then be invoked immediately.  In the
     case of YYERROR or YYBACKUP, subsequent parser actions might lead
     to an incorrect destructor call or verbose syntax error message
     before the lookahead is translated.  */
  YY_SYMBOL_PRINT ("-> $$ =", yyr1[yyn], &yyval, &yyloc);

  YYPOPSTACK (yylen);
  yylen = 0;
  YY_STACK_PRINT (yyss, yyssp);

  *++yyvsp = yyval;

  /* Now 'shift' the result of the reduction.  Determine what state
     that goes to, based on the state we popped back to and the rule
     number reduced by.  */
  {
    const int yylhs = yyr1[yyn] - YYNTOKENS;
    const int yyi = yypgoto[yylhs] + *yyssp;
    yystate = (0 <= yyi && yyi <= YYLAST && yycheck[yyi] == *yyssp
               ? yytable[yyi]
               : yydefgoto[yylhs]);
  }

  goto yynewstate;


/*--------------------------------------.
| yyerrlab -- here on detecting error.  |
`--------------------------------------*/
yyerrlab:
  /* Make sure we have latest lookahead translation.  See comments at
     user semantic actions for why this is necessary.  */
  yytoken = yychar == YYEMPTY ? YYEMPTY : YYTRANSLATE (yychar);

  /* If not already recovering from an error, report this error.  */
  if (!yyerrstatus)
    {
      ++yynerrs;
#if ! YYERROR_VERBOSE
      yyerror (YY_("syntax error"));
#else
# define YYSYNTAX_ERROR yysyntax_error (&yymsg_alloc, &yymsg, \
                                        yyssp, yytoken)
      {
        char const *yymsgp = YY_("syntax error");
        int yysyntax_error_status;
        yysyntax_error_status = YYSYNTAX_ERROR;
        if (yysyntax_error_status == 0)
          yymsgp = yymsg;
        else if (yysyntax_error_status == 1)
          {
            if (yymsg != yymsgbuf)
              YYSTACK_FREE (yymsg);
            yymsg = YY_CAST (char *, YYSTACK_ALLOC (YY_CAST (YYSIZE_T, yymsg_alloc)));
            if (!yymsg)
              {
                yymsg = yymsgbuf;
                yymsg_alloc = sizeof yymsgbuf;
                yysyntax_error_status = 2;
              }
            else
              {
                yysyntax_error_status = YYSYNTAX_ERROR;
                yymsgp = yymsg;
              }
          }
        yyerror (yymsgp);
        if (yysyntax_error_status == 2)
          goto yyexhaustedlab;
      }
# undef YYSYNTAX_ERROR
#endif
    }



  if (yyerrstatus == 3)
    {
      /* If just tried and failed to reuse lookahead token after an
         error, discard it.  */

      if (yychar <= YYEOF)
        {
          /* Return failure if at end of input.  */
          if (yychar == YYEOF)
            YYABORT;
        }
      else
        {
          yydestruct ("Error: discarding",
                      yytoken, &yylval);
          yychar = YYEMPTY;
        }
    }

  /* Else will try to reuse lookahead token after shifting the error
     token.  */
  goto yyerrlab1;


/*---------------------------------------------------.
| yyerrorlab -- error raised explicitly by YYERROR.  |
`---------------------------------------------------*/
yyerrorlab:
  /* Pacify compilers when the user code never invokes YYERROR and the
     label yyerrorlab therefore never appears in user code.  */
  if (0)
    YYERROR;

  /* Do not reclaim the symbols of the rule whose action triggered
     this YYERROR.  */
  YYPOPSTACK (yylen);
  yylen = 0;
  YY_STACK_PRINT (yyss, yyssp);
  yystate = *yyssp;
  goto yyerrlab1;


/*-------------------------------------------------------------.
| yyerrlab1 -- common code for both syntax error and YYERROR.  |
`-------------------------------------------------------------*/
yyerrlab1:
  yyerrstatus = 3;      /* Each real token shifted decrements this.  */

  for (;;)
    {
      yyn = yypact[yystate];
      if (!yypact_value_is_default (yyn))
        {
          yyn += YYTERROR;
          if (0 <= yyn && yyn <= YYLAST && yycheck[yyn] == YYTERROR)
            {
              yyn = yytable[yyn];
              if (0 < yyn)
                break;
            }
        }

      /* Pop the current state because it cannot handle the error token.  */
      if (yyssp == yyss)
        YYABORT;


      yydestruct ("Error: popping",
                  yystos[yystate], yyvsp);
      YYPOPSTACK (1);
      yystate = *yyssp;
      YY_STACK_PRINT (yyss, yyssp);
    }

  YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN
  *++yyvsp = yylval;
  YY_IGNORE_MAYBE_UNINITIALIZED_END


  /* Shift the error token.  */
  YY_SYMBOL_PRINT ("Shifting", yystos[yyn], yyvsp, yylsp);

  yystate = yyn;
  goto yynewstate;


/*-------------------------------------.
| yyacceptlab -- YYACCEPT comes here.  |
`-------------------------------------*/
yyacceptlab:
  yyresult = 0;
  goto yyreturn;


/*-----------------------------------.
| yyabortlab -- YYABORT comes here.  |
`-----------------------------------*/
yyabortlab:
  yyresult = 1;
  goto yyreturn;


#if !defined yyoverflow || YYERROR_VERBOSE
/*-------------------------------------------------.
| yyexhaustedlab -- memory exhaustion comes here.  |
`-------------------------------------------------*/
yyexhaustedlab:
  yyerror (YY_("memory exhausted"));
  yyresult = 2;
  /* Fall through.  */
#endif


/*-----------------------------------------------------.
| yyreturn -- parsing is finished, return the result.  |
`-----------------------------------------------------*/
yyreturn:
  if (yychar != YYEMPTY)
    {
      /* Make sure we have latest lookahead translation.  See comments at
         user semantic actions for why this is necessary.  */
      yytoken = YYTRANSLATE (yychar);
      yydestruct ("Cleanup: discarding lookahead",
                  yytoken, &yylval);
    }
  /* Do not reclaim the symbols of the rule whose action triggered
     this YYABORT or YYACCEPT.  */
  YYPOPSTACK (yylen);
  YY_STACK_PRINT (yyss, yyssp);
  while (yyssp != yyss)
    {
      yydestruct ("Cleanup: popping",
                  yystos[+*yyssp], yyvsp);
      YYPOPSTACK (1);
    }
#ifndef yyoverflow
  if (yyss != yyssa)
    YYSTACK_FREE (yyss);
#endif
#if YYERROR_VERBOSE
  if (yymsg != yymsgbuf)
    YYSTACK_FREE (yymsg);
#endif
  return yyresult;
}
#line 555 "sintatica.y"


#include "lex.yy.c"

int yyparse();

string gentempcode(){
	var_temp_qnt++;
	return "t" + std::to_string(var_temp_qnt);
}

void addSimbolo(string nome, string tipo){
	TIPO_SIMBOLO valor;
	valor.nomeVariavel = nome;
	valor.tipoVariavel = tipo;

	tabelaSimbolos.push_back(valor);					
}

bool buscaVariavel(string nomeVariavel){
	for (int i = 0; i < tabelaSimbolos.size(); i++){
		if(tabelaSimbolos[i].nomeVariavel == nomeVariavel){
			return true;
		}
	}
	return false;
}

TIPO_SIMBOLO getSimbolo(string variavel)
{
	for (int i = 0; i < tabelaSimbolos.size(); i++){
		if(tabelaSimbolos[i].nomeVariavel == variavel)
			return tabelaSimbolos[i];					
	}
}

//Conversão implícita
string cast(TIPO_SIMBOLO var1, TIPO_SIMBOLO var2){
	if (var1.tipoVariavel == var2.tipoVariavel) return var1.nomeVariavel;
	
	else if (var1.tipoVariavel == "int" && var2.tipoVariavel == "float")
		return "(float) " + var1.nomeVariavel;
	
	else if(var1.tipoVariavel == "float" && var2.tipoVariavel == "int")
		return "(float) " + var2.nomeVariavel;
	
	// else if (var1.tipoVariavel == "int" && var2.tipoVariavel == "char"
	// 		|| var1.tipoVariavel == "char" && var2.tipoVariavel == "int"){
				
	// 		}


	else yyerror("erro: Casting inválido");
}

bool comparaTipo(string tipo1, string tipo2){
	if (tipo1 == tipo2) return true;

	return false;
}

void inicializaAscii(){
	TABELA_ASCII elemento;

	for ( char i = 0; i < 127; i++ ) {

		elemento.indice = i;
		elemento.caracter = i;
        
		table_ascii.push_back(elemento);
    }
}


int main( int argc, char* argv[] )
{

	inicializaAscii();

	var_temp_qnt = 0;
	
	yyparse();

	return 0;
}

void yyerror( string MSG )
{
	cout << MSG << endl;
	exit (0);
}				
