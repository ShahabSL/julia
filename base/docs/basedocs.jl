# This file is a part of Julia. License is MIT: https://julialang.org/license
#

module BaseDocs

@nospecialize # don't specialize on any arguments of the methods declared herein

struct Keyword
    name::Symbol
end
macro kw_str(text)
    return Keyword(Symbol(text))
end

"""
**Welcome to Julia $(string(VERSION)).** The full manual is available at

    https://docs.julialang.org

as well as many great tutorials and learning resources:

    https://julialang.org/learning/

For help on a specific function or macro, type `?` followed
by its name, e.g. `?cos`, or `?@time`, and press enter.
Type `;` to enter shell mode, `]` to enter package mode.

To exit the interactive session, type `CTRL-D` (press the
control key together with the `d` key), or type `exit()`.
"""
kw"help", kw"Julia", kw"julia", kw""

"""
    using

`using Foo` will load the module or package `Foo` and make its [`export`](@ref)ed names
available for direct use. Names can also be used via dot syntax (e.g. `Foo.foo` to access
the name `foo`), whether they are `export`ed or not.
See the [manual section about modules](@ref modules) for details.

!!! note
    When two or more packages/modules export a name and that name does not refer to the
    same thing in each of the packages, and the packages are loaded via `using` without
    an explicit list of names, it is an error to reference that name without qualification.
    It is thus recommended that code intended to be forward-compatible with future versions
    of its dependencies and of Julia, e.g., code in released packages, list the names it
    uses from each loaded package, e.g., `using Foo: Foo, f` rather than `using Foo`.
"""
kw"using"

"""
    import

`import Foo` will load the module or package `Foo`.
Names from the imported `Foo` module can be accessed with dot syntax
(e.g. `Foo.foo` to access the name `foo`).
See the [manual section about modules](@ref modules) for details.
"""
kw"import"

"""
    export

`export` is used within modules to tell Julia which names should be
made available to the user. For example: `export foo` makes the name
`foo` available when [`using`](@ref) the module.
See the [manual section about modules](@ref modules) for details.
"""
kw"export"

"""
    public

`public` is used within modules to tell Julia which names are part of the
public API of the module. For example: `public foo` indicates that the name
`foo` is public, without making it available when [`using`](@ref) the module.

As [`export`](@ref) already indicates that a name is public, it is
unnecessary and an error to declare a name both as `public` and as `export`ed.
See the [manual section about modules](@ref modules) for details.

!!! compat "Julia 1.11"
    The public keyword was added in Julia 1.11. Prior to this the notion
    of publicness was less explicit.
"""
kw"public"

"""
    as

`as` is used as a keyword to rename an identifier brought into scope by
`import` or `using`, for the purpose of working around name conflicts as
well as for shortening names.  (Outside of `import` or `using` statements,
`as` is not a keyword and can be used as an ordinary identifier.)

`import LinearAlgebra as LA` brings the imported `LinearAlgebra` standard library
into scope as `LA`.

`import LinearAlgebra: eigen as eig, cholesky as chol` brings the `eigen` and `cholesky` methods
from `LinearAlgebra` into scope as `eig` and `chol` respectively.

`as` works with `using` only when individual identifiers are brought into scope.
For example, `using LinearAlgebra: eigen as eig` or `using LinearAlgebra: eigen as eig, cholesky as chol` works,
but `using LinearAlgebra as LA` is invalid syntax, since it is nonsensical to
rename *all* exported names from `LinearAlgebra` to `LA`.
"""
kw"as"

"""
    abstract type

`abstract type` declares a type that cannot be instantiated, and serves only as a node in the
type graph, thereby describing sets of related concrete types: those concrete types
which are their descendants. Abstract types form the conceptual hierarchy which makes
Julia’s type system more than just a collection of object implementations. For example:

```julia
abstract type Number end
abstract type Real <: Number end
```
[`Number`](@ref) has no supertype, whereas [`Real`](@ref) is an abstract subtype of `Number`.
"""
kw"abstract type", kw"abstract"

"""
    module

`module` declares a [`Module`](@ref), which is a separate global variable workspace. Within a
module, you can control which names from other modules are visible (via importing), and
specify which of your names are intended to be public (via `export` and `public`).
Modules allow you to create top-level definitions without worrying about name conflicts
when your code is used together with somebody else’s.
See the [manual section about modules](@ref modules) for more details.

# Examples
```julia
module Foo
import Base.show
export MyType, foo

struct MyType
    x
end

bar(x) = 2x
foo(a::MyType) = bar(a.x) + 1
show(io::IO, a::MyType) = print(io, "MyType \$(a.x)")
end
```
"""
kw"module"

"""
    __init__

The `__init__()` function in a module executes immediately *after* the module is loaded at
runtime for the first time. It is called once, after all other statements in the module
have been executed. Because it is called after fully importing the module, `__init__`
functions of submodules will be executed first. Two typical uses of `__init__` are calling
runtime initialization functions of external C libraries and initializing global constants
that involve pointers returned by external libraries.
See the [manual section about modules](@ref modules) for more details.

See also: [`OncePerProcess`](@ref).

# Examples
```julia
const foo_data_ptr = Ref{Ptr{Cvoid}}(0)
function __init__()
    ccall((:foo_init, :libfoo), Cvoid, ())
    foo_data_ptr[] = ccall((:foo_data, :libfoo), Ptr{Cvoid}, ())
    nothing
end
```
"""
kw"__init__"

"""
    baremodule

`baremodule` declares a module that does not contain `using Base` or local definitions of
[`eval`](@ref Main.eval) and [`include`](@ref Base.include). It does still import `Core`. In other words,

```julia
module Mod

...

end
```

is equivalent to

```julia
baremodule Mod

using Base

eval(x) = Core.eval(Mod, x)
include(p) = Base.include(Mod, p)

...

end
```
"""
kw"baremodule"

"""
    primitive type

`primitive type` declares a concrete type whose data consists only of a series of bits. Classic
examples of primitive types are integers and floating-point values. Some example built-in
primitive type declarations:

```julia
primitive type Char 32 end
primitive type Bool <: Integer 8 end
```
The number after the name indicates how many bits of storage the type requires. Currently,
only sizes that are multiples of 8 bits are supported.
The [`Bool`](@ref) declaration shows how a primitive type can be optionally
declared to be a subtype of some supertype.
"""
kw"primitive type"

"""
    macro

`macro` defines a method for inserting generated code into a program.
A macro maps a sequence of argument expressions to a returned expression, and the
resulting expression is substituted directly into the program at the point where
the macro is invoked.
Macros are a way to run generated code without calling [`eval`](@ref Main.eval),
since the generated code instead simply becomes part of the surrounding program.
Macro arguments may include expressions, literal values, and symbols. Macros can be defined for
variable number of arguments (varargs), but do not accept keyword arguments.
Every macro also implicitly gets passed the arguments `__source__`, which contains the line number
and file name the macro is called from, and `__module__`, which is the module the macro is expanded
in.

See the manual section on [Metaprogramming](@ref) for more information about how to write a macro.

# Examples
```jldoctest
julia> macro sayhello(name)
           return :( println("Hello, ", \$name, "!") )
       end
@sayhello (macro with 1 method)

julia> @sayhello "Charlie"
Hello, Charlie!

julia> macro saylots(x...)
           return :( println("Say: ", \$(x...)) )
       end
@saylots (macro with 1 method)

julia> @saylots "hey " "there " "friend"
Say: hey there friend
```
"""
kw"macro"

"""
    __module__

The argument `__module__` is only visible inside the macro, and it provides information
(in the form of a `Module` object) about the expansion context of the macro invocation.
See the manual section on [Macro invocation](@ref) for more information.
"""
kw"__module__"

"""
    __source__

The argument `__source__` is only visible inside the macro, and it provides information
(in the form of a `LineNumberNode` object) about the parser location of the `@` sign from
the macro invocation. See the manual section on [Macro invocation](@ref) for more information.
"""
kw"__source__"

"""
    local

`local` introduces a new local variable.
See the [manual section on variable scoping](@ref scope-of-variables) for more information.

# Examples
```jldoctest
julia> function foo(n)
           x = 0
           for i = 1:n
               local x # introduce a loop-local x
               x = i
           end
           x
       end
foo (generic function with 1 method)

julia> foo(10)
0
```
"""
kw"local"

"""
    global

`global x` makes `x` in the current scope and its inner scopes refer to the global
variable of that name.
See the [manual section on variable scoping](@ref scope-of-variables) for more information.

# Examples
```jldoctest
julia> z = 3
3

julia> function foo()
           global z = 6 # use the z variable defined outside foo
       end
foo (generic function with 1 method)

julia> foo()
6

julia> z
6
```
"""
kw"global"

"""
    for outer

Reuse an existing local variable for iteration in a `for` loop.

See the [manual section on variable scoping](@ref scope-of-variables) for more information.

See also [`for`](@ref).


# Examples
```jldoctest
julia> function f()
           i = 0
           for i = 1:3
               # empty
           end
           return i
       end;

julia> f()
0
```

```jldoctest
julia> function f()
           i = 0
           for outer i = 1:3
               # empty
           end
           return i
       end;

julia> f()
3
```

```jldoctest
julia> i = 0 # global variable
       for outer i = 1:3
       end
ERROR: syntax: no outer local variable declaration exists for "for outer"
[...]
```
"""
kw"outer"

"""
    ' '

A pair of single-quote characters delimit a [`Char`](@ref) (that is, character) literal.

# Examples
```jldoctest
julia> 'j'
'j': ASCII/Unicode U+006A (category Ll: Letter, lowercase)
```
"""
kw"''"

"""
    =

`=` is the assignment operator.
* For variable `a` and expression `b`, `a = b` makes `a` refer to the value of `b`.
* For functions `f(x)`, `f(x) = x` defines a new function constant `f`, or adds a new method to `f` if `f` is already defined; this usage is equivalent to `function f(x); x; end`.
* `a[i] = v` calls [`setindex!`](@ref)`(a,v,i)`.
* `a.b = c` calls [`setproperty!`](@ref)`(a,:b,c)`.
* Inside a function call, `f(a=b)` passes `b` as the value of keyword argument `a`.
* Inside parentheses with commas, `(a=1,)` constructs a [`NamedTuple`](@ref).

# Examples
Assigning `a` to `b` does not create a copy of `b`; instead use [`copy`](@ref) or [`deepcopy`](@ref).

```jldoctest
julia> b = [1]; a = b; b[1] = 2; a
1-element Vector{Int64}:
 2

julia> b = [1]; a = copy(b); b[1] = 2; a
1-element Vector{Int64}:
 1

```
Collections passed to functions are also not copied. Functions can modify (mutate) the contents of the objects their arguments refer to. (The names of functions which do this are conventionally suffixed with '!'.)
```jldoctest
julia> function f!(x); x[:] .+= 1; end
f! (generic function with 1 method)

julia> a = [1]; f!(a); a
1-element Vector{Int64}:
 2

```
Assignment can operate on multiple variables in parallel, taking values from an iterable:
```jldoctest
julia> a, b = 4, 5
(4, 5)

julia> a, b = 1:3
1:3

julia> a, b
(1, 2)

```
Assignment can operate on multiple variables in series, and will return the value of the right-hand-most expression:
```jldoctest
julia> a = [1]; b = [2]; c = [3]; a = b = c
1-element Vector{Int64}:
 3

julia> b[1] = 2; a, b, c
([2], [2], [2])

```
Assignment at out-of-bounds indices does not grow a collection. If the collection is a [`Vector`](@ref) it can instead be grown with [`push!`](@ref) or [`append!`](@ref).
```jldoctest
julia> a = [1, 1]; a[3] = 2
ERROR: BoundsError: attempt to access 2-element Vector{Int64} at index [3]
[...]

julia> push!(a, 2, 3)
4-element Vector{Int64}:
 1
 1
 2
 3

```
Assigning `[]` does not eliminate elements from a collection; instead use [`filter!`](@ref).
```jldoctest
julia> a = collect(1:3); a[a .<= 1] = []
ERROR: DimensionMismatch: tried to assign 0 elements to 1 destinations
[...]

julia> filter!(x -> x > 1, a) # in-place & thus more efficient than a = a[a .> 1]
2-element Vector{Int64}:
 2
 3

```
"""
kw"="

