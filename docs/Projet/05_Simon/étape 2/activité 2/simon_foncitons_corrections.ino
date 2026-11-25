
// Definitions des broches connectees aux LED
const int LED1 = 2;
const int LED2 = 3;
const int LED3 = 4;
const int LED4 = 5;

// Definition des broche connectees aux BP
const int BP1 = 6;
const int BP2 = 7;
const int BP3 = 8;
const int BP4 = 9;


void setup()
{
  pinMode(LED1, OUTPUT);
  pinMode(LED2, OUTPUT);
  pinMode(LED3, OUTPUT);
  pinMode(LED4, OUTPUT);

  pinMode(BP1, INPUT);
  pinMode(BP2, INPUT);
  pinMode(BP3, INPUT);
  pinMode(BP4, INPUT);

  Serial.begin(9600);
}

// Fonction loop() 
void loop()
{
  int bouton_saisi = Scan_Bouton();
  Serial.println(bouton_saisi);
}

int Scan_Bouton(void)
{
  int bouton_saisi = 0;
  while (bouton_saisi == 0)
  {

    if (Bouton_Test(BP1))        // Apppel de la fonction Bouton_Test
    { // / BP1 : parametre d'entree
      bouton_saisi = 1;
    }
    if (Bouton_Test(BP2))        // Apppel de la fonction Bouton_Test
    { // / BP2 : parametre d'entree
      bouton_saisi = 2;
    }
    if (Bouton_Test(BP3))        // Apppel de la fonction Bouton_Test
    { // / BP3 : parametre d'entree
      bouton_saisi = 3;
    }
    if (Bouton_Test(BP4))        // Apppel de la fonction Bouton_Test
    { // / BP4 : parametre d'entree
      bouton_saisi = 4;
    }

  }
  return bouton_saisi;
}
/*

   Bouton_Test(BP) renvoie :
   1 si appui
   0 sinon
   La fonction retourne une valeur de type int: 0 ou 1
*/
int Bouton_Test(int BP) // BP : parametre d'entree
{
  int etat_bouton = digitalRead(BP);
  delay(100);
  if (etat_bouton == 1)
  {
    while (etat_bouton == 1)
    {
      etat_bouton = digitalRead(BP);
      delay(100);
    }
    return 1; // Retourne la valeur 1 si appui
  }
  else
  {
    return 0; // Retourne la valeur 0 si non appui
  }
}















// Fonction permettant l'extinction de toutes les LEDs
void Eteindre_LED(void)
{
  digitalWrite(LED1, LOW);
  digitalWrite(LED2, LOW);
  digitalWrite(LED3, LOW);
  digitalWrite(LED4, LOW);
}

// Fonction permettant d'allumer toutes les LEDS
void Allumer_LED(void)
{
  digitalWrite(LED1, HIGH);
  digitalWrite(LED2, HIGH);
  digitalWrite(LED3, HIGH);
  digitalWrite(LED4, HIGH);
}

