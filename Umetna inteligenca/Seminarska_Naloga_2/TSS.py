from NarisiLabirint import Risanje
import time
class Node :
    def __init__(self, x, y, parent, weigth):
        self.x = x
        self.y = y
        self.parent = parent
        self.weigth = weigth

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


def poisciresitev2(node) :
    if node is None :
        return
    resitev2.append([node.x, node.y])
    poisciresitev2(node.getParent())


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
    obiskanizacetki = list()
    zacetnoPreiskovanje = list()
    koncnoPreiskovanje = list()
    zacetnoPreiskovanje.append(Node(zacetek[0][0], zacetek[0][1], None, tocke[zacetek[0][0]][zacetek[0][1]]))
    nodes.append(Node(zacetek[0][0], zacetek[0][1], None, tocke[zacetek[0][0]][zacetek[0][1]]))
    obiskanizacetki.append(zacetek[0])
    for i in konci:
        koncnoPreiskovanje.append([Node(i[0], i[1], None, tocke[i[0]][i[1]])])
        nodes.append(Node(i[0], i[1], None, tocke[i[0]][i[1]]))
        obiskani.append([i[0], i[1]])
    koncnekoordinate = 0
    while True:
        zacetni = zacetnoPreiskovanje.pop()
        # Gor
        if tocke[zacetni.x - 1][zacetni.y] != -1 and [zacetni.x - 1, zacetni.y] not in obiskanizacetki:
            novnode = Node(zacetni.x -  1, zacetni.y, zacetni, tocke[zacetni.x -1][zacetni.x])
            zacetnoPreiskovanje.insert(0, novnode)
            nodes.append(novnode)
            obiskanizacetki.append([zacetni.x - 1, zacetni.y])
            risar.narisiPot(nodes[-1].x, nodes[-1].y)

        # Dol
        if tocke[zacetni.x + 1][zacetni.y] != -1 and [zacetni.x + 1, zacetni.y] not in obiskanizacetki:
            novnode = Node(zacetni.x +  1, zacetni.y, zacetni, tocke[zacetni.x + 1][zacetni.y])
            nodes.append(novnode)
            zacetnoPreiskovanje.insert(0, novnode)
            obiskanizacetki.append([zacetni.x + 1, zacetni.y])
            risar.narisiPot(nodes[-1].x, nodes[-1].y)

        # Levo
        if tocke[zacetni.x][zacetni.y - 1] != -1 and [zacetni.x, zacetni.y - 1] not in obiskanizacetki:
            novnode = Node(zacetni.x, zacetni.y - 1, zacetni, tocke[zacetni.x][zacetni.y - 1])
            nodes.append(novnode)
            zacetnoPreiskovanje.insert(0, novnode)
            obiskanizacetki.append([zacetni.x, zacetni.y - 1])
            risar.narisiPot(nodes[-1].x, nodes[-1].y)

        # Desno
        if tocke[zacetni.x][zacetni.y + 1] != -1 and [zacetni.x, zacetni.y + 1] not in obiskanizacetki:
            novnode = Node(zacetni.x, zacetni.y + 1, zacetni, tocke[zacetni.x][zacetni.y + 1])
            nodes.append(novnode)
            zacetnoPreiskovanje.insert(0, novnode)
            obiskanizacetki.append([zacetni.x, zacetni.y + 1])
            risar.narisiPot(nodes[-1].x, nodes[-1].y)
        st = 0
        for i in koncnoPreiskovanje :
            if len(i) == 0:
                st += 1
                continue
            konec = i[-1]
            koncnoPreiskovanje[st].pop()

            # Gor
            if tocke[konec.x - 1][konec.y] != -1 and [konec.x - 1, konec.y] not in obiskani :
                novnode = Node(konec.x - 1, konec.y, konec, tocke[konec.x - 1][konec.y])
                nodes.append(novnode)
                koncnoPreiskovanje[st].insert(0, novnode)
                obiskani.append([konec.x - 1, konec.y])
                risar.narisiPot(nodes[-1].x, nodes[-1].y)
            # Dol
            if tocke[konec.x + 1][konec.y] != -1 and [konec.x + 1, konec.y] not in obiskani:
                novnode = Node(konec.x + 1, konec.y, konec, tocke[konec.x + 1][konec.y])
                nodes.append(novnode)
                koncnoPreiskovanje[st].insert(0, novnode)
                obiskani.append([konec.x + 1, konec.y])
                risar.narisiPot(nodes[-1].x, nodes[-1].y)
            # Levo
            if tocke[konec.x][konec.y - 1] != -1 and [konec.x, konec.y - 1] not in obiskani:
                novnode = Node(konec.x, konec.y - 1, konec, tocke[konec.x][konec.y - 1])
                nodes.append(novnode)
                koncnoPreiskovanje[st].insert(0, novnode)
                obiskani.append([konec.x, konec.y - 1])
                risar.narisiPot(nodes[-1].x, nodes[-1].y)
            # Desno
            if tocke[konec.x][konec.y + 1] != -1 and [konec.x, konec.y + 1] not in obiskani:
                novnode = Node(konec.x, konec.y + 1, konec, tocke[konec.x][konec.y + 1])
                nodes.append(novnode)
                koncnoPreiskovanje[st].insert(0, novnode)
                obiskani.append([konec.x, konec.y + 1])
                risar.narisiPot(nodes[-1].x, nodes[-1].y)
            st += 1
        end = False
        for i in obiskanizacetki:
            if i in obiskani:
                end = True
                koncnekoordinate = i
                break

        if end:
            break
    global resitev1
    global resitev2
    resitev1 = list()
    resitev2 = list()
    risar.narisiZacetek(zacetek[0][0], zacetek[0][1])
    for i in konci:
        risar.narisiKonce(i[0], i[1])
    liste = list()
    for i in nodes:
        if [i.x, i.y] == koncnekoordinate:
            liste.append(i)
    poisciresitev(liste[1])
    poisciresitev2(liste[0])
    print("Preiskovanje z dveh strani cena poti: " + str(liste[0].getWeight() + liste[1].getWeight() + 5))
    print("Preiskovanje z dveh strani dolzina poti: " + str(len(resitev1) + len(resitev2) - 1))
    print("Preiskovanje z dveh strani pregledanih vozlisc: " + str(len(nodes)))
    for i in resitev1[1:]:
        screen_x = -350 + (i[1] * risar.velikost)
        screen_y = 350 - (i[0] * risar.velikost)
        risar.narisiResitev(screen_x, screen_y)
    for i in resitev2:
        screen_x = -350 + (i[1] * risar.velikost)
        screen_y = 350 - (i[0] * risar.velikost)
        risar.narisiResitev(screen_x, screen_y)

    time.sleep(2)
    risar.screen.clearscreen()