"""
    .=

Perform broadcasted assignment. The right-side argument is expanded as in
[`broadcast`](@ref) and then assigned into the left-side argument in-place.
Fuses with other dotted operators in the same expression; i.e. the whole
assignment expression is converted into a single loop.

`A .= B` is similar to `broadcast!(identity, A, B)`.

# Examples
```jldoctest
julia> A = zeros(4, 4); B = [1, 2, 3, 4];

julia> A .= B
4×4 Matrix{Float64}:
 1.0  1.0  1.0  1.0
 2.0  2.0  2.0  2.0
 3.0  3.0  3.0  3.0
 4.0  4.0  4.0  4.0

julia> A
4×4 Matrix{Float64}:
 1.0  1.0  1.0  1.0
 2.0  2.0  2.0  2.0
 3.0  3.0  3.0  3.0
 4.0  4.0  4.0  4.0
```
"""
kw".="

"""
    .

The dot operator is used to access fields or properties of objects and access
variables defined inside modules.

In general, `a.b` calls `getproperty(a, :b)` (see [`getproperty`](@ref Base.getproperty)).

# Examples
```jldoctest
julia> z = 1 + 2im; z.im
2

julia> Iterators.product
product (generic function with 1 method)
```
"""
kw"."

"""
    let

`let` blocks create a new hard scope and optionally introduce new local bindings.

Just like the [other scope constructs](@ref man-scope-table), `let` blocks define
the block of code where newly introduced local variables are accessible.
Additionally, the syntax has a special meaning for comma-separated assignments
and variable names that may optionally appear on the same line as the `let`:

```julia
let var1 = value1, var2, var3 = value3
    code
end
```

The variables introduced on this line are local to the `let` block and the assignments are
evaluated in order, with each right-hand side evaluated in the scope
without considering the name on the left-hand side. Therefore it makes
sense to write something like `let x = x`, since the two `x` variables are distinct with
the left-hand side locally shadowing the `x` from the outer scope. This can even
be a useful idiom as new local variables are freshly created each time local scopes
are entered, but this is only observable in the case of variables that outlive their
scope via closures.  A `let` variable without an assignment, such as `var2` in the
example above, declares a new local variable that is not yet bound to a value.

By contrast, [`begin`](@ref) blocks also group multiple expressions together but do
not introduce scope or have the special assignment syntax.

### Examples

In the function below, there is a single `x` that is iteratively updated three times by the `map`.
The closures returned all reference that one `x` at its final value:

```jldoctest
julia> function test_outer_x()
           x = 0
           map(1:3) do _
               x += 1
               return ()->x
           end
       end
test_outer_x (generic function with 1 method)

julia> [f() for f in test_outer_x()]
3-element Vector{Int64}:
 3
 3
 3
```

If, however, we add a `let` block that introduces a _new_ local variable we will end up
with three distinct variables being captured (one at each iteration) even though we
chose to use (shadow) the same name.

```jldoctest
julia> function test_let_x()
           x = 0
           map(1:3) do _
               x += 1
               let x = x
                   return ()->x
               end
           end
       end
test_let_x (generic function with 1 method)

julia> [f() for f in test_let_x()]
3-element Vector{Int64}:
 1
 2
 3
```

All scope constructs that introduce new local variables behave this way
when repeatedly run; the distinctive feature of `let` is its ability
to succinctly declare new `local`s that may shadow outer variables of the same
name. For example, directly using the argument of the `do` function similarly
captures three distinct variables:

```jldoctest
julia> function test_do_x()
           map(1:3) do x
               return ()->x
           end
       end
test_do_x (generic function with 1 method)

julia> [f() for f in test_do_x()]
3-element Vector{Int64}:
 1
 2
 3
```


"""
kw"let"

"""
    quote

`quote` creates multiple expression objects in a block without using the explicit
[`Expr`](@ref) constructor. For example:

```julia
ex = quote
    x = 1
    y = 2
    x + y
end
```
Unlike the other means of quoting, `:( ... )`, this form introduces `QuoteNode` elements
to the expression tree, which must be considered when directly manipulating the tree.
For other purposes, `:( ... )` and `quote .. end` blocks are treated identically.
"""
kw"quote"

"""
    @

The at sign followed by a macro name marks a macro call. Macros provide the
ability to include generated code in the final body of a program. A macro maps
a tuple of arguments, expressed as space-separated expressions or a
function-call-like argument list, to a returned *expression*. The resulting
expression is compiled directly into the surrounding code. See
[Metaprogramming](@ref man-macros) for more details and examples.
"""
kw"@"

"""
    {}

Curly braces are used to specify [type parameters](@ref man-parametric-types).

Type parameters allow a single type declaration to introduce a whole family of
new types — one for each possible combination of parameter values. For example,
the [`Set`](@ref) type describes many possible types of sets; it uses one type
parameter to describe the type of the elements it contains. The specific _parameterized_
types `Set{Float64}` and `Set{Int64}` describe two _concrete_ types: both are
subtypes ([`<:`](@ref)) of `Set`, but the former has `Float64` elements and the latter
has `Int64` elements.
"""
kw"{", kw"{}", kw"}"

"""
    []

Square brackets are used for [indexing](@ref man-array-indexing) ([`getindex`](@ref)),
[indexed assignment](@ref man-indexed-assignment) ([`setindex!`](@ref)),
[array literals](@ref man-array-literals) ([`Base.vect`](@ref)),
[array concatenation](@ref man-array-concatenation) ([`vcat`](@ref), [`hcat`](@ref), [`hvcat`](@ref), [`hvncat`](@ref)),
and [array comprehensions](@ref man-comprehensions) ([`collect`](@ref)).
"""
kw"[", kw"[]", kw"]"

"""
    ()

Parentheses are used to group expressions, call functions, and construct [tuples](@ref Tuple) and [named tuples](@ref NamedTuple).
"""
kw"(", kw"()", kw")"

"""
    #

The number sign (or hash) character is used to begin a single-line comment.
"""
kw"#"

"""
    #= =#

A multi-line comment begins with `#=` and ends with `=#`, and may be nested.
"""
kw"#=", kw"=#"

"""
    ;

Semicolons are used as statement separators and mark the beginning of keyword arguments in function declarations or calls.
"""
kw";"

"""
    Expr(head::Symbol, args...)

A type representing compound expressions in parsed julia code (ASTs).
Each expression consists of a `head` `Symbol` identifying which kind of
expression it is (e.g. a call, for loop, conditional statement, etc.),
and subexpressions (e.g. the arguments of a call).
The subexpressions are stored in a `Vector{Any}` field called `args`.

See the manual chapter on [Metaprogramming](@ref) and the developer
documentation [Julia ASTs](@ref).

# Examples
```jldoctest
julia> Expr(:call, :+, 1, 2)
:(1 + 2)

julia> dump(:(a ? b : c))
Expr
  head: Symbol if
  args: Array{Any}((3,))
    1: Symbol a
    2: Symbol b
    3: Symbol c
```
"""
Expr

"""
    :expr

Quote an expression `expr`, returning the abstract syntax tree (AST) of `expr`.
The AST may be of type `Expr`, `Symbol`, or a literal value.
The syntax `:identifier` evaluates to a `Symbol`.

See also: [`Expr`](@ref), [`Symbol`](@ref), [`Meta.parse`](@ref)

# Examples
```jldoctest
julia> expr = :(a = b + 2*x)
:(a = b + 2x)

julia> sym = :some_identifier
:some_identifier

julia> value = :0xff
0xff

julia> typeof((expr, sym, value))
Tuple{Expr, Symbol, UInt8}
```
"""
(:)

"""
    \$

Interpolation operator for interpolating into e.g. [strings](@ref string-interpolation)
and [expressions](@ref man-expression-interpolation).

# Examples
```jldoctest
julia> name = "Joe"
"Joe"

julia> "My name is \$name."
"My name is Joe."
```
"""
kw"$"

"""
    const

`const` is used to declare global variables whose values will not change. In almost all code
(and particularly performance sensitive code) global variables should be declared
constant in this way.

```julia
const x = 5
```

Multiple variables can be declared within a single `const`:
```julia
const y, z = 7, 11
```

Note that `const` only applies to one `=` operation, therefore `const x = y = 1`
declares `x` to be constant but not `y`. On the other hand, `const x = const y = 1`
declares both `x` and `y` constant.

Note that "constant-ness" does not extend into mutable containers; only the
association between a variable and its value is constant.
If `x` is an array or dictionary (for example) you can still modify, add, or remove elements.

In some cases changing the value of a `const` variable gives a warning instead of
an error.
However, this can produce unpredictable behavior or corrupt the state of your program,
and so should be avoided.
This feature is intended only for convenience during interactive use.
"""
kw"const"

"""
    function

Functions are defined with the `function` keyword:

```julia
function add(a, b)
    return a + b
end
```
Or the short form notation:

```julia
add(a, b) = a + b
```

The use of the [`return`](@ref) keyword is exactly the same as in other languages,
but is often optional. A function without an explicit `return` statement will return
the last expression in the function body.
"""
kw"function"

"""
    x -> y

Create an anonymous function mapping argument(s) `x` to the function body `y`.

```jldoctest
julia> f = x -> x^2 + 2x - 1
#1 (generic function with 1 method)

julia> f(2)
7
```

Anonymous functions can also be defined for multiple arguments.
```jldoctest
julia> g = (x,y) -> x^2 + y^2
#2 (generic function with 1 method)

julia> g(2,3)
13
```

See the manual section on [anonymous functions](@ref man-anonymous-functions) for more details.
"""
kw"->"

"""
    return

`return x` causes the enclosing function to exit early, passing the given value `x`
back to its caller. `return` by itself with no value is equivalent to `return nothing`
(see [`nothing`](@ref)).

```julia
function compare(a, b)
    a == b && return "equal to"
    a < b ? "less than" : "greater than"
end
```
In general you can place a `return` statement anywhere within a function body, including
within deeply nested loops or conditionals, but be careful with `do` blocks. For
example:

```julia
function test1(xs)
    for x in xs
        iseven(x) && return 2x
    end
end

function test2(xs)
    map(xs) do x
        iseven(x) && return 2x
        x
    end
end
```
In the first example, the return breaks out of `test1` as soon as it hits
an even number, so `test1([5,6,7])` returns `12`.

You might expect the second example to behave the same way, but in fact the `return`
there only breaks out of the *inner* function (inside the `do` block) and gives a value
back to `map`. `test2([5,6,7])` then returns `[5,12,7]`.

When used in a top-level expression (i.e. outside any function), `return` causes
the entire current top-level expression to terminate early.
"""
kw"return"

"""
    if/elseif/else

`if`/`elseif`/`else` performs conditional evaluation, which allows portions of code to
be evaluated or not evaluated depending on the value of a boolean expression. Here is
the anatomy of the `if`/`elseif`/`else` conditional syntax:

```julia
if x < y
    println("x is less than y")
elseif x > y
    println("x is greater than y")
else
    println("x is equal to y")
end
```
If the condition expression `x < y` is true, then the corresponding block is evaluated;
otherwise the condition expression `x > y` is evaluated, and if it is true, the
corresponding block is evaluated; if neither expression is true, the `else` block is
evaluated. The `elseif` and `else` blocks are optional, and as many `elseif` blocks as
desired can be used.

In contrast to some other languages conditions must be of type `Bool`. It does not
suffice for conditions to be convertible to `Bool`.
```jldoctest
julia> if 1 end
ERROR: TypeError: non-boolean (Int64) used in boolean context
```
"""
kw"if", kw"elseif", kw"else"

"""
    a ? b : c

Short form for conditionals; read "if `a`, evaluate `b` otherwise evaluate `c`".
Also known as the [ternary operator](https://en.wikipedia.org/wiki/%3F:).

This syntax is equivalent to `if a; b else c end`, but is often used to
emphasize the value `b`-or-`c` which is being used as part of a larger
expression, rather than the side effects that evaluating `b` or `c` may have.

See the manual section on [control flow](@ref man-conditional-evaluation) for more details.

# Examples
```jldoctest
julia> x = 1; y = 2;

julia> x > y ? println("x is larger") : println("x is not larger")
x is not larger

julia> x > y ? "x is larger" : x == y ? "x and y are equal" : "y is larger"
"y is larger"
```
"""
kw"?", kw"?:"

"""
    for

`for` loops repeatedly evaluate a block of statements while
iterating over a sequence of values.

The iteration variable is always a new variable, even if a variable of the same name
exists in the enclosing scope.
Use [`outer`](@ref) to reuse an existing local variable for iteration.

# Examples
```jldoctest
julia> for i in [1, 4, 0]
           println(i)
       end
1
4
0
```
"""
kw"for"

"""
    while

`while` loops repeatedly evaluate a conditional expression, and continue evaluating the
body of the while loop as long as the expression remains true. If the condition
expression is false when the while loop is first reached, the body is never evaluated.

# Examples
```jldoctest
julia> i = 1
1

julia> while i < 5
           println(i)
           global i += 1
       end
1
2
3
4
```
"""
kw"while"

