#include <stdio.h>
#include <string.h>

#define superVisorCode "2244"
int isSupervisor = 1;
int getArrow(int moreOptions);
int blinksManager();
void menuList(int cont, int value, int moreOptions);
void menu();
int main(int argc, char *argv[])
{
    char *userParameter = argv[1]; // Section flags
    if (userParameter != NULL)
    {
        int length = strlen(userParameter);
        int codeMatch = 1;
        for (int i = 0; i < length; i++)
        {
            if (superVisorCode[i] != userParameter[i])
            {
                codeMatch = 0;
                isSupervisor = 0;
            }
        }
        if (codeMatch)
            isSupervisor = 1;
    }
    menu();
}

void menu()
{
    int cont = 0;
    int limitOfMenu = 5;
    int freccia;
    int porte = 1;
    int backHome = 1;
    int lampeggio = 3;
    int pressione = 1;
    int parameterMenuList;
    int moreOption = 0;
    if (isSupervisor)
    {
        limitOfMenu = 7;
    }
    while (1)
    {
        int tmp = 0;
        menuList(cont, parameterMenuList, moreOption);
        if (moreOption && cont == 6)
        {
            tmp = blinksManager();
            if (tmp == 10)
            {
                moreOption = 0;
            }
            else
            {
                lampeggio = tmp-48;
                parameterMenuList = lampeggio;
            }
        }
        else
        {
            freccia = getArrow(moreOption);
        }
        switch (freccia)
        {
        case 65:
            freccia = 0;
            if (moreOption)
            {
                if (porte)
                {
                    porte--;
                    parameterMenuList = 0;
                }
                else if (!porte)
                {
                    porte++;
                    parameterMenuList = 1;
                }
                else if (backHome)
                {
                    backHome--;
                    parameterMenuList = 0;
                }
                else
                {
                    backHome++;
                    parameterMenuList = 1;
                }
            }
            else
            {
                if (cont == 0)
                {
                    cont = limitOfMenu;
                }
                else
                {
                    cont--;
                }
            }
            break;
        case 66:
            freccia = 0;
            if (moreOption)
            {
                if (porte)
                {
                    porte--;
                    parameterMenuList = 0;
                }
                else if (!porte)
                {
                    porte++;
                    parameterMenuList = 1;
                }
                else if (backHome)
                {
                    backHome--;
                    parameterMenuList = 0;
                }
                else
                {
                    backHome++;
                    parameterMenuList = 1;
                }
            }
            else
            {
                if (cont == limitOfMenu)
                {
                    cont = 0;
                }
                else
                {
                    cont++;
                }
            }
            break;
        case 67:
            freccia = 0;
            switch (cont)
            {
            case 3:
                moreOption = 1;
                parameterMenuList = porte;
                break;
            case 4:
                moreOption = 1;
                parameterMenuList = backHome;
                break;
            case 6:
                moreOption = 1;
                parameterMenuList = lampeggio;
                break;
            case 7:
                moreOption = 1;
                parameterMenuList = pressione;
                break;
            default:
                break;
            }
            break;
        case 10:
            freccia = 0;
            moreOption = 0;
            break;
        default:
            break;
        }
    }
}

void menuList(int cont, int value, int moreOptions)
{
    char menu1[] = "Setting automobile\0";
    char menu2[] = "Data: 26/05/2023\0";
    char menu3[] = "Ora: 14:32\0";
    char menu4[] = "Blocco automatico porte\0";
    char menu5[] = "Back-home\0";
    char menu6[] = "Check olio\0";
    char menu7[] = "Frecce direzione:\0";
    char menu8[] = "Reset pressione gomme\0";
    char pressione[] = "Pressione gomme resettata\0";
    char ON[] = "ON\0";
    char OFF[] = "OFF\0";

    switch (cont)
    {
    case 0:
        printf("%s\n", menu1);
        break;
    case 1:
        printf("%s\n", menu2);
        break;
    case 2:
        printf("%s\n", menu3);
        break;
    case 3:
        printf("%s", menu4);
        if (moreOptions)
        {
            if (value)
            {
                printf(" %s\n", ON);
            }
            else
            {
                printf(" %s\n", OFF);
            }
        }
        else
        {
            printf("\n");
        }
        break;
    case 4:
        printf("%s", menu5);
        if (moreOptions)
        {
            if (value)
            {
                printf(" %s\n", ON);
            }
            else
            {
                printf(" %s\n", OFF);
            }
        }
        else
        {
            printf("\n");
        }
        break;
    case 5:
        printf("%s\n", menu6);
        break;
    case 6:
        printf("%s", menu7);
        if (moreOptions)
        {
            printf("%d\n", value);
        }
        else
        {
            printf("\n");
        }
        break;
    case 7:
        if (moreOptions)
        {
            printf("%s\n", pressione);
        }
        else
        {
            printf("%s\n", menu8);
        }

        break;
    default:
        break;
    }
}

int getArrow(int moreOptions)
{
    int validChar = 0;
    while (validChar == 0)
    {
        validChar = 1;
        char ch;
        ch = getchar();
        if (ch == '\e')
        {   
            ch = getchar();
            int ascii = (int)ch;
            if (ascii == 91)
            {
                ch = getchar();
                ascii = (int)ch;
                if (ascii >= 65 && ascii <= 67)
                {

                    int tmp = ascii;
                    ch = getchar();
                     ascii = (int)ch;
                    if (ascii == 10)
                    {
                        return tmp;
                    }else{
                        validChar = 0;
                    }
                }else{
                    ch = getchar();
                    validChar = 0;
                }
                
            }
            
        }
        else if (moreOptions && ch == '\n'){
            return (int)(ch);
        }else{
            validChar = 0;
        }
    }
    return 0;
}

int blinksManager(){
    int ascii;
    char invio;
    int isValid = 1;
    do
    {
        isValid = 1;
        char input;
        scanf("%c",&input);
        ascii = (int)(input);
        if (ascii > 57 || (ascii < 48 && ascii != 10))
        {
            isValid = 0;
            char tmp;
            do
            {
                scanf("%c",&tmp);
            } while (tmp != '\n');
        }
        
    } while (isValid == 0);
    if (ascii < 50 && ascii != 10)
    {        
        ascii = 50;
    }else if (ascii > 53)
    {
        ascii = 53;
    }if (ascii != 10)
    {
        scanf("%c",&invio);
    }
    
    
    return ascii;
}