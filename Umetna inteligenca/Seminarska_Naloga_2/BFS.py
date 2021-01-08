from NarisiLabirint import Risanje
import time
class Node :
    def __init__(self, x, y, weigth, parent):
        self.x = x
        self.y = y
        self.weigth = weigth
        self.parent = parent

    def getParent(self):
        if self.parent != None :
            return self.parent

    def getWeight(self):
        if self.parent != None :
            return self.weigth + self.parent.getWeight()
        else :
            return self.weigth


def poisciresitev(node) :
    if node is None :
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

    zacetek = list()
    konci = list()
    # Dodamo zacetek in konce v seznam
    for i in range(len(tocke)):
        for j in range(len(tocke[0])):
            if tocke[i][j] == -2:
                zacetek.append([i, j])
            if tocke[i][j] == -3:
                konci.append([i, j])

    risar = Risanje(tocke)
    risar.t.hideturtle()
    risar.narisiLabirint()
    risar.screen.update()
    nodes = list()
    obiskani = list()
    zacetnoPreiskovanje = list()
    zacetnoPreiskovanje.append(Node(zacetek[0][0], zacetek[0][1],0, None))
    nodes.append(Node(zacetek[0][0], zacetek[0][1], 0, None))
    obiskani.append(zacetek[0])
    while True:
        zacetni = zacetnoPreiskovanje.pop()
        if [zacetni.x, zacetni.y] in konci :
            koncnekoordinate = zacetni
            break
        # Gor
        if tocke[zacetni.x - 1][zacetni.y] != -1 and [zacetni.x - 1, zacetni.y] not in obiskani:
            novnode = Node(zacetni.x -  1, zacetni.y, tocke[zacetni.x - 1][zacetni.y], zacetni)
            zacetnoPreiskovanje.insert(0, novnode)
            nodes.append(novnode)
            obiskani.append([zacetni.x - 1, zacetni.y])
            risar.narisiPot(nodes[-1].x, nodes[-1].y)

        # Dol
        if tocke[zacetni.x + 1][zacetni.y] != -1 and [zacetni.x + 1, zacetni.y] not in obiskani:
            novnode = Node(zacetni.x +  1, zacetni.y, tocke[zacetni.x + 1][zacetni.y], zacetni)
            nodes.append(novnode)
            zacetnoPreiskovanje.insert(0, novnode)
            obiskani.append([zacetni.x + 1, zacetni.y])
            risar.narisiPot(nodes[-1].x, nodes[-1].y)

        # Levo
        if tocke[zacetni.x][zacetni.y - 1] != -1 and [zacetni.x, zacetni.y - 1] not in obiskani:
            novnode = Node(zacetni.x, zacetni.y - 1, tocke[zacetni.x ][zacetni.y - 1], zacetni)
            nodes.append(novnode)
            zacetnoPreiskovanje.insert(0, novnode)
            obiskani.append([zacetni.x, zacetni.y - 1])
            risar.narisiPot(nodes[-1].x, nodes[-1].y)

        # Desno
        if tocke[zacetni.x][zacetni.y + 1] != -1 and [zacetni.x, zacetni.y + 1] not in obiskani:
            novnode = Node(zacetni.x, zacetni.y + 1, tocke[zacetni.x][zacetni.y + 1], zacetni)
            nodes.append(novnode)
            zacetnoPreiskovanje.insert(0, novnode)
            obiskani.append([zacetni.x, zacetni.y + 1])
            risar.narisiPot(nodes[-1].x, nodes[-1].y)

    global resitev1
    resitev1 = list()
    risar.narisiZacetek(zacetek[0][0], zacetek[0][1])
    for i in konci:
        risar.narisiKonce(i[0], i[1])
    poisciresitev(koncnekoordinate)
    print("Iskanje v sirino cena poti: " + str(koncnekoordinate.getWeight() + 3))
    print("Iskanje v sirino dolzina poti: " + str(len(resitev1)))
    print("Iskanje v sirino pregledanih vozlisc : " + str(len(nodes)))
    for i in resitev1[1:]:
        screen_x = -350 + (i[1] * risar.velikost)
        screen_y = 350 - (i[0] * risar.velikost)
        risar.narisiResitev(screen_x, screen_y)

    time.sleep(2)
    risar.screen.clearscreen()



