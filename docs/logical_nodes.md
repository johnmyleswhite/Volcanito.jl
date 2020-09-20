# Logical Nodes

Logical nodes represent a unit of work on a table like a projection (what
SQL's `SELECT` does) and a selection (what SQL's `WHERE` does).

Currently, the following exist:

* LogicalNode
    * AggregateVector
    * GroupBy
    * Limit
    * OrderBy
    * Projection
    * Selection
    * Join