"""
    end

`end` marks the conclusion of a block of expressions, for example
[`module`](@ref), [`struct`](@ref), [`mutable struct`](@ref),
[`begin`](@ref), [`let`](@ref), [`for`](@ref) etc.

`end` may also be used when indexing to represent the last index of a
collection or the last index of a dimension of an array.

# Examples
```jldoctest
julia> A = [1 2; 3 4]
2×2 Matrix{Int64}:
 1  2
 3  4

julia> A[end, :]
2-element Vector{Int64}:
 3
 4
```
"""
kw"end"

"""
    try/catch

A `try`/`catch` statement allows intercepting errors (exceptions) thrown
by [`throw`](@ref) so that program execution can continue.
For example, the following code attempts to write a file, but warns the user
and proceeds instead of terminating execution if the file cannot be written:

```julia
try
    open("/danger", "w") do f
        println(f, "Hello")
    end
catch
    @warn "Could not write file."
end
```

or, when the file cannot be read into a variable:

```julia
lines = try
    open("/danger", "r") do f
        readlines(f)
    end
catch
    @warn "File not found."
end
```

The syntax `catch e` (where `e` is any variable) assigns the thrown
exception object to the given variable within the `catch` block.

The power of the `try`/`catch` construct lies in the ability to unwind a deeply
nested computation immediately to a much higher level in the stack of calling functions.

A `try/catch` block can also have an `else` clause that executes only if no exception occurred:
```julia
try
    a_dangerous_operation()
catch
    @warn "The operation failed."
else
    @info "The operation succeeded."
end
```

A `try` or `try`/`catch` block can also have a [`finally`](@ref) clause that executes
at the end, regardless of whether an exception occurred.  For example, this can be
used to guarantee that an opened file is closed:
```julia
f = open("file")
try
    operate_on_file(f)
catch
    @warn "An error occurred!"
finally
    close(f)
end
```
(`finally` can also be used without a `catch` block.)

!!! compat "Julia 1.8"
    Else clauses require at least Julia 1.8.
"""
kw"try", kw"catch"

"""
    finally

Run some code when a given `try` block of code exits, regardless
of how it exits. For example, here is how we can guarantee that an opened file is
closed:

```julia
f = open("file")
try
    operate_on_file(f)
finally
    close(f)
end
```

When control leaves the [`try`](@ref) block (for example, due to a [`return`](@ref), or just finishing
normally), [`close(f)`](@ref) will be executed. If the `try` block exits due to an exception,
the exception will continue propagating. A `catch` block may be combined with `try` and
`finally` as well. In this case the `finally` block will run after `catch` has handled
the error.

When evaluating a `try/catch/else/finally` expression, the value of the entire
expression is the value of the last block executed, excluding the `finally`
block. For example:

```jldoctest
julia> try
           1
       finally
           2
       end
1

julia> try
           error("")
       catch
           1
       else
           2
       finally
           3
       end
1

julia> try
           0
       catch
           1
       else
           2
       finally
           3
       end
2
```
"""
kw"finally"

"""
    break

Break out of a loop immediately.

# Examples
```jldoctest
julia> i = 0
0

julia> while true
           global i += 1
           i > 5 && break
           println(i)
       end
1
2
3
4
5
```
"""
kw"break"

"""
    continue

Skip the rest of the current loop iteration.

# Examples
```jldoctest
julia> for i = 1:6
           iseven(i) && continue
           println(i)
       end
1
3
5
```
"""
kw"continue"

"""
    do

Create an anonymous function and pass it as the first argument to
a function call.
For example:

```julia
map(1:10) do x
    2x
end
```

is equivalent to `map(x->2x, 1:10)`.

Use multiple arguments like so:

```julia
map(1:10, 11:20) do x, y
    x + y
end
```
"""
kw"do"

"""
    ...

The "splat" operator, `...`, represents a sequence of arguments.
`...` can be used in function definitions, to indicate that the function
accepts an arbitrary number of arguments.
`...` can also be used to apply a function to a sequence of arguments.

# Examples
```jldoctest
julia> add(xs...) = reduce(+, xs)
add (generic function with 1 method)

julia> add(1, 2, 3, 4, 5)
15

julia> add([1, 2, 3]...)
6

julia> add(7, 1:100..., 1000:1100...)
111107
```
"""
kw"..."

"""
    ;

`;` has a similar role in Julia as in many C-like languages, and is used to delimit the
end of the previous statement.

`;` is not necessary at the end of a line, but can be used to
separate statements on a single line or to join statements into a single expression.

Adding `;` at the end of a line in the REPL will suppress printing the result of that expression.

In function declarations, and optionally in calls, `;` separates regular arguments from keywords.

In array literals, arguments separated by semicolons have their contents
concatenated together. A separator made of a single `;` concatenates vertically
(i.e. along the first dimension), `;;` concatenates horizontally (second
dimension), `;;;` concatenates along the third dimension, etc. Such a separator
can also be used in last position in the square brackets to add trailing
dimensions of length 1.

A `;` in first position inside of parentheses can be used to construct a named
tuple. The same `(; ...)` syntax on the left side of an assignment allows for
property destructuring.

In the standard REPL, typing `;` on an empty line will switch to shell mode.

# Examples
```jldoctest
julia> function foo()
           x = "Hello, "; x *= "World!"
           return x
       end
foo (generic function with 1 method)

julia> bar() = (x = "Hello, Mars!"; return x)
bar (generic function with 1 method)

julia> foo();

julia> bar()
"Hello, Mars!"

julia> function plot(x, y; style="solid", width=1, color="black")
           ###
       end

julia> A = [1 2; 3 4]
2×2 Matrix{Int64}:
 1  2
 3  4

julia> [1; 3;; 2; 4;;; 10*A]
2×2×2 Array{Int64, 3}:
[:, :, 1] =
 1  2
 3  4

[:, :, 2] =
 10  20
 30  40

julia> [2; 3;;;]
2×1×1 Array{Int64, 3}:
[:, :, 1] =
 2
 3

julia> nt = (; x=1) # without the ; or a trailing comma this would assign to x
(x = 1,)

julia> key = :a; c = 3;

julia> nt2 = (; key => 1, b=2, c, nt.x)
(a = 1, b = 2, c = 3, x = 1)

julia> (; b, x) = nt2; # set variables b and x using property destructuring

julia> b, x
(2, 1)

julia> ; # upon typing ;, the prompt changes (in place) to: shell>
shell> echo hello
hello
```
"""
kw";"

"""
    x && y

Short-circuiting boolean AND.

This is equivalent to `x ? y : false`: it returns `false` if `x` is `false` and the result of evaluating `y` if `x` is `true`.
Note that if `y` is an expression, it is only evaluated when `x` is `true`, which is called "short-circuiting" behavior.

Also, `y` does not need to have a boolean value.  This means that `(condition) && (statement)` can be used as shorthand for
`if condition; statement; end` for an arbitrary `statement`.

See also [`&`](@ref), the ternary operator `? :`, and the manual section on [control flow](@ref man-conditional-evaluation).

# Examples
```jldoctest
julia> x = 3;

julia> x > 1 && x < 10 && x isa Int
true

julia> x < 0 && error("expected positive x")
false

julia> x > 0 && "not a boolean"
"not a boolean"
```
"""
kw"&&"

"""
    x || y

Short-circuiting boolean OR.

This is equivalent to `x ? true : y`: it returns `true` if `x` is `true` and the result of evaluating `y` if `x` is `false`.
Note that if `y` is an expression, it is only evaluated when `x` is `false`, which is called "short-circuiting" behavior.

Also, `y` does not need to have a boolean value.  This means that `(condition) || (statement)` can be used as shorthand for
`if !(condition); statement; end` for an arbitrary `statement`.

See also: [`|`](@ref), [`xor`](@ref), [`&&`](@ref).

# Examples
```jldoctest
julia> pi < 3 || ℯ < 3
true

julia> false || true || println("neither is true!")
true

julia> pi < 3 || "not a boolean"
"not a boolean"
```
"""
kw"||"

"""
    ccall((function_name, library), returntype, (argtype1, ...), argvalue1, ...)
    ccall(function_name, returntype, (argtype1, ...), argvalue1, ...)
    ccall(function_pointer, returntype, (argtype1, ...), argvalue1, ...)

Call a function in a C-exported shared library, specified by the tuple `(function_name, library)`,
where each component is either a string or symbol. Instead of specifying a library,
one can also use a `function_name` symbol or string, which is resolved in the current process.
Alternatively, `ccall` may also be used to call a function pointer `function_pointer`, such as one returned by `dlsym`.

Note that the argument type tuple must be a literal tuple, and not a tuple-valued
variable or expression.

Each `argvalue` to the `ccall` will be converted to the corresponding
`argtype`, by automatic insertion of calls to `unsafe_convert(argtype,
cconvert(argtype, argvalue))`. (See also the documentation for
[`unsafe_convert`](@ref Base.unsafe_convert) and [`cconvert`](@ref Base.cconvert) for further details.)
In most cases, this simply results in a call to `convert(argtype, argvalue)`.
"""
kw"ccall"

"""
    llvmcall(fun_ir::String, returntype, Tuple{argtype1, ...}, argvalue1, ...)
    llvmcall((mod_ir::String, entry_fn::String), returntype, Tuple{argtype1, ...}, argvalue1, ...)
    llvmcall((mod_bc::Vector{UInt8}, entry_fn::String), returntype, Tuple{argtype1, ...}, argvalue1, ...)

Call the LLVM code provided in the first argument. There are several ways to specify this
first argument:

- as a literal string, representing function-level IR (similar to an LLVM `define` block),
  with arguments are available as consecutive unnamed SSA variables (%0, %1, etc.);
- as a 2-element tuple, containing a string of module IR and a string representing the name
  of the entry-point function to call;
- as a 2-element tuple, but with the module provided as an `Vector{UInt8}` with bitcode.

Note that contrary to `ccall`, the argument types must be specified as a tuple type, and not
a tuple of types. All types, as well as the LLVM code, should be specified as literals, and
not as variables or expressions (it may be necessary to use `@eval` to generate these
literals).

[Opaque pointers](https://llvm.org/docs/OpaquePointers.html) (written as `ptr`) are not allowed in the LLVM code.

See
[`test/llvmcall.jl`](https://github.com/JuliaLang/julia/blob/v$VERSION/test/llvmcall.jl)
for usage examples.
"""
Core.Intrinsics.llvmcall

"""
    begin

`begin...end` denotes a block of code.

```julia
begin
    println("Hello, ")
    println("World!")
end
```

Usually `begin` will not be necessary, since keywords such as [`function`](@ref) and [`let`](@ref)
implicitly begin blocks of code. See also [`;`](@ref).

`begin` may also be used when indexing to represent the first index of a
collection or the first index of a dimension of an array. For example,
`a[begin]` is the first element of an array `a`.

!!! compat "Julia 1.4"
    Use of `begin` as an index requires Julia 1.4 or later.

# Examples
```jldoctest
julia> A = [1 2; 3 4]
2×2 Matrix{Int64}:
 1  2
 3  4

julia> A[begin, :]
2-element Matrix{Int64}:
 1
 2
```
"""
kw"begin"

"""
    struct

The most commonly used kind of type in Julia is a struct, specified as a name and a
set of fields.

```julia
struct Point
    x
    y
end
```

Fields can have type restrictions, which may be parameterized:

```julia
struct Point{X}
    x::X
    y::Float64
end
```

A struct can also declare an abstract super type via `<:` syntax:

```julia
struct Point <: AbstractPoint
    x
    y
end
```

`struct`s are immutable by default; an instance of one of these types cannot
be modified after construction. Use [`mutable struct`](@ref) instead to declare a
type whose instances can be modified.

See the manual section on [Composite Types](@ref) for more details,
such as how to define constructors.
"""
kw"struct"

"""
    mutable struct

`mutable struct` is similar to [`struct`](@ref), but additionally allows the
fields of the type to be set after construction.

Individual fields of a mutable struct can be marked as `const` to make them immutable:

```julia
mutable struct Baz
    a::Int
    const b::Float64
end
```
!!! compat "Julia 1.8"
    The `const` keyword for fields of mutable structs requires at least Julia 1.8.

See the manual section on [Composite Types](@ref) for more information.
"""
kw"mutable struct"

"""
    new, or new{A,B,...}

Special function available to inner constructors which creates a new object
of the type. The form new{A,B,...} explicitly specifies values of parameters for parametric types.
See the manual section on [Inner Constructor Methods](@ref man-inner-constructor-methods)
for more information.
"""
kw"new"

