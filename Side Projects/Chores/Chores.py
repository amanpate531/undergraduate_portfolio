import random
import datetime

listOfNames = ["Varun", "Mintu", "Chingam", "Ghotla", "DK", "Lodiya", "Dharamraj"]

listOfJobs = [("Scrub", 0), ("Wash", 1), ("Vacuum", 2), ("Counter Blue/Sink", 3), ("Counter White/Handles", 4), ("Gas", 5), ("FREE", 6)]

date = datetime.date.today()

month = date.month
day = date.day
year = date.year

f = open("stats.txt", "r")
text = f.read()
lines = text.split('\n')
f.close()

for x in range(0, 8):
    line = lines[x]
    lines[x] = line.split()
for x in range(0, 3):
    lines[0][x] = int(lines[0][x])
for x in range(1, 8):
    for y in range(0, 7):
        lines[x][y] = int(lines[x][y])

if (lines[0][0] == month and lines[0][1] == day and lines[0][2] == year):
    print("The program has already been run today, here are the results:")
    print()
    jobs = lines[8].split(') (')
    for x in jobs:
        print(x)
    print()
    print("Stats:")
    for x in range(1, 8):
        print(lines[x])
else:
    while (listOfJobs[0] == ("Scrub", 0) or listOfJobs[0] == ("Wash", 1)):
        random.shuffle(listOfJobs)

    jobs = [0, 0, 0, 0, 0, 0, 0]

    for x in range(0, 7):
        lines[x+1][listOfJobs[x][1]] += 1
        job = (listOfNames[x], listOfJobs[x][0])
        print(job)
        jobs[x] = job
    lines[0][0] = month
    lines[0][1] = day
    lines[0][2] = year
    temp = lines
    if (len(lines) == 8):
        lines.append(jobs)
    else:
        lines[8] = jobs
    for x in range(0, 9):
        lines[x] = ' '.join(map(str, lines[x]))
    lineString = '\n'.join(lines)
    f = open("stats.txt", "w")
    f.write(lineString)
    f.close()
    print()
    print("Stats:")
    for x in range(1, 8):
        print(temp[x])
    
    
