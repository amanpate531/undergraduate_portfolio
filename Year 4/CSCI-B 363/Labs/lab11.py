# Determines the sequence of rotations needed to convert a signed, unsorted sequence of numbers into a sorted sequence with only positive numbers
# Each rotation reverses the sign of all numbers involved.
    # e.g. rotating +2 in (+1, -3, +5, +2, -4) to its proper position yields (+1, -2, -5, +3, -4)
    # -2 can then be rotated on its own to negate it (+1, +2, -5, +3, -4)
    # Rotations continue until the entire sequence is sorted and positive.
    
def printPerm(a):
    res = '('
    for x in range(0, len(a) - 1):
        if a[x] > 0:
            res = res + '+'
            res = res + str(a[x])
            res = res + ' '
        else:
            res = res + str(a[x])
            res = res + ' '
    if a[len(a) - 1] > 0:
        res = res + '+'
        res = res + str(a[len(a)-1])
    else: 
        res = res + str(a[len(a)-1])
    res = res + ')\n'
    f.write(res)

def reverseNegate(a):
    res = []
    for x in a:
        res.insert(0, x * -1)
    return res

file = open('rosalind_ba6a.txt', 'r')
contents = file.readlines()
s1 = contents[0].rstrip('\n')
permStr = s1[1:-1]
perm = permStr.split(' ')
noPos = []
for x in range(0, len(perm)):
    noPos.insert(x, int(perm[x]))
f = open("lab11result.txt", "w")
for x in range(1, len(noPos) + 1):
    if abs(noPos[x-1]) != x:
        for y in range(x, len(noPos) + 1):
            if abs(noPos[y-1]) == x:
                noPos[x-1:y] = reverseNegate(noPos[x-1:y])
                printPerm(noPos)
                if noPos[x-1] < 0:
                    noPos[x-1] = noPos[x-1] * -1
                    printPerm(noPos)
    elif abs(noPos[x-1]) == x and noPos[x-1] < 0:
        noPos[x-1] = noPos[x-1] * -1
        printPerm(noPos)
f.close()       
        
