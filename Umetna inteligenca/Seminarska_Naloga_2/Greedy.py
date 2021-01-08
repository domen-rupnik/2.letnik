from NarisiLabirint import Risanje
import random
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
    resitev.insert(0, [node.x, node.y])
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
    obiskani = list()
    trenutni = list()
    nodes.append(Node(zacetek[0][0], zacetek[0][1], None, 0))
    trenutni = nodes[0]
    obiskani.append([zacetek[0][0], zacetek[0][1]])
    obetavni = list()
    while True :
        if [trenutni.x, trenutni.y] in konci:
            koncniNode = trenutni
            break
        naslednji = list()
        # Gor
        if tocke[trenutni.x - 1][trenutni.y] != -1 and [trenutni.x - 1, trenutni.y] not in obiskani:
            novnode = Node(trenutni.x - 1, trenutni.y, trenutni, tocke[trenutni.x - 1][trenutni.y])
            naslednji.append([novnode.weigth, novnode])
            nodes.append(novnode)
            obiskani.append([trenutni.x - 1, trenutni.y])
            risar.narisiPot(obiskani[-1][0], obiskani[-1][1])
        # Levo
        if tocke[trenutni.x][trenutni.y - 1] != -1 and [trenutni.x, trenutni.y - 1] not in obiskani:
            novnode = Node(trenutni.x, trenutni.y - 1, trenutni, tocke[trenutni.x][trenutni.y - 1])
            naslednji.append([novnode.weigth, novnode])
            nodes.append(novnode)
            obiskani.append([trenutni.x, trenutni.y - 1])
            risar.narisiPot(obiskani[-1][0], obiskani[-1][1])
        # Desno
        if tocke[trenutni.x][trenutni.y + 1] != -1 and [trenutni.x, trenutni.y + 1] not in obiskani:
            novnode = Node(trenutni.x, trenutni.y + 1, trenutni, tocke[trenutni.x][trenutni.y + 1])
            naslednji.append([novnode.weigth, novnode])
            nodes.append(novnode)
            obiskani.append([trenutni.x, trenutni.y + 1])
            risar.narisiPot(obiskani[-1][0], obiskani[-1][1])
        # Dol
        if tocke[trenutni.x + 1][trenutni.y] != -1 and [trenutni.x + 1, trenutni.y] not in obiskani:
            novnode = Node(trenutni.x + 1, trenutni.y, trenutni, tocke[trenutni.x + 1][trenutni.y])
            naslednji.append([novnode.weigth, novnode])
            nodes.append(novnode)
            obiskani.append([trenutni.x + 1, trenutni.y])
            risar.narisiPot(obiskani[-1][0], obiskani[-1][1])
        # Razvrstimo glede na hevristiko
        naslednji = sorted(naslednji, key=lambda naslednji: naslednji[0])
        # Dodamo vse tocke v obetavne, ker jih bomo uporabili, ce bomo prisli do slepe ulice
        if len(naslednji) > 0:
            for i in naslednji:
                obetavni.append(i[1])
            najmanjsi = list()
            najmanjsiii = naslednji[0]

            for i in naslednji:
                if i[0] <= najmanjsiii[0]:
                    najmanjsi.append(i[1])

            trenutni = random.choice(najmanjsi)
            # Iz obetavnih odstranimo tocko, katero trenutno uporabljamo
            for i in obetavni:
                if [i.x, i.y] == [trenutni.x, trenutni.y]:
                    obetavni.remove(i)
                    break
        else:
            trenutni = obetavni[-1]
            obetavni.pop()

    global resitev
    resitev = list()
    poisciresitev(koncniNode)

    risar.narisiZacetek(zacetek[0][0], zacetek[0][1])
    for i in konci:
        risar.narisiKonce(i[0], i[1])
    for i in resitev[1:]:
        time.sleep(0.1)
        screen_x = -350 + (i[1] * risar.velikost)
        screen_y = 350 - (i[0] * risar.velikost)
        risar.narisiResitev(screen_x, screen_y)
    print("Pozresno preiskovanje glede na najblizjo tocko cena poti: " + str(koncniNode.getWeight()))
    print("Pozresno preiskovanje glede na najblizjo tocko dolzina poti: " + str(len(resitev) - 1))
    print("Pozresno preiskovanje glede na najblizjo tocko pregledanih vozlisc: " + str(len(nodes)))

    time.sleep(2)
    risar.screen.clearscreen()
