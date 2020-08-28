# Lifting

Automatic lifting takes something like,

```
foo(x)
```

and produces something like,

```
if uses_default_lifting(foo)
    tmp1 = x
    if ismissing(tmp1)
        missing
    else
        f(tmp1)
    end
else
    f′ = lift(f)
    f′(args...)
end
```