"""
    where

The `where` keyword creates a [`UnionAll`](@ref) type, which may be thought of as an iterated union of other types, over all
values of some variable. For example `Vector{T} where T<:Real` includes all [`Vector`](@ref)s
where the element type is some kind of `Real` number.

The variable bound defaults to [`Any`](@ref) if it is omitted:

```julia
Vector{T} where T    # short for `where T<:Any`
```
Variables can also have lower bounds:

```julia
Vector{T} where T>:Int
Vector{T} where Int<:T<:Real
```
There is also a concise syntax for nested `where` expressions. For example, this:

```julia
Pair{T, S} where S<:Array{T} where T<:Number
```
can be shortened to:

```julia
Pair{T, S} where {T<:Number, S<:Array{T}}
```
This form is often found on method signatures.

Note that in this form, the variables are listed outermost-first. This matches the
order in which variables are substituted when a type is "applied" to parameter values
using the syntax `T{p1, p2, ...}`.
"""
kw"where"

"""
    var

The syntax `var"#example#"` refers to a variable named `Symbol("#example#")`,
even though `#example#` is not a valid Julia identifier name.

This can be useful for interoperability with programming languages which have
different rules for the construction of valid identifiers. For example, to
refer to the `R` variable `draw.segments`, you can use `var"draw.segments"` in
your Julia code.

It is also used to `show` julia source code which has gone through macro
hygiene or otherwise contains variable names which can't be parsed normally.

Note that this syntax requires parser support so it is expanded directly by the
parser rather than being implemented as a normal string macro `@var_str`.

!!! compat "Julia 1.3"
    This syntax requires at least Julia 1.3.

"""
kw"var\"name\"", kw"@var_str"

"""
    devnull

Used in a stream redirect to discard all data written to it. Essentially equivalent to
`/dev/null` on Unix or `NUL` on Windows. Usage:

```julia
run(pipeline(`cat test.txt`, devnull))
```
"""
devnull

# doc strings for code in boot.jl and built-ins

"""
    Nothing

A type with no fields that is the type of [`nothing`](@ref).

See also: [`isnothing`](@ref), [`Some`](@ref), [`Missing`](@ref).
"""
Nothing

"""
    nothing

The singleton instance of type [`Nothing`](@ref), used by convention when there is no value to return
(as in a C `void` function) or when a variable or field holds no value.

A return value of `nothing` is not displayed by the REPL and similar interactive environments.

See also: [`isnothing`](@ref), [`something`](@ref), [`missing`](@ref).
"""
nothing

"""
    Core.TypeofBottom

The singleton type containing only the value `Union{}` (which represents the empty type).
"""
Core.TypeofBottom

"""
    Core.Type{T}

`Core.Type` is an abstract type which has all type objects as its instances.
The only instance of the singleton type `Core.Type{T}` is the object
`T`.

# Examples
```jldoctest
julia> isa(Type{Float64}, Type)
true

julia> isa(Float64, Type)
true

julia> isa(Real, Type{Float64})
false

julia> isa(Real, Type{Real})
true
```
"""
Core.Type

"""
    DataType <: Type{T}

`DataType` represents explicitly declared types that have names, explicitly
declared supertypes, and, optionally, parameters.  Every concrete value in the
system is an instance of some `DataType`.

# Examples
```jldoctest
julia> typeof(Real)
DataType

julia> typeof(Int)
DataType

julia> struct Point
           x::Int
           y
       end

julia> typeof(Point)
DataType
```
"""
Core.DataType

"""
    Function

Abstract type of all functions.

# Examples
```jldoctest
julia> isa(+, Function)
true

julia> typeof(sin)
typeof(sin) (singleton type of function sin, subtype of Function)

julia> ans <: Function
true
```
"""
Function

"""
    ReadOnlyMemoryError()

An operation tried to write to memory that is read-only.
"""
ReadOnlyMemoryError

"""
    ErrorException(msg)

Generic error type. The error message, in the `.msg` field, may provide more specific details.

# Examples
```jldoctest
julia> ex = ErrorException("I've done a bad thing");

julia> ex.msg
"I've done a bad thing"
```
"""
ErrorException

"""
    FieldError(type::DataType, field::Symbol)

An operation tried to access invalid `field` on an object of `type`.

!!! compat "Julia 1.12"
    Prior to Julia 1.12, invalid field access threw an [`ErrorException`](@ref)

See [`getfield`](@ref)

# Examples
```jldoctest
julia> struct AB
          a::Float32
          b::Float64
       end

julia> ab = AB(1, 3)
AB(1.0f0, 3.0)

julia> ab.c # field `c` doesn't exist
ERROR: FieldError: type AB has no field `c`, available fields: `a`, `b`
Stacktrace:
[...]
```
"""
FieldError

"""
    WrappedException(msg)

Generic type for `Exception`s wrapping another `Exception`, such as `LoadError` and
`InitError`. Those exceptions contain information about the root cause of an
exception. Subtypes define a field `error` containing the causing `Exception`.
"""
Core.WrappedException

"""
    UndefRefError()

The item or field is not defined for the given object.

# Examples
```jldoctest
julia> struct MyType
           a::Vector{Int}
           MyType() = new()
       end

julia> A = MyType()
MyType(#undef)

julia> A.a
ERROR: UndefRefError: access to undefined reference
Stacktrace:
[...]
```
"""
UndefRefError

"""
    Float32(x [, mode::RoundingMode])

Create a `Float32` from `x`. If `x` is not exactly representable then `mode` determines how
`x` is rounded.

# Examples
```jldoctest
julia> Float32(1/3, RoundDown)
0.3333333f0

julia> Float32(1/3, RoundUp)
0.33333334f0
```

See [`RoundingMode`](@ref) for available rounding modes.
"""
Float32(x)

"""
    Float64(x [, mode::RoundingMode])

Create a `Float64` from `x`. If `x` is not exactly representable then `mode` determines how
`x` is rounded.

# Examples
```jldoctest
julia> Float64(pi, RoundDown)
3.141592653589793

julia> Float64(pi, RoundUp)
3.1415926535897936
```

See [`RoundingMode`](@ref) for available rounding modes.
"""
Float64(x)

"""
    OutOfMemoryError()

An operation allocated too much memory for either the system or the garbage collector to
handle properly.
"""
OutOfMemoryError

"""
    BoundsError([a],[i])

An indexing operation into an array, `a`, tried to access an out-of-bounds element at index `i`.

# Examples
```jldoctest; filter = r"Stacktrace:(\\n \\[[0-9]+\\].*)*"
julia> A = fill(1.0, 7);

julia> A[8]
ERROR: BoundsError: attempt to access 7-element Vector{Float64} at index [8]


julia> B = fill(1.0, (2,3));

julia> B[2, 4]
ERROR: BoundsError: attempt to access 2×3 Matrix{Float64} at index [2, 4]


julia> B[9]
ERROR: BoundsError: attempt to access 2×3 Matrix{Float64} at index [9]

```
"""
BoundsError

"""
    InexactError(name::Symbol, T, val)

Cannot exactly convert `val` to type `T` in a method of function `name`.

# Examples
```jldoctest
julia> convert(Float64, 1+2im)
ERROR: InexactError: Float64(1 + 2im)
Stacktrace:
[...]
```
"""
InexactError

"""
    DomainError(val)
    DomainError(val, msg)

The argument `val` to a function or constructor is outside the valid domain.

# Examples
```jldoctest
julia> sqrt(-1)
ERROR: DomainError with -1.0:
sqrt was called with a negative real argument but will only return a complex result if called with a complex argument. Try sqrt(Complex(x)).
Stacktrace:
[...]
```
"""
DomainError

"""
    Task(func[, reserved_stack::Int])

Create a `Task` (i.e. coroutine) to execute the given function `func` (which
must be callable with no arguments). The task exits when this function returns.
The task will run in the "world age" from the parent at construction when [`schedule`](@ref)d.

The optional `reserved_stack` argument specifies the size of the stack available
for this task, in bytes. The default, `0`, uses the system-dependent stack size default.

!!! warning
    By default tasks will have the sticky bit set to true `t.sticky`. This models the
    historic default for [`@async`](@ref). Sticky tasks can only be run on the worker thread
    they are first scheduled on, and when scheduled will make the task that they were scheduled
    from sticky. To obtain the behavior of [`Threads.@spawn`](@ref) set the sticky
    bit manually to `false`.

# Examples
```jldoctest
julia> a() = sum(i for i in 1:1000);

julia> b = Task(a);
```

In this example, `b` is a runnable `Task` that hasn't started yet.
"""
Task

"""
    StackOverflowError()

The function call grew beyond the size of the call stack. This usually happens when a call
recurses infinitely.
"""
StackOverflowError

"""
    nfields(x)::Int

Get the number of fields in the given object.

# Examples
```jldoctest
julia> a = 1//2;

julia> nfields(a)
2

julia> b = 1
1

julia> nfields(b)
0

julia> ex = ErrorException("I've done a bad thing");

julia> nfields(ex)
1
```

In these examples, `a` is a [`Rational`](@ref), which has two fields.
`b` is an `Int`, which is a primitive bitstype with no fields at all.
`ex` is an [`ErrorException`](@ref), which has one field.
"""
nfields

"""
    UndefVarError(var::Symbol, [scope])

A symbol in the current scope is not defined.

# Examples
```jldoctest
julia> a
ERROR: UndefVarError: `a` not defined in `Main`

julia> a = 1;

julia> a
1
```
"""
UndefVarError

"""
    UndefKeywordError(var::Symbol)

The required keyword argument `var` was not assigned in a function call.

# Examples
```jldoctest; filter = r"Stacktrace:(\\n \\[[0-9]+\\].*)*"
julia> function my_func(;my_arg)
           return my_arg + 1
       end
my_func (generic function with 1 method)

julia> my_func()
ERROR: UndefKeywordError: keyword argument `my_arg` not assigned
Stacktrace:
 [1] my_func() at ./REPL[1]:2
 [2] top-level scope at REPL[2]:1
```
"""
UndefKeywordError

"""
    OverflowError(msg)

The result of an expression is too large for the specified type and will cause a wraparound.
"""
OverflowError

"""
    TypeError(func::Symbol, context::AbstractString, expected::Type, got)

A type assertion failure, or calling an intrinsic function with an incorrect argument type.
"""
TypeError

"""
    InterruptException()

The process was stopped by a terminal interrupt (CTRL+C).

Note that, in Julia script started without `-i` (interactive) option,
`InterruptException` is not thrown by default.  Calling
[`Base.exit_on_sigint(false)`](@ref Base.exit_on_sigint) in the script
can recover the behavior of the REPL.  Alternatively, a Julia script
can be started with

```sh
julia -e "include(popfirst!(ARGS))" script.jl
```

to let `InterruptException` be thrown by CTRL+C during the execution.
"""
InterruptException

"""
    applicable(f, args...)::Bool

Determine whether the given generic function has a method applicable to the given arguments.

See also [`hasmethod`](@ref).

# Examples
```jldoctest
julia> function f(x, y)
           x + y
       end;

julia> applicable(f, 1)
false

julia> applicable(f, 1, 2)
true
```
"""
applicable

"""
    invoke(f, argtypes::Type, args...; kwargs...)
    invoke(f, argtypes::Method, args...; kwargs...)
    invoke(f, argtypes::CodeInstance, args...; kwargs...)

Invoke a method for the given generic function `f` matching the specified types `argtypes` on the
specified arguments `args` and passing the keyword arguments `kwargs`. The arguments `args` must
conform with the specified types in `argtypes`, i.e. conversion is not automatically performed.
This method allows invoking a method other than the most specific matching method, which is useful
when the behavior of a more general definition is explicitly needed (often as part of the
implementation of a more specific method of the same function). However, because this means
the runtime must do more work, `invoke` is generally also slower--sometimes significantly
so--than doing normal dispatch with a regular call.

Be careful when using `invoke` for functions that you don't write. What definition is used
for given `argtypes` is an implementation detail unless the function is explicitly states
that calling with certain `argtypes` is a part of public API.  For example, the change
between `f1` and `f2` in the example below is usually considered compatible because the
change is invisible by the caller with a normal (non-`invoke`) call.  However, the change is
visible if you use `invoke`.

# Passing a `Method` instead of a signature
The `argtypes` argument may be a `Method`, in which case the ordinary method table lookup is
bypassed entirely and the given method is invoked directly. Needing this feature is uncommon.
Note in particular that the specified `Method` may be entirely unreachable from ordinary dispatch
(or ordinary invoke), e.g. because it was replaced or fully covered by more specific methods.
If the method is part of the ordinary method table, this call behaves similar
to `invoke(f, method.sig, args...)`.

!!! compat "Julia 1.12"
    Passing a `Method` requires Julia 1.12.

# Passing a `CodeInstance` instead of a signature
The `argtypes` argument may be a `CodeInstance`, bypassing both method lookup and specialization.
The semantics of this invocation are similar to a function pointer call of the `CodeInstance`'s
`invoke` pointer. It is an error to invoke a `CodeInstance` with arguments that do not match its
parent `MethodInstance` or from a world age not included in the `min_world`/`max_world` range.
It is undefined behavior to invoke a `CodeInstance` whose behavior does not match the constraints
specified in its fields. For some code instances with `owner !== nothing` (i.e. those generated
by external compilers), it may be an error to invoke them after passing through precompilation.
This is an advanced interface intended for use with external compiler plugins.

!!! compat "Julia 1.12"
    Passing a `CodeInstance` requires Julia 1.12.

# Examples
```jldoctest
julia> f(x::Real) = x^2;

julia> f(x::Integer) = 1 + invoke(f, Tuple{Real}, x);

julia> f(2)
5

julia> f1(::Integer) = Integer
       f1(::Real) = Real;

julia> f2(x::Real) = _f2(x)
       _f2(::Integer) = Integer
       _f2(_) = Real;

julia> f1(1)
Integer

julia> f2(1)
Integer

julia> invoke(f1, Tuple{Real}, 1)
Real

julia> invoke(f2, Tuple{Real}, 1)
Integer
```
"""
invoke

