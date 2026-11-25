---
title: "Analyse et réalisation du jeu Simon"
abstract: "Mise en œuvre des 4 LEDs et 4 Boutons poussoirs dans le but d'assembler les composants électroniques essentiels du jeu Simon."
duration: "2h"
organisation: "Activité en binôme ou seul."
materials: "1 PC avec Arduino IDE | Carte Arduino UNO | 4 LED (rouge, jaune, verte, bleu) | 4 BP | 4 Résistances 560Ω | 4 Résistances 10kΩ | BreadBoard et cables"
---

!!! info
    **Analyse du****schéma structurel :**

    D'après le schéma structurel ci après, répondre aux questions suivantes :

    !!! consigne
        Quelles  broches doivent être configurées en entrée ? justifier.

    <!-- zone: 4 -->

    !!! consigne
        Quelles  broches doivent être configurées en sortie ? justifier.

    <!-- zone: 4 -->

    ![Simon_2.SVG](Simon_2.SVG.png)

!!! info
    **Câblage :**

    !!! consigne
        Compléter le câblage des composants ci-dessous

    ![Simon_LED_BP_bb](Simon_LED_BP_bb.png)

!!! info
    **Programmation** : L'objectif est ici de tester le câblage des composants ci-dessus :

    !!! consigne
        **Test des LEDS :**

        - Réaliser un programme Arduino permettant, toutes les 500ms, de faire clignoter les 4 LED.
