from NarisiLabirint import Risanje
import time
class Node :
    def __init__(self, x, y, parent, weight, konci):
        self.x = x
        self.y = y
        self.parent = parent
        self.weigth = weight
        self.konci = konci
        self.razdalja = self.izracunajRazdaljo()

    def getWeight(self):
        if self.parent != None :
            return self.weigth + self.parent.getWeight()
        else :
            return self.weigth
    def getParent(self):
        if self.parent != None :
            return self.parent


    def getRazdalja(self):
        return self.razdalja


    def izracunajRazdaljo(self):
        razdalje = list()
        for i in self.konci :
            razdalje.append(abs(self.x - i[0]) + abs(self.y - i[1]))
        return min(razdalje)

def poisciresitev(node) :
    if node == None :
        return
    resitev1.insert(0, [node.x, node.y])
    poisciresitev(node.getParent())

def main(path) :
    tocke = list()
    st = 0
    for vrstica in open(path) :
        vrstica = vrstica.split(",")
        tocke.append([])
        for tocka in vrstica :
            tocke[st].append(int(tocka))
        st += 1
    risar = Risanje(tocke)
    risar.t.hideturtle()
    risar.narisiLabirint()

    zacetek = list()
    konci = list()
    #Dodamo zacetek in konce v seznam
    for i in range(len(tocke)) :
        for j in range(len(tocke[0])) :
            if tocke[i][j] == -2 :
                tocke[i][j] = 0
                zacetek.append([i,j])
            if tocke[i][j] == -3 :
                tocke[i][j] = 0
                konci.append([i,j])

    #Dodamo zacetno tocko in nastavimo razdaljo na 0
    nodes = list()
    nodes.append(Node(zacetek[0][0], zacetek[0][1], None, 0, konci))
    nodes[0].razdalja = 0
    nodes[0] = 0, nodes[0]
    obiskani = list()
    obiskani.append([zacetek[0][0], zacetek[0][1]])

    resitev = list()



    while [nodes[0][1].x, nodes[0][1].y] not in konci :
        risar.narisiZacetek(zacetek[0][0], zacetek[0][1])
        najmanjsi = nodes[0][1]

        # Gor
        if tocke[najmanjsi.x - 1][najmanjsi.y] != -1 and [najmanjsi.x - 1, najmanjsi.y] not in obiskani:
            dodan = False
            novnode = Node(najmanjsi.x - 1, najmanjsi.y, nodes[0][1], tocke[najmanjsi.x - 1][najmanjsi.y], konci)
            sestevek = novnode.getWeight()
            sestevek += novnode.getRazdalja()
            for raz, node in nodes:
                if node.x == najmanjsi.x - 1 and node.y == najmanjsi.y:
                    sestevek2 = node.getWeight()
                    sestevek2 += node.getRazdalja()
                    if sestevek < sestevek2:
                        nodes.remove((raz, node))
                        nodes.append((sestevek, novnode))
                        resitev.remove(node)
                        resitev.append(novnode)
            if dodan is False:
                nodes.append(novnode)
                nodes[-1] = (sestevek, nodes[-1])
                obiskani.append([nodes[-1][1].x, nodes[-1][1].y])
                risar.narisiPot(nodes[-1][1].x, nodes[-1][1].y)
                resitev.append(novnode)

        # Levo
        if tocke[najmanjsi.x][najmanjsi.y - 1] != -1 and [najmanjsi.x, najmanjsi.y - 1] not in obiskani:
            dodan = False
            novnode = Node(najmanjsi.x, najmanjsi.y - 1, nodes[0][1], tocke[najmanjsi.x][najmanjsi.y - 1], konci)
            sestevek = novnode.getWeight()
            sestevek += novnode.getRazdalja()
            for raz, node in nodes:
                if node.x == najmanjsi.x and node.y == najmanjsi.y - 1:
                    sestevek2 = node.getWeight()
                    sestevek2 += node.getRazdalja()
                    if sestevek < sestevek2:
                        nodes.remove((raz, node))
                        nodes.append((sestevek, novnode))
                        resitev.remove(node)
                        resitev.append(novnode)
            if dodan is False:
                nodes.append(novnode)
                nodes[-1] = (sestevek, nodes[-1])
                obiskani.append([nodes[-1][1].x, nodes[-1][1].y])
                risar.narisiPot(nodes[-1][1].x, nodes[-1][1].y)
                resitev.append(novnode)

        #Desno
        if tocke[najmanjsi.x][najmanjsi.y + 1] != -1 and [najmanjsi.x, najmanjsi.y + 1] not in obiskani:
            dodan = False
            novnode = Node(najmanjsi.x, najmanjsi.y + 1, nodes[0][1], tocke[najmanjsi.x][najmanjsi.y + 1], konci)
            sestevek = novnode.getWeight()
            sestevek += novnode.getRazdalja()
            for raz, node in nodes :
                if node.x == najmanjsi.x and node.y == najmanjsi.y + 1 :
                    sestevek2 = node.getWeight()
                    sestevek2 += node.getRazdalja()
                    if sestevek < sestevek2 :
                        nodes.remove((raz,node))
                        nodes.append((sestevek, novnode))
                        resitev.remove(node)
                        resitev.append(novnode)
            if dodan is False :
                nodes.append(novnode)
                nodes[-1] = (sestevek , nodes[-1])
                obiskani.append([nodes[-1][1].x, nodes[-1][1].y])
                risar.narisiPot(nodes[-1][1].x, nodes[-1][1].y)
                resitev.append(novnode)

        #Dol
        if tocke[najmanjsi.x + 1][najmanjsi.y] != -1 and [najmanjsi.x + 1, najmanjsi.y] not in obiskani :
            dodan = False
            novnode = Node(najmanjsi.x + 1, najmanjsi.y, nodes[0][1], tocke[najmanjsi.x + 1][najmanjsi.y], konci)
            sestevek = novnode.getWeight()
            sestevek += novnode.getRazdalja()
            for raz, node in nodes :
                if node.x == najmanjsi.x + 1 and node.y == najmanjsi.y :
                    sestevek2 = node.getWeight()
                    sestevek2 += node.getRazdalja()
                    if sestevek < sestevek2 :
                        nodes.remove((raz,node))
                        nodes.append((sestevek, novnode))
                        resitev.remove(node)
                        resitev.append(novnode)
            if dodan is False :
                nodes.append(novnode)
                nodes[-1] = (sestevek , nodes[-1])
                obiskani.append([nodes[-1][1].x, nodes[-1][1].y])
                risar.narisiPot(nodes[-1][1].x, nodes[-1][1].y)
                resitev.append(novnode)
        risar.iskanje(nodes[0][1].x, nodes[0][1].y)
        nodes = nodes[1:]
        nodes = sorted(nodes, key=lambda nodes: nodes[0])


    global resitev1
    resitev1 = list()
    #Najdi ciljni node
    for i in resitev :
        if [i.x, i.y] in konci :
            ciljni = i
    risar.narisiZacetek(zacetek[0][0], zacetek[0][1])
    for i in konci :
        risar.narisiKonce(i[0], i[1])
    poisciresitev(ciljni)
    for i in resitev1[1:] :
        screen_x = -350 + (i[1] * risar.velikost)
        screen_y = 350 - (i[0] * risar.velikost)
        risar.narisiResitev(screen_x, screen_y)
    print("A* cena najdene poti: " + str(ciljni.getWeight()))
    print("A* dolzina najdene poti: " + str(len(resitev1)))
    print("A* stevilo razvitih vozlisc: " + str(len(resitev)))
    time.sleep(2)
    risar.screen.clearscreen()