"""
    isa(x, type)::Bool

Determine whether `x` is of the given `type`. Can also be used as an infix operator, e.g.
`x isa type`.

# Examples
```jldoctest
julia> isa(1, Int)
true

julia> isa(1, Matrix)
false

julia> isa(1, Char)
false

julia> isa(1, Number)
true

julia> 1 isa Number
true
```
"""
isa

"""
    DivideError()

Integer division was attempted with a denominator value of 0.

# Examples
```jldoctest
julia> 2/0
Inf

julia> div(2, 0)
ERROR: DivideError: integer division error
Stacktrace:
[...]
```
"""
DivideError

"""
    Number

Abstract supertype for all number types.
"""
Number

"""
    Real <: Number

Abstract supertype for all real numbers.
"""
Real

"""
    AbstractFloat <: Real

Abstract supertype for all floating point numbers.
"""
AbstractFloat

"""
    Integer <: Real

Abstract supertype for all integers (e.g. [`Signed`](@ref), [`Unsigned`](@ref), and [`Bool`](@ref)).

See also [`isinteger`](@ref), [`trunc`](@ref), [`div`](@ref).

# Examples
```
julia> 42 isa Integer
true

julia> 1.0 isa Integer
false

julia> isinteger(1.0)
true
```
"""
Integer

"""
    Signed <: Integer

Abstract supertype for all signed integers.
"""
Signed

"""
    Unsigned <: Integer

Abstract supertype for all unsigned integers.

Built-in unsigned integers are printed in hexadecimal, with prefix `0x`,
and can be entered in the same way.

# Examples
```
julia> typemax(UInt8)
0xff

julia> Int(0x00d)
13

julia> unsigned(true)
0x0000000000000001
```
"""
Unsigned

"""
    Bool <: Integer

Boolean type, containing the values `true` and `false`.

`Bool` is a kind of number: `false` is numerically
equal to `0` and `true` is numerically equal to `1`.
Moreover, `false` acts as a multiplicative "strong zero"
against [`NaN`](@ref) and [`Inf`](@ref):

```jldoctest
julia> [true, false] == [1, 0]
true

julia> 42.0 + true
43.0

julia> 0 .* (NaN, Inf, -Inf)
(NaN, NaN, NaN)

julia> false .* (NaN, Inf, -Inf)
(0.0, 0.0, -0.0)
```

Branches via [`if`](@ref) and other conditionals only accept `Bool`.
There are no "truthy" values in Julia.

Comparisons typically return `Bool`, and broadcasted comparisons may
return [`BitArray`](@ref) instead of an `Array{Bool}`.

```jldoctest
julia> [1 2 3 4 5] .< pi
1×5 BitMatrix:
 1  1  1  0  0

julia> map(>(pi), [1 2 3 4 5])
1×5 Matrix{Bool}:
 0  0  0  1  1
```

See also [`trues`](@ref), [`falses`](@ref), [`ifelse`](@ref).
"""
Bool

"""
    Float64 <: AbstractFloat <: Real

64-bit floating point number type (IEEE 754 standard).
Binary format is 1 sign, 11 exponent, 52 fraction bits.
See [`bitstring`](@ref), [`signbit`](@ref), [`exponent`](@ref), [`frexp`](@ref),
and [`significand`](@ref) to access various bits.

This is the default for floating point literals, `1.0 isa Float64`,
and for many operations such as `1/2, 2pi, log(2), range(0,90,length=4)`.
Unlike integers, this default does not change with `Sys.WORD_SIZE`.

The exponent for scientific notation can be entered as `e` or `E`,
thus `2e3 === 2.0E3 === 2.0 * 10^3`. Doing so is strongly preferred over
`10^n` because integers overflow, thus `2.0 * 10^19 < 0` but `2e19 > 0`.

See also [`Inf`](@ref), [`NaN`](@ref), [`floatmax`](@ref), [`Float32`](@ref), [`Complex`](@ref).
"""
Float64

"""
    Float32 <: AbstractFloat <: Real

32-bit floating point number type (IEEE 754 standard).
Binary format is 1 sign, 8 exponent, 23 fraction bits.

The exponent for scientific notation should be entered as lower-case `f`,
thus `2f3 === 2.0f0 * 10^3 === Float32(2_000)`.
For array literals and comprehensions, the element type can be specified before
the square brackets: `Float32[1,4,9] == Float32[i^2 for i in 1:3]`.

See also [`Inf32`](@ref), [`NaN32`](@ref), [`Float16`](@ref), [`exponent`](@ref), [`frexp`](@ref).
"""
Float32

"""
    Float16 <: AbstractFloat <: Real

16-bit floating point number type (IEEE 754 standard).
Binary format is 1 sign, 5 exponent, 10 fraction bits.
"""
Float16

for bit in (8, 16, 32, 64, 128)
    type = Symbol(:Int, bit)
    srange = bit > 31 ? "" : "Represents numbers `n ∈ " * repr(eval(:(typemin($type):typemax($type)))) * "`.\n"
    unshow = repr(eval(Symbol(:UInt, bit))(bit-1))

    @eval begin
        """
            Int$($bit) <: Signed <: Integer

        $($bit)-bit signed integer type.

        $($(srange))Note that such integers overflow without warning,
        thus `typemax($($type)) + $($type)(1) < 0`.

        See also [`Int`](@ref $Int), [`widen`](@ref), [`BigInt`](@ref).
        """
        $(Symbol("Int", bit))

        """
            UInt$($bit) <: Unsigned <: Integer

        $($bit)-bit unsigned integer type.

        Printed in hexadecimal, thus $($(unshow)) == $($(bit-1)).
        """
        $(Symbol("UInt", bit))
    end
end

"""
    Int

Sys.WORD_SIZE-bit signed integer type, `Int <: Signed <: Integer <: Real`.

This is the default type of most integer literals and is an alias for either `Int32`
or `Int64`, depending on `Sys.WORD_SIZE`. It is the type returned by functions such as
[`length`](@ref), and the standard type for indexing arrays.

Note that integers overflow without warning, thus `typemax(Int) + 1 < 0` and `10^19 < 0`.
Overflow can be avoided by using [`BigInt`](@ref).
Very large integer literals will use a wider type, for instance `10_000_000_000_000_000_000 isa Int128`.

Integer division is [`div`](@ref) alias `÷`,
whereas [`/`](@ref) acting on integers returns [`Float64`](@ref).

See also [`$(Symbol("Int", Sys.WORD_SIZE))`](@ref), [`widen`](@ref), [`typemax`](@ref), [`bitstring`](@ref).
"""
Int

"""
    UInt

Sys.WORD_SIZE-bit unsigned integer type, `UInt <: Unsigned <: Integer`.

Like [`Int`](@ref Int), the alias `UInt` may point to either `UInt32` or `UInt64`,
according to the value of `Sys.WORD_SIZE` on a given computer.

Printed and parsed in hexadecimal: `UInt(15) === $(repr(UInt(15)))`.
"""
UInt

"""
    Symbol

The type of object used to represent identifiers in parsed julia code (ASTs).
Also often used as a name or label to identify an entity (e.g. as a dictionary key).
`Symbol`s can be entered using the `:` quote operator:
```jldoctest
julia> :name
:name

julia> typeof(:name)
Symbol

julia> x = 42
42

julia> eval(:x)
42
```
`Symbol`s can also be constructed from strings or other values by calling the
constructor `Symbol(x...)`.

`Symbol`s are immutable and their implementation re-uses the same object for all `Symbol`s
with the same name.

Unlike strings, `Symbol`s are "atomic" or "scalar" entities that do not support
iteration over characters.
"""
Symbol

"""
    Symbol(x...)::Symbol

Create a [`Symbol`](@ref) by concatenating the string representations of the arguments together.

# Examples
```jldoctest
julia> Symbol("my", "name")
:myname

julia> Symbol("day", 4)
:day4
```
"""
Symbol(x...)

"""
    tuple(xs...)

Construct a tuple of the given objects.

See also [`Tuple`](@ref), [`ntuple`](@ref), [`NamedTuple`](@ref).

# Examples
```jldoctest
julia> tuple(1, 'b', pi)
(1, 'b', π)

julia> ans === (1, 'b', π)
true

julia> Tuple(Real[1, 2, pi])  # takes a collection
(1, 2, π)
```
"""
tuple

"""
    getfield(value, name::Symbol, [boundscheck::Bool=true], [order::Symbol])
    getfield(value, i::Int, [boundscheck::Bool=true], [order::Symbol])

Extract a field from a composite `value` by name or position.

Optionally, an ordering can be defined for the operation.  If the field was
declared `@atomic`, the specification is strongly recommended to be compatible
with the stores to that location. Otherwise, if not declared as `@atomic`, this
parameter must be `:not_atomic` if specified.

The bounds check may be disabled, in which case the behavior of this function is
undefined if `i` is out of bounds.

See also [`getproperty`](@ref Base.getproperty) and [`fieldnames`](@ref).

# Examples
```jldoctest
julia> a = 1//2
1//2

julia> getfield(a, :num)
1

julia> a.num
1

julia> getfield(a, 1)
1
```
"""
getfield

"""
    setfield!(value, name::Symbol, x, [order::Symbol])
    setfield!(value, i::Int, x, [order::Symbol])

Assign `x` to a named field in `value` of composite type. The `value` must be
mutable and `x` must be a subtype of `fieldtype(typeof(value), name)`.
Additionally, an ordering can be specified for this operation. If the field was
declared `@atomic`, this specification is mandatory. Otherwise, if not declared
as `@atomic`, it must be `:not_atomic` if specified.
See also [`setproperty!`](@ref Base.setproperty!).

# Examples
```jldoctest
julia> mutable struct MyMutableStruct
           field::Int
       end

julia> a = MyMutableStruct(1);

julia> setfield!(a, :field, 2);

julia> getfield(a, :field)
2

julia> a = 1//2
1//2

julia> setfield!(a, :num, 3);
ERROR: setfield!: immutable struct of type Rational cannot be changed
```
"""
setfield!

"""
    swapfield!(value, name::Symbol, x, [order::Symbol])
    swapfield!(value, i::Int, x, [order::Symbol])

Atomically perform the operations to simultaneously get and set a field:

    y = getfield(value, name)
    setfield!(value, name, x)
    return y

!!! compat "Julia 1.7"
    This function requires Julia 1.7 or later.
"""
swapfield!

"""
    modifyfield!(value, name::Symbol, op, x, [order::Symbol])::Pair
    modifyfield!(value, i::Int, op, x, [order::Symbol])::Pair

Atomically perform the operations to get and set a field after applying
the function `op`.

    y = getfield(value, name)
    z = op(y, x)
    setfield!(value, name, z)
    return y => z

If supported by the hardware (for example, atomic increment), this may be
optimized to the appropriate hardware instruction, otherwise it'll use a loop.

!!! compat "Julia 1.7"
    This function requires Julia 1.7 or later.
"""
modifyfield!

"""
    replacefield!(value, name::Symbol, expected, desired,
                  [success_order::Symbol, [fail_order::Symbol=success_order]) -> (; old, success::Bool)
    replacefield!(value, i::Int, expected, desired,
                  [success_order::Symbol, [fail_order::Symbol=success_order]) -> (; old, success::Bool)

Atomically perform the operations to get and conditionally set a field to
a given value.

    y = getfield(value, name, fail_order)
    ok = y === expected
    if ok
        setfield!(value, name, desired, success_order)
    end
    return (; old = y, success = ok)

If supported by the hardware, this may be optimized to the appropriate hardware
instruction, otherwise it'll use a loop.

!!! compat "Julia 1.7"
    This function requires Julia 1.7 or later.
"""
replacefield!

