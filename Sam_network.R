# Networks
# December 5, 2018
# SR

library(igraph)
library(igraphdata)
library(visNetwork)

data(package="igraphdata")
data(foodwebs)

# a network is a representation of individuals in a system. it consists of nodes or vertices. The components of networks that are connected are called edge or length. 

# make a network from scratch

g <- make_empty_graph(directed = F)
g <- g + vertices("Bio", "Eco", "CS", "Soc", "Psych", "Econ")
plot(g, vertex.label.dist=3)

# add edges to the vertex
g <- g + edges(c("CS", "Bio", "CS", "Eco", "CS", "Econ", "CS", "Soc", "CS", "Psych"))
plot(g, vertex.label.dist=3)


g <- g + edges(c("Bio","Eco", "Eco","Econ", "Soc", "Psych", "Soc","Econ"))
plot(g, vertex.label.dist=3)

edgeList <- matrix(c("CS", "Bio", "CS", "Eco", "CS", "Econ", "CS", "Soc", "CS", "Psych", "Bio","Eco", "Eco","Econ", "Soc", "Psych", "Soc","Econ"), ncol = 2, byrow = T)
print(edgeList)

edgeList2 <- as_edgelist(g, names = T)
print(edgeList2)

# make a new network from the edgelist

gEdgeList <- graph_from_edgelist(edgeList, directed = F)
plot(gEdgeList, vertex.label.dist=3)

# adjancency matrix

adjMatG <- as_adjacency_matrix(g) # get the adjacency matrix of g
print(adjMatG) # two vertices have a edge between them if they have 1

gAdjMat <- graph_from_adjacency_matrix(adjMatG, mode = "undirected")
plot(gAdjMat, verter.label.dist=3)

# Directed networks 

adjMat <- matrix(data=0, nrow=7, ncol=7)
species <- c("coyote", "vulture", "snake", "grass", "bug", "hawk", "mouse")
rownames(adjMat) <- colnames(adjMat) <- species # same line assigning same thing to two variables

print(adjMat)

adjMat["grass", "bug"] <- 1
adjMat["bug", "hawk"] <- 1
adjMat["grass", "mouse"] <- 1
adjMat["mouse", "hawk"] <- 1

adjMat["mouse", "coyote"] <- 1
adjMat["mouse", "snake"] <- 1
adjMat["mouse", "vulture"] <- 1
adjMat["hawk", "coyote"] <- 1
adjMat["coyote", "vulture"] <- 1
adjMat["snake", "vulture"] <- 1

print(adjMat)
foodWeb <- graph_from_adjacency_matrix(adjMat)
plot(foodWeb, vertex.label.dist=3)

is_weighted(foodWeb) # foodweb is not a weighted network

# in a weighted networks, edges represent weight 

adjMat["grass", "bug"] <- 0.2
adjMat["bug", "hawk"] <- 1
adjMat["grass", "mouse"] <- 0.8
adjMat["mouse", "hawk"] <- 0.2

adjMat["mouse", "coyote"] <- 0.2
adjMat["mouse", "snake"] <- 0.2
adjMat["mouse", "vulture"] <- 0.4
adjMat["hawk", "coyote"] <- 1
adjMat["coyote", "vulture"] <- 1
adjMat["snake", "vulture"] <- 1

print(adjMat)
foodWeb <- graph_from_adjacency_matrix(adjMat, weighted = T)
is_weighted(foodWeb)

# Label the edges with weights 
plot(foodWeb, vertx.label.dist=3, edge.label=E(foodWeb)$weight)

# map edge weights to the widths of plotted edges
E(foodWeb)$width <- E(foodWeb)$weight*5
plot(foodWeb, vertx.label.dist=3)

# Working with the real data
fwc <- foodwebs$CrystalC
plot(fwc, layout=layout_as_tree, vertex.label.dist=1.5)





