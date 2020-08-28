# TODO: Document this
function materialize(op::Limit)
    materialize(op.source)[1:op.n, :]
end