"""
    setfieldonce!(value, name::Union{Int,Symbol}, desired,
                  [success_order::Symbol, [fail_order::Symbol=success_order]) -> success::Bool

Atomically perform the operations to set a field to
a given value, only if it was previously not set.

    ok = !isdefined(value, name, fail_order)
    if ok
        setfield!(value, name, desired, success_order)
    end
    return ok

!!! compat "Julia 1.11"
    This function requires Julia 1.11 or later.
"""
setfieldonce!

"""
    getglobal(module::Module, name::Symbol, [order::Symbol=:monotonic])

Retrieve the value of the binding `name` from the module `module`. Optionally, an
atomic ordering can be defined for the operation, otherwise it defaults to
monotonic.

While accessing module bindings using [`getfield`](@ref) is still supported to
maintain compatibility, using `getglobal` should always be preferred since
`getglobal` allows for control over atomic ordering (`getfield` is always
monotonic) and better signifies the code's intent both to the user as well as the
compiler.

Most users should not have to call this function directly -- The
[`getproperty`](@ref Base.getproperty) function or corresponding syntax (i.e.
`module.name`) should be preferred in all but few very specific use cases.

!!! compat "Julia 1.9"
    This function requires Julia 1.9 or later.

See also [`getproperty`](@ref Base.getproperty) and [`setglobal!`](@ref).

# Examples
```jldoctest
julia> a = 1
1

julia> module M
       a = 2
       end;

julia> getglobal(@__MODULE__, :a)
1

julia> getglobal(M, :a)
2
```
"""
getglobal


"""
    setglobal!(module::Module, name::Symbol, x, [order::Symbol=:monotonic])

Set or change the value of the binding `name` in the module `module` to `x`. No
type conversion is performed, so if a type has already been declared for the
binding, `x` must be of appropriate type or an error is thrown.

Additionally, an atomic ordering can be specified for this operation, otherwise it
defaults to monotonic.

Users will typically access this functionality through the
[`setproperty!`](@ref Base.setproperty!) function or corresponding syntax
(i.e. `module.name = x`) instead, so this is intended only for very specific use
cases.

!!! compat "Julia 1.9"
    This function requires Julia 1.9 or later.

See also [`setproperty!`](@ref Base.setproperty!) and [`getglobal`](@ref)

# Examples
```jldoctest; filter = r"Stacktrace:(\\n \\[[0-9]+\\].*\\n.*)*"
julia> module M; global a; end;

julia> M.a  # same as `getglobal(M, :a)`
ERROR: UndefVarError: `a` not defined in `M`
Suggestion: add an appropriate import or assignment. This global was declared but not assigned.
Stacktrace:
 [1] getproperty(x::Module, f::Symbol)
   @ Base ./Base_compiler.jl:40
 [2] top-level scope
   @ none:1

julia> setglobal!(M, :a, 1)
1

julia> M.a
1
```
"""
setglobal!

"""
    Core.get_binding_type(module::Module, name::Symbol)

Retrieve the declared type of the binding `name` from the module `module`.

!!! compat "Julia 1.9"
    This function requires Julia 1.9 or later.
"""
Core.get_binding_type

"""
    swapglobal!(module::Module, name::Symbol, x, [order::Symbol=:monotonic])

Atomically perform the operations to simultaneously get and set a global.

!!! compat "Julia 1.11"
    This function requires Julia 1.11 or later.

See also [`swapproperty!`](@ref Base.swapproperty!) and [`setglobal!`](@ref).
"""
swapglobal!

"""
    modifyglobal!(module::Module, name::Symbol, op, x, [order::Symbol=:monotonic])::Pair

Atomically perform the operations to get and set a global after applying
the function `op`.

!!! compat "Julia 1.11"
    This function requires Julia 1.11 or later.

See also [`modifyproperty!`](@ref Base.modifyproperty!) and [`setglobal!`](@ref).
"""
modifyglobal!

"""
    replaceglobal!(module::Module, name::Symbol, expected, desired,
                  [success_order::Symbol, [fail_order::Symbol=success_order]) -> (; old, success::Bool)

Atomically perform the operations to get and conditionally set a global to
a given value.

!!! compat "Julia 1.11"
    This function requires Julia 1.11 or later.

See also [`replaceproperty!`](@ref Base.replaceproperty!) and [`setglobal!`](@ref).
"""
replaceglobal!

"""
    setglobalonce!(module::Module, name::Symbol, value,
                  [success_order::Symbol, [fail_order::Symbol=success_order]) -> success::Bool

Atomically perform the operations to set a global to
a given value, only if it was previously not set.

!!! compat "Julia 1.11"
    This function requires Julia 1.11 or later.

See also [`setpropertyonce!`](@ref Base.setpropertyonce!) and [`setglobal!`](@ref).
"""
setglobalonce!

"""
   _import(to::Module, from::Module, asname::Symbol, [sym::Symbol, imported::Bool])

With all five arguments, imports `sym` from module `from` into `to` with name
`asname`.  `imported` is true for bindings created with `import` (set it to
false for `using A: ...`).

With only the first three arguments, creates a binding for the module `from`
with name `asname` in `to`.
"""
Core._import

"""
   _using(to::Module, from::Module)

Add `from` to the usings list of `to`.
"""
Core._using

"""
    typeof(x)

Get the concrete type of `x`.

See also [`eltype`](@ref).

# Examples
```jldoctest
julia> a = 1//2;

julia> typeof(a)
Rational{Int64}

julia> M = [1 2; 3.5 4];

julia> typeof(M)
Matrix{Float64} (alias for Array{Float64, 2})
```
"""
typeof

"""
    isdefined(m::Module, s::Symbol, [order::Symbol])
    isdefined(object, s::Symbol, [order::Symbol])
    isdefined(object, index::Int, [order::Symbol])

Tests whether a global variable or object field is defined. The arguments can
be a module and a symbol or a composite object and field name (as a symbol) or
index. Optionally, an ordering can be defined for the operation. If the field
was declared `@atomic`, the specification is strongly recommended to be
compatible with the stores to that location. Otherwise, if not declared as
`@atomic`, this parameter must be `:not_atomic` if specified.

To test whether an array element is defined, use [`isassigned`](@ref) instead.

The global variable variant is supported for compatibility with older julia
releases. For new code, prefer [`isdefinedglobal`](@ref).

See also [`@isdefined`](@ref).

# Examples
```jldoctest
julia> isdefined(Base, :sum)
true

julia> isdefined(Base, :NonExistentMethod)
false

julia> a = 1//2;

julia> isdefined(a, 2)
true

julia> isdefined(a, 3)
false

julia> isdefined(a, :num)
true

julia> isdefined(a, :numerator)
false
```
"""
isdefined


"""
    isdefinedglobal(m::Module, s::Symbol, [allow_import::Bool=true, [order::Symbol=:unordered]])

Tests whether a global variable `s` is defined in module `m` (in the current world age).
A variable is considered defined if and only if a value may be read from this global variable
and an access will not throw. This includes both constants and global variables that have
a value set.

If `allow_import` is `false`, the global variable must be defined inside `m`
and may not be imported from another module.

See also [`@isdefined`](@ref).

# Examples
```jldoctest
julia> isdefinedglobal(Base, :sum)
true

julia> isdefinedglobal(Base, :NonExistentMethod)
false

julia> isdefinedglobal(Base, :sum, false)
true

julia> isdefinedglobal(Main, :sum, false)
false
```
"""
isdefinedglobal

"""
    Memory{T}(undef, n)

Construct an uninitialized [`Memory{T}`](@ref) of length `n`. All Memory
objects of length 0 might alias, since there is no reachable mutable content
from them.

# Examples
```julia-repl
julia> Memory{Float64}(undef, 3)
3-element Memory{Float64}:
 6.90966e-310
 6.90966e-310
 6.90966e-310
```
"""
Memory{T}(::UndefInitializer, n)

"""
    memoryref(::GenericMemory)

Construct a `GenericMemoryRef` from a memory object. This does not fail, but the
resulting memory will point out-of-bounds if and only if the memory is empty.
"""
memoryref(::GenericMemory)

"""
    memoryref(::GenericMemory, index::Integer)
    memoryref(::GenericMemoryRef, index::Integer)

Construct a `GenericMemoryRef` from a memory object and an offset index (1-based) which
can also be negative. This always returns an inbounds object, and will throw an
error if that is not possible (because the index would result in a shift
out-of-bounds of the underlying memory).
"""
memoryref(::Union{GenericMemory,GenericMemoryRef}, ::Integer)

"""
    Vector{T}(undef, n)

Construct an uninitialized [`Vector{T}`](@ref) of length `n`.

# Examples
```julia-repl
julia> Vector{Float64}(undef, 3)
3-element Vector{Float64}:
 6.90966e-310
 6.90966e-310
 6.90966e-310
```
"""
Vector{T}(::UndefInitializer, n)

"""
    Vector{T}(nothing, m)

Construct a [`Vector{T}`](@ref) of length `m`, initialized with
[`nothing`](@ref) entries. Element type `T` must be able to hold
these values, i.e. `Nothing <: T`.

# Examples
```jldoctest
julia> Vector{Union{Nothing, String}}(nothing, 2)
2-element Vector{Union{Nothing, String}}:
 nothing
 nothing
```
"""
Vector{T}(::Nothing, n)

"""
    Vector{T}(missing, m)

Construct a [`Vector{T}`](@ref) of length `m`, initialized with
[`missing`](@ref) entries. Element type `T` must be able to hold
these values, i.e. `Missing <: T`.

# Examples
```jldoctest
julia> Vector{Union{Missing, String}}(missing, 2)
2-element Vector{Union{Missing, String}}:
 missing
 missing
```
"""
Vector{T}(::Missing, n)

"""
    Matrix{T}(undef, m, n)

Construct an uninitialized [`Matrix{T}`](@ref) of size `m`×`n`.

# Examples
```julia-repl
julia> Matrix{Float64}(undef, 2, 3)
2×3 Matrix{Float64}:
 2.36365e-314  2.28473e-314    5.0e-324
 2.26704e-314  2.26711e-314  NaN

julia> similar(ans, Int32, 2, 2)
2×2 Matrix{Int32}:
 490537216  1277177453
         1  1936748399
```
"""
Matrix{T}(::UndefInitializer, m, n)

"""
    Matrix{T}(nothing, m, n)

Construct a [`Matrix{T}`](@ref) of size `m`×`n`, initialized with
[`nothing`](@ref) entries. Element type `T` must be able to hold
these values, i.e. `Nothing <: T`.

# Examples
```jldoctest
julia> Matrix{Union{Nothing, String}}(nothing, 2, 3)
2×3 Matrix{Union{Nothing, String}}:
 nothing  nothing  nothing
 nothing  nothing  nothing
```
"""
Matrix{T}(::Nothing, m, n)

"""
    Matrix{T}(missing, m, n)

Construct a [`Matrix{T}`](@ref) of size `m`×`n`, initialized with
[`missing`](@ref) entries. Element type `T` must be able to hold
these values, i.e. `Missing <: T`.

# Examples
```jldoctest
julia> Matrix{Union{Missing, String}}(missing, 2, 3)
2×3 Matrix{Union{Missing, String}}:
 missing  missing  missing
 missing  missing  missing
```
"""
Matrix{T}(::Missing, m, n)

"""
    Array{T}(undef, dims)
    Array{T,N}(undef, dims)

Construct an uninitialized `N`-dimensional [`Array`](@ref)
containing elements of type `T`. `N` can either be supplied explicitly,
as in `Array{T,N}(undef, dims)`, or be determined by the length or number of `dims`.
`dims` may be a tuple or a series of integer arguments corresponding to the lengths
in each dimension. If the rank `N` is supplied explicitly, then it must
match the length or number of `dims`. Here [`undef`](@ref) is
the [`UndefInitializer`](@ref).

# Examples
```julia-repl
julia> A = Array{Float64, 2}(undef, 2, 3) # N given explicitly
2×3 Matrix{Float64}:
 6.90198e-310  6.90198e-310  6.90198e-310
 6.90198e-310  6.90198e-310  0.0

julia> B = Array{Float64}(undef, 4) # N determined by the input
4-element Vector{Float64}:
   2.360075077e-314
 NaN
   2.2671131793e-314
   2.299821756e-314

julia> similar(B, 2, 4, 1) # use typeof(B), and the given size
2×4×1 Array{Float64, 3}:
[:, :, 1] =
 2.26703e-314  2.26708e-314  0.0           2.80997e-314
 0.0           2.26703e-314  2.26708e-314  0.0
```
"""
Array{T,N}(::UndefInitializer, dims)

