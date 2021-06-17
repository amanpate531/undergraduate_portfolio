#from ete3 import Tree

# Reading multiple alignment from text
file = open('sequences.txt', 'r')
contents = file.readlines()
stripped = []
for x in contents:
    strip = x.rstrip('\n')
    stripped.append(strip)
labels = []
for x in range(1, len(stripped) + 1):
    labels.append(str(x))

####################################################

# Distance matrix creation from multiple alignment
distanceMatrix = []
for r in range(0, len(stripped)):
    row = []
    for c in range(0, len(stripped)):
        row.append(0)
    distanceMatrix.append(row)
for x in range(0, len(stripped)):
    for y in range(0, len(stripped)):
        for z in range(0, len(stripped[x])):
            if stripped[x][z] != stripped[y][z]:
                dm = distanceMatrix[x][y]
                distanceMatrix[x][y] = dm+1

# Conversion to lower triangular matrix
for x in range(0, len(distanceMatrix)):
    distanceMatrix[x] = distanceMatrix[x][0:x]

for x in distanceMatrix:
    print(x)

####################################################

# UPGMA

# Finds indices of minimum cell in distance matrix
def find_min():
    minimum = 10**100
    minX = 0
    minY = 0
    for x in range(0, len(distanceMatrix)):
        for y in range(0, len(distanceMatrix[x])):
            if x == y:
                continue
            if distanceMatrix[x][y] < minimum:
                minimum = distanceMatrix[x][y]
                minX = x
                minY = y
    return minX, minY

# Combines x and y by averaging  
def reduce_dm(x, y):
    mini = min(x, y)
    maxi = max(x, y)
    row = []

# Average the rows and replace row
    for i in range(0, mini):
        row.append((distanceMatrix[mini][i] + distanceMatrix[maxi][i])/2)
    distanceMatrix[mini] = row
    
# Average the columns between mini and maxi using values from maxi row
    for j in range(mini + 1, maxi):
        distanceMatrix[j][mini] = (distanceMatrix[j][mini] + distanceMatrix[maxi][j])/2
        
# Average remaining column values using values from kth row
    for k in range(maxi + 1, len(distanceMatrix)):
        distanceMatrix[k][mini] = (distanceMatrix[k][mini] + distanceMatrix[k][maxi])/2
        del distanceMatrix[k][maxi]
        
# Delete column of redundant values used in averaging
    del distanceMatrix[maxi]

# Labels need to be joined to keep track of which rows/columns have been reduced
def label_join(x, y):
    mini = min(x, y)
    maxi = max(x, y)
    newLabel = "(" + labels[mini] + "," + labels[maxi] + ")"
    labels[mini] = newLabel
    del labels[maxi]

def UPGMA():
    while (len(labels) > 1):
        x, y = find_min()
        reduce_dm(x, y)
        label_join(x, y)
    print(labels[0])
##    tree_string = labels[0] + ';'
##    t = Tree(tree_string)
##    t.show()

UPGMA()
