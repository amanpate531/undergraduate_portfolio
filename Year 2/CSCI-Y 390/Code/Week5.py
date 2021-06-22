url = 'https://en.wikipedia.org/w/api.php?format=json&action=query&prop=categories&titles=Python_(programming_language)&cllimit=500'
import networkx as nx
import matplotlib.pyplot as plt
G = nx.Graph()
F = nx.Graph()
H = nx.Graph()
names = []
import urllib.request
page = urllib.request.urlopen(url)
content = page.read()
content = content.decode()
current = "Python_(programming_language)"
G.add_node("Python_(programming_language)", related=1, name="Python_(programming_language)")
names.append("Python_(programming_language)")
import json
a = json.loads(content)
for i in range(0, len(a["query"]["pages"]["23862"]["categories"])):
    temp = a["query"]["pages"]["23862"]["categories"][i]["title"]
    temp = temp.replace(" ", "_")
    if "programming" in temp:
        G.add_node(temp, related=1, name=temp)
        G.add_edge(temp, "Python_(programming_language)")
        names.append(temp)
    else:
        G.add_node(temp, related=0, name=temp)
        G.add_edge(temp, "Python_(programming_language)")
        names.append(temp)
    url = url.replace(current, temp)
    page = urllib.request.urlopen(url)
    content = page.read()
    content = content.decode()
    b = json.loads(content)
    keys = list(b["query"]["pages"])
    dLength = 0
    for k in range(0, len(b["query"]["pages"]["" + keys[0]]["categories"])):
        result = "" + b["query"]["pages"]["" + keys[0]]["categories"][k]["title"]
        if "programming" in result:
            G.add_node(result, related=1, name=result)
            G.add_edge(temp, result)
            names.append(result)
        else:
            G.add_node(result, related=0, name=result)
            G.add_edge(temp, result)
            names.append(result)
    subcatURL = url
    subcatURL = subcatURL.replace("prop=categories&titles", "list=categorymembers&cmtitle")
    subcatURL = subcatURL.replace("cllimit=500", "cmtype=subcat&cmlimit=500")
    page = urllib.request.urlopen(subcatURL)
    content = page.read()
    content = content.decode()
    c = json.loads(content)
    if len(c["query"]["categorymembers"]) != 0:
        for l in range(0,len(c["query"]["categorymembers"])):
            result = c["query"]["categorymembers"][l]["title"]
            if "programming" in result:
                G.add_node(result, related=1, name=result)
                G.add_edge(temp, result)
                names.append(result)
            else:
                G.add_node(result, related=0, name=result)
                G.add_edge(temp, result)
                names.append(result)
    pagesURL = subcatURL
    pagesURL = pagesURL.replace("subcat", "page")
    page = urllib.request.urlopen(pagesURL)
    content = page.read()
    content = content.decode()
    d = json.loads(content)
    for m in range(0, len(d["query"]["categorymembers"])):
        result = d["query"]["categorymembers"][m]["title"]
        if "programming" in result:
            G.add_node(result, related=1, name=result)
            G.add_edge(temp, result)
            names.append(result)
        else:
            G.add_node(result, related=0, name=result)
            G.add_edge(temp, result)
            names.append(result)
    current = temp
listOfNodes = G.nodes()
print(names[33])
print(len(list(G.neighbors(G.node[names[33]]['name']))))
for n in range(0, G.number_of_nodes()):
    listOfNeighbor = G.neighbors(G.node[names[n]]['name'])
    count = 0
    for o in (list(listOfNeighbor)):
        if G.node[o]['related']==1:
            count = count + 1
    if (count == 0):
        H.add_node(G.node[names[n]]['name'], related=G.node[names[n]]['related'])
    elif (len(list(listOfNeighbor)) == 0):
        F.add_node(G.node[names[n]]['name'], related=G.node[names[n]]['related'])
    elif (count / len(list(listOfNeighbor))) >= 0.001:
        F.add_node(G.node[names[n]]['name'], related=G.node[names[n]]['related'])
    else:
        H.add_node(G.node[names[n]]['name'], related=G.node[names[n]]['related'])
print(G.number_of_nodes())
print(F.number_of_nodes())
print(H.number_of_nodes())
print(G.number_of_edges())
nx.write_gml(G, "graph2.gml")
nx.write_gml(F, "subgraph1.gml")
nx.write_gml(H, "subgraph2.gml")
