#include <stdio.h>
#include <string.h>
#include <termios.h>


#define superVisorCode "2244"


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
                printf("freccia in su\n");
                break;
            case 'B':
                printf("freccia in giu\n");
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