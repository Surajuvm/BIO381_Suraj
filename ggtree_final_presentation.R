# ggtree
# november 28, 18
# SB

# Phylogenetic trees - visualization and annotation 
# diagrams representing evolutionary relationships among organisms 
# nodes - common ancestor, tips - species, branch length - evolutionary time 

# ggtree - designed by extending ggplot2 
library(ggtree)
set.seed(112818)
tree <- rtree(n=15, tip.label = LETTERS[seq(1:15)])  # random tree of 15 tips 
summary(tree)

# visualization of a tree

ggtree(tree)

# layouts
ggtree(tree, layout = "slanted")
ggtree(tree, layout = "circular")
ggtree(tree, layout = "fan", open.angle = 120)

# cladograms - branch length is not informative
ggtree(tree, layout = "slanted", branch.length = "none")

# unrooted trees
ggtree(tree, layout = "daylight")

# display nodes and tips 

p <- ggtree(tree) +
  geom_nodepoint(color="blue", alpha=0.5, size=4)
p
p +
  geom_tippoint(color="red", shape=5, size=3)

# Tree manipulation
# view tiplabel and node label
p +
  geom_text2(aes(subset=!isTip, label=node), hjust = -.5) +
  geom_tiplab()

# view clade
viewClade(p + geom_tiplab(), node = 26)

# group clades
tree <- groupClade(tree, .node = c(21,25))
ggtree(tree, aes(color=group, linetype=group)) +
  geom_tiplab(aes(subset=(group==1)))

ggtree(tree, aes(color=group, linetype=group)) +
  geom_tiplab(aes(subset=(group==2)))

# collapse a clade
cp <- collapse(p, node = 21)
cp +
  geom_point2(aes(subset=(node==21)), size=5, shape=23, fill="steelblue")

# useful in large datasets 

# expand the collapsed clade 
cp %>% expand(node=21)

# tree annotations
# annotating a clade
p +
  geom_cladelabel(node=21, label = "my clade") +
  geom_cladelabel(node=25, label = "your clade")

# adjust postion/ color
p +
  geom_cladelabel(node=21, label = "my clade", align = TRUE, offset = -1, color = "red") +
  geom_cladelabel(node=25, label = "your clade", align=TRUE, offset=-0.5, color = "blue")

# change the size of bar and text 
p +
  geom_cladelabel(node=21, label = "my clade", align = TRUE, offset = -1, color = "red", barsize = 1.5, fontsize = 5) +
  geom_cladelabel(node=25, label = "your clade", align=TRUE, offset=-0.5, color = "blue", barsize = 2, fontsize = 5)

# Phylomoji 
library(emojifont)
# label clade using emoji
p+
  geom_cladelabel(node=21, label="chicken", parse="emoji",
                fontsize=12, align=TRUE, color="firebrick") +
  geom_cladelabel(node=25, label="duck", parse="emoji",
                  fontsize=12, align=TRUE, color="steelblue")
  


tree_text <- "(((((cow, (whale,dolphin)), (pig, boar)), camel), fish), seedling);" 
x <- read.tree(text = tree_text)

ggtree(x, linetype="dashed", color="firebrick") +
  xlim(NA,7) + ylim(NA,8.5) +
  geom_tiplab(aes(color=label), parse="emoji", size=14, vjust=0.25) +
  labs(title = "exploring cool emoji in phylogenetics", caption = "powered by ggtree + emojifont")
