# Local Variable Capture

Explicitly capturing locals is done using the `$` operator. Something like,

```
x == $x
```

is rewritten into

```
t -> t[1] + x
```
