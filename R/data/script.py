import csv
import random

data = {}

questionsToKeep = [2,3,4,5,6,8,9,11,12,13,14,15,16,17,18,20,21,23,24]

with open("qcm.csv", mode='r', encoding="utf-8") as csv_file:
	csv_reader = csv.reader(csv_file, delimiter=";")
	line_count = 0
	for row in csv_reader:
		if line_count == 0:
			for column in row:
				data[column] = []
		else:
			for i in range(len(row)):
				key = list(data.keys())[i]
				data[key].append(row[i])
		line_count += 1

i = 0
t = ""
for question in data.keys():
	t = question
	print(i, question, end=" | ")
	i += 1

dataToWrite = [""] * (len(data[t]) + 1)
for question in questionsToKeep:
	key = list(data.keys())[question-1]
	dataToWrite[0] += key + ";"
	for i in range(len(data[key])):
		dataToWrite[i+1] += data[key][i] + ";"

for i in range(len(dataToWrite)):
	dataToWrite[i] = dataToWrite[i][:-1] + "\n"

with open("qcm_" + "_".join([str(e) for e in questionsToKeep]) + ".csv", 'w') as csv_qcm:
	for row in dataToWrite:
		csv_qcm.write(row)

print()