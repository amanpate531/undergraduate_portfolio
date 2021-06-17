file = open("rosalind_ba1f.txt", "r")
contents = file.readlines()
text = contents[0][:-1]
# Finds the base positions where the sequence skew is minimized
# Skew = Frequency of G - Frequency of C for a base sequence
def minimumSkew():
    minPositions = set()
    minSkew = 2 ** 63
    skew = 0
    for x in range(0, len(text)):
        if text[x] == "C":
            skew -= 1
        if text[x] == "G":
            skew += 1
        if skew == minSkew:
            minPositions.add(x+1)
        if skew < minSkew:
            minPositions = set()
            minPositions.add(x+1)
            minSkew = skew
    for x in minPositions:
        print(x)

minimumSkew()
