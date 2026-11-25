
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
}


void loop()
{
  Allumer_LED(); // Appel de la fonction Allumer_LED()
  delay(500);
  Eteindre_LED(); // Appel de la fonction Eteindre_LED()
  delay(500);
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

