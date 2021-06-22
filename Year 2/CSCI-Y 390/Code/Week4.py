url = 'https://en.wikipedia.org/w/api.php?format=json&action=query&prop=categories&titles=Python_(programming_language)&cllimit=100'
import urllib.request
page = urllib.request.urlopen(url)
content = page.read()
content = content.decode()
import json
j = json.loads(content)
string = j["query"]["pages"]["23862"]["categories"][20]["title"]
string  = string.replace(" ", "_")
print(string)
subcatURL = url.replace("Python_(programming_language)", string)
categories2URL = subcatURL
print(categories2URL)
subcatURL = subcatURL.replace("prop=categories&titles", "list=categorymembers&cmtitle")
subcatURL = subcatURL.replace("cllimit=100", "cmtype=subcat&cmlimit=500")
print(subcatURL)
subcatPage = urllib.request.urlopen(subcatURL)
subcatContent = subcatPage.read()
subcatContent = subcatContent.decode()
j2 = json.loads(subcatContent)
subcatList = j2["query"]["categorymembers"]
print(subcatList)
categories2Page = urllib.request.urlopen(categories2URL)
categories2Content = categories2Page.read()
categories2Content = categories2Content.decode()
j3 = json.loads(categories2Content)
categories2List = j3["query"]["pages"]["690571"]["categories"]
print(categories2List)
