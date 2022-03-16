abstract type AbstractNode end
abstract type Node <: AbstractNode end
abstract type MetaNode <: AbstractNode end

struct SimpleNode{T <: Symbol} <: Node
    node::T
end

Node(node) = SimpleNode(node)

abstract type AbstractEdge end
abstract type Edge <: AbstractEdge end
abstract type MetaEdge <: AbstractEdge end

Edge(src, dst) = DirectedEdge(src, dst)

struct DirectedEdge{T1 <: AbstractNode, T2 <: AbstractNode} <: Edge
    src::T1
    dst::T2
end

struct UndirectedEdge{T1 <: AbstractNode, T2 <: AbstractNode} <: Edge
    src::T1
    dst::T2
end

abstract type Modifier end
abstract type EdgeModifier <: Modifier end

abstract type NodeModifier <: Modifier end
const NodeOrEdgeModifier = Union{EdgeModifier,NodeModifier}

struct ModifiedEdge{E <: AbstractEdge, DM <: AbstractDict{S, M} where {S <: Symbol, M <: EdgeModifier}} <: MetaEdge
    edge::E
    modifiers::DM
end

struct ModifyingNode{N <: AbstractNode, DM <: AbstractDict{S, M} where {S <: Symbol, M <: EdgeModifier}} <: MetaNode
    node::N
    modifiers::DM
end

struct ModifiedNode{N <: AbstractNode, DM <: AbstractDict{S, M} where {S <: Symbol, M <: NodeModifier}} <: MetaNode
    node::N
    modifiers::DM
end

struct Arrow{VE <: Vector{E} where {E <: AbstractEdge}, N1, N2} <: MetaEdge
    edges::VE
    lhs::N1
    rhs::N2
end