"""
    Array{T}(nothing, dims)
    Array{T,N}(nothing, dims)

Construct an `N`-dimensional [`Array`](@ref) containing elements of type `T`,
initialized with [`nothing`](@ref) entries. Element type `T` must be able
to hold these values, i.e. `Nothing <: T`.

# Examples
```jldoctest
julia> Array{Union{Nothing, String}}(nothing, 2)
2-element Vector{Union{Nothing, String}}:
 nothing
 nothing

julia> Array{Union{Nothing, Int}}(nothing, 2, 3)
2×3 Matrix{Union{Nothing, Int64}}:
 nothing  nothing  nothing
 nothing  nothing  nothing
```
"""
Array{T,N}(::Nothing, dims)


"""
    Array{T}(missing, dims)
    Array{T,N}(missing, dims)

Construct an `N`-dimensional [`Array`](@ref) containing elements of type `T`,
initialized with [`missing`](@ref) entries. Element type `T` must be able
to hold these values, i.e. `Missing <: T`.

# Examples
```jldoctest
julia> Array{Union{Missing, String}}(missing, 2)
2-element Vector{Union{Missing, String}}:
 missing
 missing

julia> Array{Union{Missing, Int}}(missing, 2, 3)
2×3 Matrix{Union{Missing, Int64}}:
 missing  missing  missing
 missing  missing  missing
```
"""
Array{T,N}(::Missing, dims)

"""
    UndefInitializer

Singleton type used in array initialization, indicating the array-constructor-caller
would like an uninitialized array. See also [`undef`](@ref),
an alias for `UndefInitializer()`.

# Examples
```julia-repl
julia> Array{Float64, 1}(UndefInitializer(), 3)
3-element Vector{Float64}:
 2.2752528595e-314
 2.202942107e-314
 2.275252907e-314
```
"""
UndefInitializer

"""
    undef

Alias for `UndefInitializer()`, which constructs an instance of the singleton type
[`UndefInitializer`](@ref), used in array initialization to indicate the
array-constructor-caller would like an uninitialized array.

See also: [`missing`](@ref), [`similar`](@ref).

# Examples
```julia-repl
julia> Array{Float64, 1}(undef, 3)
3-element Vector{Float64}:
 2.2752528595e-314
 2.202942107e-314
 2.275252907e-314
```
"""
undef

"""
    Ptr{T}()

Creates a null pointer to type `T`.
"""
Ptr{T}()

"""
    +(x, y...)

Addition operator.

Infix `x+y+z+...` calls this function with all arguments, i.e. `+(x, y, z, ...)`,
which by default then calls `(x+y) + z + ...` starting from the left.

Note that overflow is possible for most integer types, including the
default `Int`, when adding large numbers.

# Examples
```jldoctest
julia> 1 + 20 + 4
25

julia> +(1, 20, 4)
25

julia> [1,2] + [3,4]
2-element Vector{Int64}:
 4
 6

julia> typemax(Int) + 1 < 0
true
```
"""
(+)(x, y...)

"""
    -(x)

Unary minus operator.

See also: [`abs`](@ref), [`flipsign`](@ref).

# Examples
```jldoctest
julia> -1
-1

julia> -(2)
-2

julia> -[1 2; 3 4]
2×2 Matrix{Int64}:
 -1  -2
 -3  -4

julia> -(true)  # promotes to Int
-1

julia> -(0x003)
0xfffd
```
"""
-(x)

"""
    -(x, y)

Subtraction operator.

# Examples
```jldoctest
julia> 2 - 3
-1

julia> -(2, 4.5)
-2.5
```
"""
-(x, y)

"""
    *(x, y...)

Multiplication operator.

Infix `x*y*z*...` calls this function with all arguments, i.e. `*(x, y, z, ...)`,
which by default then calls `(x*y) * z * ...` starting from the left.

Juxtaposition such as `2pi` also calls `*(2, pi)`. Note that this operation
has higher precedence than a literal `*`. Note also that juxtaposition "0x..."
(integer zero times a variable whose name starts with `x`) is forbidden as
it clashes with unsigned integer literals: `0x01 isa UInt8`.

Note that overflow is possible for most integer types, including the default `Int`,
when multiplying large numbers.

# Examples
```jldoctest
julia> 2 * 7 * 8
112

julia> *(2, 7, 8)
112

julia> [2 0; 0 3] * [1, 10]  # matrix * vector
2-element Vector{Int64}:
  2
 30

julia> 1/2pi, 1/2*pi  # juxtaposition has higher precedence
(0.15915494309189535, 1.5707963267948966)

julia> x = [1, 2]; x'x  # adjoint vector * vector
5
```
"""
(*)(x, y...)

"""
    /(x, y)

Right division operator: multiplication of `x` by the inverse of `y` on the right.

Gives floating-point results for integer arguments.
See [`÷`](@ref div) for integer division, or [`//`](@ref) for [`Rational`](@ref) results.

# Examples
```jldoctest
julia> 1/2
0.5

julia> 4/2
2.0

julia> 4.5/2
2.25
```
"""
/(x, y)

"""
    ArgumentError(msg)

The arguments passed to a function are invalid.
`msg` is a descriptive error message.
"""
ArgumentError

"""
    MethodError(f, args)

A method with the required type signature does not exist in the given generic function.
Alternatively, there is no unique most-specific method.
"""
MethodError

"""
    AssertionError([msg])

The asserted condition did not evaluate to `true`.
Optional argument `msg` is a descriptive error string.

# Examples
```jldoctest
julia> @assert false "this is not true"
ERROR: AssertionError: this is not true
```

`AssertionError` is usually thrown from [`@assert`](@ref).
"""
AssertionError

"""
    LoadError(file::AbstractString, line::Int, error)

An error occurred while [`include`](@ref Base.include)ing, [`require`](@ref Base.require)ing, or [`using`](@ref) a file. The error specifics
should be available in the `.error` field.

!!! compat "Julia 1.7"
    LoadErrors are no longer emitted by `@macroexpand`, `@macroexpand1`, and `macroexpand` as of Julia 1.7.
"""
LoadError

"""
    InitError(mod::Symbol, error)

An error occurred when running a module's `__init__` function. The actual error thrown is
available in the `.error` field.
"""
InitError

"""
    Any::DataType

`Any` is the union of all types. It has the defining property `isa(x, Any) == true` for any `x`. `Any` therefore
describes the entire universe of possible values. For example `Integer` is a subset of `Any` that includes `Int`,
`Int8`, and other integer types.
"""
Any

"""
    Union{}

`Union{}`, the empty [`Union`](@ref) of types, is the *bottom* type of the type system. That is, for each
`T::Type`, `Union{} <: T`. Also see the subtyping operator's documentation: [`<:`](@ref).

As such, `Union{}` is also an *empty*/*uninhabited* type, meaning that it has no values. That is, for each `x`,
`isa(x, Union{}) == false`.

`Base.Bottom` is defined as its alias and the type of `Union{}` is `Core.TypeofBottom`.

# Examples
```jldoctest
julia> isa(nothing, Union{})
false

julia> Union{} <: Int
true

julia> typeof(Union{}) === Core.TypeofBottom
true

julia> isa(Union{}, Union)
false
```
"""
kw"Union{}", Base.Bottom

"""
    Union{Types...}

A `Union` type is an abstract type which includes all instances of any of its argument types.
This means that `T <: Union{T,S}` and `S <: Union{T,S}`.

Like other abstract types, it cannot be instantiated, even if all of its arguments are non
abstract.

# Examples
```jldoctest
julia> IntOrString = Union{Int,AbstractString}
Union{Int64, AbstractString}

julia> 1 isa IntOrString # instance of Int is included in the union
true

julia> "Hello!" isa IntOrString # String is also included
true

julia> 1.0 isa IntOrString # Float64 is not included because it is neither Int nor AbstractString
false
```

# Extended Help

Unlike most other parametric types, unions are covariant in their parameters. For example,
`Union{Real, String}` is a subtype of `Union{Number, AbstractString}`.

The empty union [`Union{}`](@ref) is the bottom type of Julia.
"""
Union


"""
    UnionAll

A union of types over all values of a type parameter. `UnionAll` is used to describe parametric types
where the values of some parameters are not known. See the manual section on [UnionAll Types](@ref).

# Examples
```jldoctest
julia> typeof(Vector)
UnionAll

julia> typeof(Vector{Int})
DataType
```
"""
UnionAll

"""
    ::

The `::` operator either asserts that a value has the given type, or declares that
a local variable or function return always has the given type.

Given `expression::T`, `expression` is first evaluated. If the result is of type
`T`, the value is simply returned. Otherwise, a [`TypeError`](@ref) is thrown.

In local scope, the syntax `local x::T` or `x::T = expression` declares that local variable
`x` always has type `T`. When a value is assigned to the variable, it will be
converted to type `T` by calling [`convert`](@ref).

In a method declaration, the syntax `function f(x)::T` causes any value returned by
the method to be converted to type `T`.

See the manual section on [Type Declarations](@ref).

# Examples
```jldoctest
julia> (1+2)::AbstractFloat
ERROR: TypeError: typeassert: expected AbstractFloat, got a value of type Int64

julia> (1+2)::Int
3

julia> let
           local x::Int
           x = 2.0
           x
       end
2
```
"""
kw"::"

"""
    Vararg{T,N}

The last parameter of a tuple type [`Tuple`](@ref) can be the special value `Vararg`, which denotes any
number of trailing elements. `Vararg{T,N}` corresponds to exactly `N` elements of type `T`. Finally
`Vararg{T}` corresponds to zero or more elements of type `T`. `Vararg` tuple types are used to represent the
arguments accepted by varargs methods (see the section on [Varargs Functions](@ref) in the manual.)

See also [`NTuple`](@ref).

# Examples
```jldoctest
julia> mytupletype = Tuple{AbstractString, Vararg{Int}}
Tuple{AbstractString, Vararg{Int64}}

julia> isa(("1",), mytupletype)
true

julia> isa(("1",1), mytupletype)
true

julia> isa(("1",1,2), mytupletype)
true

julia> isa(("1",1,2,3.0), mytupletype)
false
```
"""
Vararg

"""
    Tuple{Types...}

A tuple is a fixed-length container that can hold any values of different
types, but cannot be modified (it is immutable). The values can be accessed via
indexing. Tuple literals are written with commas and parentheses:

```jldoctest
julia> (1, 1+1)
(1, 2)

julia> (1,)
(1,)

julia> x = (0.0, "hello", 6*7)
(0.0, "hello", 42)

julia> x[2]
"hello"

julia> typeof(x)
Tuple{Float64, String, Int64}
```

A length-1 tuple must be written with a comma, `(1,)`, since `(1)` would just
be a parenthesized value. `()` represents the empty (length-0) tuple.

A tuple can be constructed from an iterator by using a `Tuple` type as constructor:

```jldoctest
julia> Tuple(["a", 1])
("a", 1)

julia> Tuple{String, Float64}(["a", 1])
("a", 1.0)
```

Tuple types are covariant in their parameters: `Tuple{Int}` is a subtype of `Tuple{Any}`. Therefore `Tuple{Any}`
is considered an abstract type, and tuple types are only concrete if their parameters are. Tuples do not have
field names; fields are only accessed by index.
Tuple types may have any number of parameters.

See the manual section on [Tuple Types](@ref).

See also [`Vararg`](@ref), [`NTuple`](@ref), [`ntuple`](@ref), [`tuple`](@ref), [`NamedTuple`](@ref).
"""
Tuple

"""
    NamedTuple{names}(args::Tuple)

Construct a named tuple with the given `names` (a tuple of Symbols) from a tuple of values.
"""
NamedTuple{names}(args::Tuple)

"""
    NamedTuple{names,T}(args::Tuple)

Construct a named tuple with the given `names` (a tuple of Symbols) and field types `T`
(a `Tuple` type) from a tuple of values.
"""
NamedTuple{names,T}(args::Tuple)

"""
    NamedTuple{names}(nt::NamedTuple)

Construct a named tuple by selecting fields in `names` (a tuple of Symbols) from
another named tuple.
"""
NamedTuple{names}(nt::NamedTuple)

"""
    NamedTuple(itr)

Construct a named tuple from an iterator of key-value pairs (where the keys must be
`Symbol`s). Equivalent to `(; itr...)`.

!!! compat "Julia 1.6"
    This method requires at least Julia 1.6.
"""
NamedTuple(itr)

