---
title: "Tableaux de variables"
abstract: "La mémorisation de la séquence de notes jouées par le jeu Simon est réalisée grâce à l'utilisation d'un tableau de variables."
duration: "3h"
---

!!! info
    On rappelle ici que le jeu répète la même couleur et le même son, puis ajoute au hasard une nouvelle couleur. Il faut donc que le jeu "garde en mémoire" la séquence qu'il joue pour la rejouer au prochain tour et ajouter une note. Cette séquence peut être stockée dans un tableau (Array en anglais) contenant des variables (de type **int**).

    !!! consigne
        Lire la documentation sur les tableaux [http://www.mon-club-elec.fr/pmwiki_reference_arduino/pmwiki.php?n=Main.Tableaux](http://www.mon-club-elec.fr/pmwiki_reference_arduino/pmwiki.php?n=Main.Tableaux)

    !!! consigne
        Tester les différents exemples sur les tableaux.

    !!! consigne
        Réaliser l'algorithme correspondant à la boucle **for** ci dessous :

    ![Boucle_For](Boucle_For.png)

## Jeu Simon

!!! info
    Dans notre dernier programme nous allons insérer un tableau représentant la séquence de notes :

    ![image3](image3.png)

    Après la fonction loop on rajoute une fonction permettant d'ajouter une note à la séquence :

    ![image4](image4.png)

    Et une fonction permettant de jouer la séquence :

    ![image5](image5.png)

    !!! consigne
        Réaliser l'algorithme de la fonction **Simon_Play()**

    <!-- zone: 20 -->
