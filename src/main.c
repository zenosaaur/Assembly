#include <stdio.h>
#include <string.h>
#include <termios.h>


#define superVisorCode "2244"
// funzione per pulire il terminale
#define clrscr() printf("\e[1;1H\e[2J")

//TODO: Approfondire argomento
int getch() {
    int ch;
    // struct to hold the terminal settings
    struct termios old_settings, new_settings;
    // take default setting in old_settings
    tcgetattr(0, &old_settings);
    // make of copy of it (Read my previous blog to know 
    // more about how to copy struct)
    new_settings = old_settings;
    // change the settings for by disabling ECHO mode
    // read man page of termios.h for more settings info
    new_settings.c_lflag &= ~(ICANON | ECHO);
    // apply these new settings
    tcsetattr(0, TCSANOW, &new_settings);
    // now take the input in this mode
    ch = getchar();
    // reset back to default settings
    tcsetattr(0, TCSANOW, &old_settings);
    return ch;
}

int main(int argc, char *argv[])
{
    // primo passo prendere da riga di comando
    // l'argoment user/superVisor(2244)
    char *userParameter = argv[1];
    int isSuperVisor = 0;
    // Counter del menu
    int menuCounter = 0;
    // array delle voci del menu
    char* menuString[6] = {"Setting automobile:", "Data:", "Ora:","Blocco automatico porte:","Back-home:","Check olio"};
    // TODO: funzione in Assembly che preso in input due stringhe e le compara
    if (userParameter != NULL)
    {
        int length = strlen(userParameter);
        int codeMatch = 1;
        for (int i = 0; i < length; i++)
        {
            if (superVisorCode[i] != userParameter[i])
            {
                codeMatch = 0;
                isSuperVisor = 0;
            }
        }
        if (codeMatch)
            isSuperVisor = 1;
    }
    while (1)
    {
        if (getch() == '\033')
        {   
            getch();
            switch (getch())
            {
            case 'A':
                clrscr();
                menuCounter > 0 ? menuCounter-- : menuCounter;
                printf("%s\n",menuString[menuCounter]); 
                break;
            case 'B':
                clrscr();
                menuCounter < 5  ? menuCounter++ : menuCounter;
                printf("%s\n",menuString[menuCounter]); 
                break;
            case 'C':
                printf("freccia in destra\n");
                break;
            case 'D':
                printf("freccia in sinistra\n");
                break;
            }
        }else if (getch() == 'q')
        {
            break;
        }
        
    }

    return 0;
}