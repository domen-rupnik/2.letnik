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
    konec = False
    obiskani = list()  # x,y kooridnate ze obiskanih tock
    nodes = list()
    nodes.append(Node(zacetek[0][0], zacetek[0][1], None, 0))
    obiskani.append([zacetek[0][0], zacetek[0][1]])
    while True :
        zadnji = nodes[-1]
        obiskani.append([zadnji.x, zadnji.y])
        risar.narisiPot(zadnji.x, zadnji.y)
        if [zadnji.x, zadnji.y] in konci :
            koncniNode = zadnji
            break
#Gor
        if tocke[zadnji.x - 1][zadnji.y] != -1 and  [zadnji.x - 1, zadnji.y] not in obiskani :
            nodes.append(Node(zadnji.x - 1, zadnji.y, zadnji, tocke[zadnji.x - 1][zadnji.y]))

#Levo
        elif tocke[zadnji.x][zadnji.y - 1] != -1 and  [zadnji.x, zadnji.y - 1] not in obiskani :
            #obiskani.append([zadnji.x, zadnji.y - 1])
            nodes.append(Node(zadnji.x, zadnji.y - 1, zadnji, tocke[zadnji.x][zadnji.y - 1]))
#Desno
        elif tocke[zadnji.x][zadnji.y + 1] != -1  and [zadnji.x, zadnji.y + 1] not in obiskani :
            #obiskani.append([zadnji.x, zadnji.y + 1])
            nodes.append(Node(zadnji.x, zadnji.y + 1, zadnji, tocke[zadnji.x][zadnji.y + 1]))
#Dol
        elif tocke[zadnji.x + 1][zadnji.y] != -1 and [zadnji.x + 1, zadnji.y] not in obiskani :
            #obiskani.append([zadnji.x + 1, zadnji.y])
            nodes.append(Node(zadnji.x + 1, zadnji.y, zadnji, tocke[zadnji.x + 1][zadnji.x]))
        # Ce ne moremo v nobeno smer, ali smo na maksimalni globini se vracamo nazaj po skladu
        else:
            nodes.pop()

    global resitev1
    resitev1 = list()
    risar.narisiZacetek(zacetek[0][0], zacetek[0][1])
    for i in konci:
        risar.narisiKonce(i[0], i[1])
    poisciresitev(koncniNode)
    print("Iskanje v globino cena poti: " + str(koncniNode.getWeight() + 3))
    print("Iskanje v globino dolzina poti: " + str(len(resitev1)))
    print("Iskanje v globino pregledanih vozlisc : " + str(len(obiskani)))
    for i in resitev1[1:]:
        screen_x = -350 + (i[1] * risar.velikost)
        screen_y = 350 - (i[0] * risar.velikost)
        risar.narisiResitev(screen_x, screen_y)
    time.sleep(2)
    risar.screen.clearscreen()


