struct ColumnName
    name::Symbol
    is_dynamic::Bool
end

function Base.isless(x::ColumnName, y::ColumnName)
    isless(x.is_dynamic, y.is_dynamic) ||
    isless(x.name, y.name)
end