"""
    typeassert(x, type)

Throw a [`TypeError`](@ref) unless `x isa type`.
The syntax `x::type` calls this function.

# Examples
```jldoctest
julia> typeassert(2.5, Int)
ERROR: TypeError: in typeassert, expected Int64, got a value of type Float64
Stacktrace:
[...]
```
"""
typeassert

"""
    getproperty(value, name::Symbol)
    getproperty(value, name::Symbol, order::Symbol)

The syntax `a.b` calls `getproperty(a, :b)`.
The syntax `@atomic order a.b` calls `getproperty(a, :b, :order)` and
the syntax `@atomic a.b` calls `getproperty(a, :b, :sequentially_consistent)`.

# Examples
```jldoctest
julia> struct MyType{T <: Number}
           x::T
       end

julia> function Base.getproperty(obj::MyType, sym::Symbol)
           if sym === :special
               return obj.x + 1
           else # fallback to getfield
               return getfield(obj, sym)
           end
       end

julia> obj = MyType(1);

julia> obj.special
2

julia> obj.x
1
```

One should overload `getproperty` only when necessary, as it can be confusing if
the behavior of the syntax `obj.f` is unusual.
Also note that using methods is often preferable. See also this style guide documentation
for more information: [Prefer exported methods over direct field access](@ref).

See also [`getfield`](@ref Core.getfield),
[`propertynames`](@ref Base.propertynames) and
[`setproperty!`](@ref Base.setproperty!).
"""
Base.getproperty

"""
    setproperty!(value, name::Symbol, x)
    setproperty!(value, name::Symbol, x, order::Symbol)

The syntax `a.b = c` calls `setproperty!(a, :b, c)`.
The syntax `@atomic order a.b = c` calls `setproperty!(a, :b, c, :order)`
and the syntax `@atomic a.b = c` calls `setproperty!(a, :b, c, :sequentially_consistent)`.

!!! compat "Julia 1.8"
    `setproperty!` on modules requires at least Julia 1.8.

See also [`setfield!`](@ref Core.setfield!),
[`propertynames`](@ref Base.propertynames) and
[`getproperty`](@ref Base.getproperty).
"""
Base.setproperty!

"""
    swapproperty!(x, f::Symbol, v, order::Symbol=:not_atomic)

The syntax `@atomic a.b, _ = c, a.b` returns `(c, swapproperty!(a, :b, c, :sequentially_consistent))`,
where there must be one `getproperty` expression common to both sides.

See also [`swapfield!`](@ref Core.swapfield!)
and [`setproperty!`](@ref Base.setproperty!).
"""
Base.swapproperty!

"""
    modifyproperty!(x, f::Symbol, op, v, order::Symbol=:not_atomic)

The syntax `@atomic op(x.f, v)` (and its equivalent `@atomic x.f op v`) returns
`modifyproperty!(x, :f, op, v, :sequentially_consistent)`, where the first argument
must be a `getproperty` expression and is modified atomically.

Invocation of `op(getproperty(x, f), v)` must return a value that can be stored in the field
`f` of the object `x` by default.  In particular, unlike the default behavior of
[`setproperty!`](@ref Base.setproperty!), the `convert` function is not called
automatically.

See also [`modifyfield!`](@ref Core.modifyfield!)
and [`setproperty!`](@ref Base.setproperty!).
"""
Base.modifyproperty!

"""
    replaceproperty!(x, f::Symbol, expected, desired, success_order::Symbol=:not_atomic, fail_order::Symbol=success_order)

Perform a compare-and-swap operation on `x.f` from `expected` to `desired`, per
egal. The syntax `@atomicreplace x.f expected => desired` can be used instead
of the function call form.

See also [`replacefield!`](@ref Core.replacefield!)
[`setproperty!`](@ref Base.setproperty!),
[`setpropertyonce!`](@ref Base.setpropertyonce!).
"""
Base.replaceproperty!

"""
    setpropertyonce!(x, f::Symbol, value, success_order::Symbol=:not_atomic, fail_order::Symbol=success_order)

Perform a compare-and-swap operation on `x.f` to set it to `value` if previously unset.
The syntax `@atomiconce x.f = value` can be used instead of the function call form.

See also [`setfieldonce!`](@ref Core.replacefield!),
[`setproperty!`](@ref Base.setproperty!),
[`replaceproperty!`](@ref Base.replaceproperty!).

!!! compat "Julia 1.11"
    This function requires Julia 1.11 or later.
"""
Base.setpropertyonce!


"""
    StridedArray{T, N}

A hard-coded [`Union`](@ref) of common array types that follow the [strided array interface](@ref man-interface-strided-arrays),
with elements of type `T` and `N` dimensions.

If `A` is a `StridedArray`, then its elements are stored in memory with offsets, which may
vary between dimensions but are constant within a dimension. For example, `A` could
have stride 2 in dimension 1, and stride 3 in dimension 2. Incrementing `A` along
dimension `d` jumps in memory by [`stride(A, d)`] slots. Strided arrays are
particularly important and useful because they can sometimes be passed directly
as pointers to foreign language libraries like BLAS.
"""
StridedArray

"""
    StridedVector{T}

One dimensional [`StridedArray`](@ref) with elements of type `T`.
"""
StridedVector

"""
    StridedMatrix{T}

Two dimensional [`StridedArray`](@ref) with elements of type `T`.
"""
StridedMatrix

"""
    StridedVecOrMat{T}

Union type of [`StridedVector`](@ref) and [`StridedMatrix`](@ref) with elements of type `T`.
"""
StridedVecOrMat

"""
    Module

A `Module` is a separate global variable workspace. See [`module`](@ref) and the [manual section about modules](@ref modules) for details.

    Module(name::Symbol=:anonymous, std_imports=true, default_names=true)

Return a module with the specified name. A `baremodule` corresponds to `Module(:ModuleName, false)`

An empty module containing no names at all can be created with `Module(:ModuleName, false, false)`.
This module will not import `Base` or `Core` and does not contain a reference to itself.
"""
Module

"""
    Core

`Core` is the module that contains all identifiers considered "built in" to the language, i.e. part of the core language and not libraries. Every module implicitly specifies `using Core`, since you can't do anything without those definitions.
"""
Core.Core

"""
    Main

`Main` is the top-level module, and Julia starts with `Main` set as the current module.  Variables defined at the prompt go in `Main`, and `varinfo` lists variables in `Main`.
```jldoctest
julia> @__MODULE__
Main
```
"""
Main.Main

"""
    Base

The base library of Julia. `Base` is a module that contains basic functionality (the contents of `base/`). All modules implicitly contain `using Base`, since this is needed in the vast majority of cases.
"""
Base.Base

"""
    QuoteNode

A quoted piece of code, that does not support interpolation. See the [manual section about QuoteNodes](@ref man-quote-node) for details.
"""
QuoteNode


"""
    "
`"` Is used to delimit string literals. A trailing `\\` can be used to continue a string literal on the next line.

# Examples

```jldoctest
julia> "Hello World!"
"Hello World!"

julia> "Hello World!\\n"
"Hello World!\\n"

julia> "Hello \\
        World"
"Hello World"
```

See also [`\"""`](@ref \"\"\").
"""
kw"\""

"""
    \"""
`\"""` is used to delimit string literals. Strings created by triple quotation marks can contain `"` characters without escaping and are dedented to the level of the least-indented line. This is useful for defining strings within code that is indented.

# Examples

```jldoctest
julia> \"""Hello World!\"""
"Hello World!"

julia> \"""Contains "quote" characters\"""
"Contains \\"quote\\" characters"

julia> \"""
         Hello,
         world.\"""
"Hello,\\nworld."
```

See also [`"`](@ref \")
"""
kw"\"\"\""

"""
Unsafe pointer operations are compatible with loading and storing pointers declared with
`_Atomic` and `std::atomic` type in C11 and C++23 respectively. An error may be thrown if
there is not support for atomically loading the Julia type `T`.

See also: [`unsafe_load`](@ref), [`unsafe_modify!`](@ref), [`unsafe_replace!`](@ref), [`unsafe_store!`](@ref), [`unsafe_swap!`](@ref)
"""
kw"atomic"

"""
    Base.donotdelete(args...)

This function prevents dead-code elimination (DCE) of itself and any arguments
passed to it, but is otherwise the lightest barrier possible. In particular,
it is not a GC safepoint, does not model an observable heap effect, does not expand
to any code itself and may be re-ordered with respect to other side effects
(though the total number of executions may not change).

A useful model for this function is that it hashes all memory `reachable` from
args and escapes this information through some observable side-channel that does
not otherwise impact program behavior. Of course that's just a model. The
function does nothing and returns `nothing`.

This is intended for use in benchmarks that want to guarantee that `args` are
actually computed. (Otherwise DCE may see that the result of the benchmark is
unused and delete the entire benchmark code).

!!! note
    `donotdelete` does not affect constant folding. For example, in
    `donotdelete(1+1)`, no add instruction needs to be executed at runtime and
    the code is semantically equivalent to `donotdelete(2).`

!!! note
    This intrinsic does not affect the semantics of code that is dead because it is
    *unreachable*. For example, the body of the function `f(x) = false && donotdelete(x)`
    may be deleted in its entirety. The semantics of this intrinsic only guarantee that
    *if* the intrinsic is semantically executed, then there is some program state at
    which the value of the arguments of this intrinsic were available (in a register,
    in memory, etc.).

!!! compat "Julia 1.8"
    This method was added in Julia 1.8.

# Examples

```julia
function loop()
    for i = 1:1000
        # The compiler must guarantee that there are 1000 program points (in the correct
        # order) at which the value of `i` is in a register, but has otherwise
        # total control over the program.
        donotdelete(i)
    end
end
```
"""
Base.donotdelete

"""
    Base.compilerbarrier(setting::Symbol, val)

This function acts a compiler barrier at a specified compilation phase.
The dynamic semantics of this intrinsic are to return the `val` argument, unmodified.
However, depending on the `setting`, the compiler is prevented from assuming this behavior.

Currently either of the following `setting`s is allowed:
- Barriers on abstract interpretation:
  * `:type`: the return type of this function call will be inferred as `Any` always
    (the strongest barrier on abstract interpretation)
  * `:const`: the return type of this function call will be inferred with widening
    constant information on `val`
  * `:conditional`: the return type of this function call will be inferred with widening
    conditional information on `val` (see the example below)
- Any barriers on optimization aren't implemented yet

!!! note
    This function is expected to be used with `setting` known precisely at compile-time.
    If the `setting` is not known precisely at compile-time, the compiler will emit the
    strongest barrier(s). No compile-time warning is issued.

# Examples

```julia
julia> Base.return_types((Int,)) do a
           x = compilerbarrier(:type, a) # `x` won't be inferred as `x::Int`
           return x
       end |> only
Any

julia> Base.return_types() do
           x = compilerbarrier(:const, 42)
           if x == 42 # no constant information here, so inference also accounts for the else branch
               return x # but `x` is still inferred as `x::Int` at least here
           else
               return nothing
           end
       end |> only
Union{Nothing, Int64}

julia> Base.return_types((Union{Int,Nothing},)) do a
           if compilerbarrier(:conditional, isa(a, Int))
               # the conditional information `a::Int` isn't available here (leading to less accurate return type inference)
               return a
           else
               return nothing
           end
       end |> only
Union{Nothing, Int64}
```
"""
Base.compilerbarrier

"""
    Core.finalizer(f, o)

This builtin is an implementation detail of [`Base.finalizer`](@ref) and end-users
should use the latter instead.

# Differences from `Base.finalizer`

The interface of `Core.finalizer` is essentially the same as `Base.finalizer`,
but there are a number of small differences. They are documented here for
completeness only and (unlike `Base.finalizer`) have no stability guarantees.

The current differences are:
- `Core.finalizer` does not check for mutability of `o`. Attempting to register
  a finalizer for an immutable object is undefined behavior.
- The value `f` must be a Julia object. `Core.finalizer` does not support a
  raw C function pointer.
- `Core.finalizer` returns `nothing` rather than `o`.
"""
Core.finalizer

"""
    ConcurrencyViolationError(msg) <: Exception

An error thrown when a detectable violation of concurrent semantics has occurred.

A non-exhaustive list of examples of when this is used include:

 * Throwing when a deadlock has been detected (e.g. `wait(current_task())`)
 * Known-unsafe behavior is attempted (e.g. `yield(current_task)`)
 * A known non-threadsafe datastructure is attempted to be modified from multiple concurrent tasks
 * A lock is being unlocked that wasn't locked by this task
"""
ConcurrencyViolationError

Base.include(BaseDocs, "intrinsicsdocs.jl")

end
