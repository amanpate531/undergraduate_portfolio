file = open('rosalind_ba6b.txt', 'r')
contents = file.readlines()
s1 = contents[0].rstrip('\n')
# Counts the number of breakpoints in the sequence
# A breakpoint occurs between two numbers if the first is not one less than the second.
    # e.g. a breakpoint occurs between -3 and -4 because -3 is not one less than -4
permStr = s1[1:-1]
perm = permStr.split(' ')
length = len(perm)
noPos = []
for x in range(0, len(perm)):
    noPos.insert(x, int(perm[x]))
noPos.insert(0, 0)
noPos.insert(len(noPos), len(perm) + 1)
count = 0
for x in range(0, len(noPos)-1):
    if noPos[x] + 1 != noPos[x+1]:
        count = count + 1
print(count)
