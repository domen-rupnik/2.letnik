import DFS, BFS, IDS, AStar, Dijkstra, TSS, Greedy, GreedyHeuristics
import os
import time
import turtle



for i in os.listdir("./labyrinths/") :
    """
    bfs = BFS.main("./labyrinths/" + i)
    print("---")
    ids = IDS.main("./labyrinths/" + i)
    print("---")
    dfs = DFS.main("./labyrinths/" + i)
    print("---")
    tss = TSS.main("./labyrinths/" + i)
    print("---")
    """
    ast = AStar.main("./labyrinths/" + i)
    print("---")
    """
    dijkstra = Dijkstra.main("./labyrinths/" + i)
    print("---")
    greedy = Greedy.main("./labyrinths/" + i)
    print("---")
    greedyHeuristics = GreedyHeuristics.main("./labyrinths/" + i)
    print("###########################################################################")
    """


def eden(i):
    bfs = BFS.main("./labyrinths/" + i)
    print("---")
    ids = IDS.main("./labyrinths/" + i)
    print("---")
    dfs = DFS.main("./labyrinths/" + i)
    print("---")
    tss = TSS.main("./labyrinths/" + i)
    print("---")
    ast = AStar.main("./labyrinths/" + i)
    print("---")
    dijkstra = Dijkstra.main("./labyrinths/" + i)
    print("---")
    greedy = Greedy.main("./labyrinths/" + i)
    print("---")
    greedyHeuristics = GreedyHeuristics.main("./labyrinths/" + i)
    print("###########################################################################")

#eden("labyrinth_12.txt")

