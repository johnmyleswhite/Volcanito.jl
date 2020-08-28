# Documentation Overview

Readers should start by reading the
[docs/architecture.md](https://github.com/johnmyleswhite/Volcanito.jl/blob/master/docs/architecture.md]) document to understand the big
picture design of Volcanito.

Starting there, readers who want more detail should read in order of increasing
depth:

* [docs/architecture.md](https://github.com/johnmyleswhite/Volcanito.jl/blob/master/docs/architecture.md]): Read this first to understand
    the general architecture of Volcanito.
    * [docs/macros.md](https://github.com/johnmyleswhite/Volcanito.jl/blob/master/docs/macros.md) Read this to understand the user-facing
        macro API layer.
        * [docs/expression_rules.md](https://github.com/johnmyleswhite/Volcanito.jl/blob/master/docs/expression_rules.md): Read this to
        understand the rules Volcanito uses to decide which symbols in an
        expression should be assumed to be column names in the table being
        processed.
        * [docs/locals.md](https://github.com/johnmyleswhite/Volcanito.jl/blob/master/docs/locals.md) Read this to understand Volcanito's
        opt-in approach to capturing local variables.
        * [docs/lifting.md](https://github.com/johnmyleswhite/Volcanito.jl/blob/master/docs/lifting.md) Read this to understand Volcanito's
        approach to automated lifting of functions to handle `missing` values.
        * [docs/tvl.md](https://github.com/johnmyleswhite/Volcanito.jl/blob/master/docs/tvl.md) Read this to understand Volcanito's
        approach to automatic application of three-valued logic.
    * [docs/logical_nodes.md](https://github.com/johnmyleswhite/Volcanito.jl/blob/master/docs/logical_nodes.md): Read this to understand
    the logical nodes Volcanito uses to represent a query.
        * [docs/function_specs.md](https://github.com/johnmyleswhite/Volcanito.jl/blob/master/docs/function_specs.md) Read this to
            understand the `FunctionSpec` objects that logical nodes contain.
    * [docs/physical_operations.md](https://github.com/johnmyleswhite/Volcanito.jl/blob/master/docs/physical_operations.md): Read this to
    understand the physical operations Volcanito uses to execute a query against
    a DataFrame.
