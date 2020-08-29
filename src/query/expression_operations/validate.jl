"""
# Description

Check if an expression contains grammatical rules that Volcanito can't handle.
If so, throw an error. Otherwise, return `nothing` to indicate that the code
was valid.

# Arguments

1. `e::Any`: An expression.

# Return Values

1. `_::Nothing`: If `e` is valid, return `nothing`. Otherwise an error is
    thrown.

# Examples

```
julia> validate(:x)

```
"""
function validate(@nospecialize(e::Any))::Nothing
    heads = (
        :comprehension,
        :block,
        :import,
        :export,
        :while,
        :for,
        :break,
        :continue,
        :let,
        :struct,
    )

    if isa(e, Expr)
        for head in heads
            if e.head == head
                error("Expr's with head == $head are not supported")
            end
        end
    end

    if isa(e, Expr)
        for i in 1:length(e.args)
            validate(e.args[i])
        end
        nothing
    elseif isa(e, Symbol)
        nothing
    else
        nothing
    end
end
