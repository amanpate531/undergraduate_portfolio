url = 'https://en.wikipedia.org/w/api.php?format=xml&action=query&prop=categories&titles=Google'
import urllib.request
page = urllib.request.urlopen(url)
print(page.read())
content = '{"continue":{"clcontinue":"1092923|Articles_containing_potentially_dated_statements_from_2017","continue":"||"},"query":{"pages":{"1092923":{"pageid":1092923,"ns":0,"title":"Google","categories":[{"ns":14,"title":"Category:1998 establishments in California"},{"ns":14,"title":"Category:2004 initial public offerings"},{"ns":14,"title":"Category:All Wikipedia articles in need of updating"},{"ns":14,"title":"Category:All Wikipedia articles written in American English"},{"ns":14,"title":"Category:All articles containing potentially dated statements"},{"ns":14,"title":"Category:Alphabet Inc."},{"ns":14,"title":"Category:American websites"},{"ns":14,"title":"Category:Articles containing potentially dated statements from 1998"},{"ns":14,"title":"Category:Articles containing potentially dated statements from 2007"},{"ns":14,"title":"Category:Articles containing potentially dated statements from 2015"}]}}}}'
import json
j = json.loads(content)
print(type(j))
print(j.keys())
print(j["query"].keys())
print(j["query"]["pages"].keys())
print(j["query"]["pages"]["1092923"].keys())
print(j["query"]["pages"]["1092923"]["title"])
print(type(j["query"]["pages"]["1092923"]["categories"]))
