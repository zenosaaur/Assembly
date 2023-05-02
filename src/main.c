#include <stdio.h>
#include <string.h>
#include <termios.h>
#include <time.h>

#define superVisorCode "2244"
// funzione per pulire il terminale
#define clrscr() printf("\e[1;1H\e[2J")

// TODO: Approfondire argomento
int getch()
{
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
    char *userParameter = argv[1]; // Section flags
    int isSuperVisor = 0;
    int porte = 1;
    int backHome = 1;
    int moreDetails = 0;
    // Counter del menu
    int menuCounter = 0;
    // array delle voci del menu
    char *menuString[6] = {"Setting automobile:", "Data:", "Ora:", "Blocco automatico porte:", "Back-home:", "Check olio"};
    // Genero struct contenente la data di oggi
    time_t t = time(NULL);
    struct tm tm = *localtime(&t);
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
        // flag che serve per modificare l'impostazione
        // 0 no modifiche 1 modifiche
        int modify = 0;
        if (getch() == '\033')
        {
            getch();
            switch (getch())
            {
            case 'A':
                clrscr();
                if (!moreDetails)
                {
                    menuCounter > 0 ? menuCounter-- : menuCounter;
                }else{
                    modify = 1;
                }

                break;
            case 'B':
                clrscr();
                if (!moreDetails)
                {
                    menuCounter < 5 ? menuCounter++ : menuCounter;
                }else{
                    modify = 1;
                }
                break;
            case 'C':
                clrscr();
                if (menuCounter == 3 || menuCounter == 4)
                {   
                    moreDetails = 1;
                }
                break;
            case 'D':
                clrscr();
                if (menuCounter == 3 || menuCounter == 4)
                {   
                    moreDetails = 0;
                }
                break;
            }
            switch (menuCounter)
            {
            case 0:
                printf("%d: %s ", menuCounter, menuString[menuCounter]);
                if (isSuperVisor)
                {
                    printf("(supervisor)\n");
                }
                else
                {
                    printf("\n");
                }

                break;
            case 1:
                printf("%d: %s ", menuCounter, menuString[menuCounter]);
                printf("%02d-%02d-%02d\n", tm.tm_mday, tm.tm_mon + 1, tm.tm_year + 1900);
                break;
            case 2:
                printf("%d: %s ", menuCounter, menuString[menuCounter]);
                printf("%02d:%02d:%02d\n", tm.tm_hour, tm.tm_min, tm.tm_sec);
                break;
            case 3:
                if (moreDetails)
                {
                    if (modify)
                    {
                        porte = !porte;
                    }
                    
                    printf("%s (modifica) ",menuString[menuCounter]);
                    if (porte)
                    {
                        printf("ON\n");
                    }else
                    {
                        printf("OFF\n");
                    }
                    
                    
                }
                else
                {
                    printf("%d: %s ", menuCounter, menuString[menuCounter]);
                    if (porte)
                    {
                        printf("ON\n");
                    }
                    else
                    {
                        printf("OFF\n");
                    }
                }

                break;
            case 4:
                printf("%d: %s ", menuCounter, menuString[menuCounter]);
                if (backHome)
                {
                    printf("ON\n");
                }
                else
                {
                    printf("OFF\n");
                }
                break;
            case 5:
                printf("%d: %s\n", menuCounter, menuString[menuCounter]);
                break;
            }
        }
        else if (getch() == 'q')
        {
            break;
        }
    }

    return 0;
}