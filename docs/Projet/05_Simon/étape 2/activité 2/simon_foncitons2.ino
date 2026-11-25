
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

// Fonction loop() fastidieuse !
void loop()
{
  int bouton_saisi = 0;
  while(bouton_saisi == 0)
  {
    int etat_bouton = digitalRead(BP1);
    delay(100);
    if(etat_bouton == 1)
    {
      bouton_saisi = 1;
      while(etat_bouton==1)
      {
        etat_bouton = digitalRead(BP1);
        delay(100);
      }
    }
    etat_bouton = digitalRead(BP2);
    delay(100);
    if(etat_bouton == 1)
    {
      bouton_saisi = 2;
      while(etat_bouton==1)
      {
          etat_bouton = digitalRead(BP2);
          delay(100);
      }
    }
    etat_bouton = digitalRead(BP3);
    delay(100);
    if(etat_bouton == 1)
    {
      bouton_saisi = 3;
      while(etat_bouton==1)
      {
        etat_bouton = digitalRead(BP3);
        delay(100);
      }
    }
    etat_bouton = digitalRead(BP4);
    delay(100);
    if(etat_bouton == 1)
    {
      bouton_saisi = 4;
      while(etat_bouton==1)
      {
        etat_bouton = digitalRead(BP4);
        delay(100);
      }
    }
  }
  Serial.println(bouton_saisi);
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

