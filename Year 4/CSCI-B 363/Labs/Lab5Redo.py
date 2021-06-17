file = open('rosalind_ba3d.txt', 'r')
contents = file.readlines()
file.close()
k = int(contents[0][:-1])
text = contents[1][:-1]
connections = []
# Finds all possible k-length nodes of the De Bruijn Graph of a Sequence
# Links any sequences where the last k-1 characters of the first sequence match the first k-1 characters of the second sequence.
for x in range(0, len(text)-k+2):
    connections.append([text[x:x+k-1], text[x+1:x+k]])
completedNodes = []
for x in range(0, len(connections)):
    tempx = x
    con = connections[x]
    for y in completedNodes:
        if con[0] == y[0]:
            y[1].append(con[1])
            x += 1
    if len(con[0]) != len(con[1]):
        continue
    if x == tempx:
        connectList = list()
        connectList.append(con[1])
        finalConnect = []
        finalConnect.append(con[0])
        finalConnect.append(connectList)
        completedNodes.append(finalConnect)
sorted_result = sorted(completedNodes)
f = open("lab5result.txt", "w")
for x in sorted_result:
    string = x[0] + " -> "
    for y in range(0, len(x[1])):
        if y == 0:
            string += x[1].pop()
        else:
            string = string + "," + x[1].pop()
    string+="\n"
    f.write(string)
f.close()
