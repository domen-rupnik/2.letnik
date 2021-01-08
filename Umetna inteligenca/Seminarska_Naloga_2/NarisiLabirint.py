import turtle
import time

class Risanje :
    def __init__(self, file):
        self.screen = turtle.Screen()
        self.t = turtle.Turtle()
        self.t.hideturtle()
        self.t._tracer(0)
        self.file = file
        self.visina = len(file)
        self.sirina = len(file[0])
        self.screen.screensize(700, 700)
        self.velikost = int(700 / self.sirina)

    def narisi_kvadart(self,x,y) :
        self.t.penup()
        self.t.goto(x,y)
        self.t.pendown()
        self.t.begin_fill()
        for i in range(4) :
            self.t.forward(self.velikost)
            self.t.right(90)
        self.t.end_fill()

    def narisiLabirint(self) :
        self.t._tracer(0)
        for i in range(len(self.file)):
            for j in range(len(self.file[i])) :
                character = self.file[i][j]

                screen_x = -350 + (j * self.velikost)
                screen_y = 350 - (i * self.velikost)

                if character == -1 :
                    self.t.fillcolor("black")
                    self.narisi_kvadart(screen_x, screen_y)
                elif character == -2 :
                    self.t.fillcolor("yellow")
                    self.narisi_kvadart(screen_x, screen_y)
                elif character == -3 :
                    self.t.fillcolor("red")
                    self.narisi_kvadart(screen_x, screen_y)
                else :
                    self.t.fillcolor("white")
                    self.narisi_kvadart(screen_x, screen_y)


    def narisiPot(self, x, y) :
        screen_x = -350 + (y * self.velikost)
        screen_y = 350 - (x * self.velikost)
        self.t.fillcolor("blue")
        self.narisi_kvadart(screen_x, screen_y)
        self.screen.update()
    def iskanje(self, x, y) :
        screen_x = -350 + (y * self.velikost)
        screen_y = 350 - (x * self.velikost)
        self.t.fillcolor("pink")
        self.narisi_kvadart(screen_x, screen_y)
        self.screen.update()

    def narisiKonec(self, x, y) :
        self.screen.update()
        screen_x = -350 + (y * self.velikost)
        screen_y = 350 - (x * self.velikost)
        self.t.fillcolor("red")
        self.narisi_kvadart(screen_x, screen_y)
    def narisiResitev(self, x, y):
        self.screen.update()
        self.t.fillcolor("green")
        self.narisi_kvadart(x, y)
    def narisiZacetek(self, x, y):
        self.screen.update()
        screen_x = -350 + (y * self.velikost)
        screen_y = 350 - (x * self.velikost)
        self.t.fillcolor("yellow")
        self.narisi_kvadart(screen_x, screen_y)

    def narisiKonce(self, x, y):
        self.screen.update()
        screen_x = -350 + (y * self.velikost)
        screen_y = 350 - (x * self.velikost)
        self.t.fillcolor("red")
        self.narisi_kvadart(screen_x, screen_y)
