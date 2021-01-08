from NarisiLabirint import Risanje
import time
class Node :
    def __init__(self, x, y, parent, weight):
        self.x = x
        self.y = y
        self.parent = parent
        self.weigth = weight

    def getWeight(self):
        if self.parent != None :
            return self.weigth + self.parent.getWeight()
        else :
            return self.weigth
    def getParent(self):
        if self.parent != None :
            return self.parent

def poisciresitev(node) :
    if node == None :
        return
    resitev1.insert(0, [node.x, node.y])
    poisciresitev(node.getParent())


def main(path):
    tocke = list()
    st = 0
    for vrstica in open(path):
        vrstica = vrstica.split(",")
        tocke.append([])
        for tocka in vrstica:
            tocke[st].append(int(tocka))
        st += 1
    risar = Risanje(tocke)
    risar.t.hideturtle()
    risar.narisiLabirint()

    zacetek = list()
    konci = list()
    # Dodamo zacetek in konce v seznam
    for i in range(len(tocke)):
        for j in range(len(tocke[0])):
            if tocke[i][j] == -2:
                zacetek.append([i, j])
            if tocke[i][j] == -3:
                tocke[i][j] = 0
                konci.append([i, j])

    # Dodamo zacetno tocko in nastavimo razdaljo na 0
    nodes = list()
    razviti = list()
    koordinate = list()
    resitev = list()
    nodes.append(Node(zacetek[0][0], zacetek[0][1], None, -1))
    nodes[0] = 0, nodes[0]
    razviti.append(nodes[0][1])


    while nodes[0][1].weigth != 0 :
        najkrajsi = nodes[0][1]
# Gor
        if tocke[najkrajsi.x - 1][najkrajsi.y] != -1 and [najkrajsi.x - 1, najkrajsi.y] not in koordinate :
            novnode = Node(najkrajsi.x - 1, najkrajsi.y, najkrajsi, tocke[najkrajsi.x - 1][najkrajsi.y])
            novarazdalja = novnode.getWeight()
            obstaja = False
            for dolzina, node in nodes :
                if node.x == novnode.x and node.y == novnode.y:
                    stararazdalja = node.getWeight()
                    if novarazdalja < stararazdalja:
                        nodes.remove((dolzina, node))
                        nodes.append((novarazdalja, novnode))
                        obstaja = True
            if obstaja is False :
                risar.narisiPot(nodes[-1][1].x, nodes[-1][1].y)
                nodes.append((novarazdalja, novnode))
# Levo
        if tocke[najkrajsi.x][najkrajsi.y - 1] != -1 and [najkrajsi.x, najkrajsi.y - 1] not in koordinate:
            novnode = Node(najkrajsi.x, najkrajsi.y - 1, najkrajsi, tocke[najkrajsi.x][najkrajsi.y - 1])
            novarazdalja = novnode.getWeight()
            obstaja = False
            for dolzina, node in nodes:
                if node.x == novnode.x and node.y == novnode.y:
                    stararazdalja = node.getWeight()
                    if novarazdalja < stararazdalja:
                        nodes.remove((dolzina, node))
                        nodes.append((novarazdalja, novnode))
                        obstaja = True
            if obstaja is False:
                risar.narisiPot(nodes[-1][1].x, nodes[-1][1].y)
                nodes.append((novarazdalja, novnode))

# Desno
        if tocke[najkrajsi.x][najkrajsi.y + 1] != -1 and [najkrajsi.x, najkrajsi.y + 1] not in koordinate:
            novnode = Node(najkrajsi.x, najkrajsi.y + 1, najkrajsi, tocke[najkrajsi.x][najkrajsi.y + 1])
            novarazdalja = novnode.getWeight()
            obstaja = False
            for dolzina, node in nodes:
                if node.x == novnode.x and node.y == novnode.y:
                    stararazdalja = node.getWeight()
                    if novarazdalja < stararazdalja:
                        nodes.remove((dolzina, node))
                        nodes.append((novarazdalja, novnode))
                        obstaja = True
            if obstaja is False:
                risar.narisiPot(nodes[-1][1].x, nodes[-1][1].y)
                nodes.append((novarazdalja, novnode))
# Dol
        if tocke[najkrajsi.x + 1][najkrajsi.y] != -1 and [najkrajsi.x + 1, najkrajsi.y] not in koordinate :
            novnode = Node(najkrajsi.x + 1, najkrajsi.y, najkrajsi, tocke[najkrajsi.x + 1][najkrajsi.y])
            novarazdalja = novnode.getWeight()
            obstaja = False
            for dolzina, node in nodes :
                if node.x == novnode.x and node.y == novnode.y:
                    stararazdalja = node.getWeight()
                    if novarazdalja < stararazdalja:
                        nodes.remove((dolzina, node))
                        nodes.append((novarazdalja, novnode))
                        obstaja = True
            if obstaja is False :
                risar.narisiPot(nodes[-1][1].x, nodes[-1][1].y)
                nodes.append((novarazdalja, novnode))
        risar.iskanje(nodes[0][1].x, nodes[0][1].y)
        razviti.append(nodes[0][1])
        koordinate.append([nodes[0][1].x, nodes[0][1].y])
        nodes = nodes[1:]
        nodes = sorted(nodes, key=lambda nodes: nodes[0])

    global resitev1
    resitev1 = list()
    razviti.append(nodes[0][1])
    for i in razviti :
        if i.weigth == 0 :
            ciljni = i
    risar.narisiZacetek(zacetek[0][0], zacetek[0][1])
    for i in konci :
        risar.narisiKonce(i[0], i[1])
    poisciresitev(ciljni)
    for i in resitev1[1:] :
        screen_x = -350 + (i[1] * risar.velikost)
        screen_y = 350 - (i[0] * risar.velikost)
        risar.narisiResitev(screen_x, screen_y)
    print("Djkstra cena najdene poti: " + str(ciljni.getWeight() + 1))
    print("Dijkstra dolzina najdene poti: " + str(len(resitev1)))
    print("Djkstra stevilo razvitih vozlisc: " + str(len(razviti)))
    time.sleep(2)
    risar.screen.clearscreen()




