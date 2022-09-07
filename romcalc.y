%{
# include <stdio.h>
# include <stdlib.h>
# include <string.h>
int yylex();
void yyerror(const char *s);
void intToRoman();
%}

%token THOUSAND FIVEHUNDRED HUNDRED FIFTY TEN FIVE ONE
%token EOL
%token ADD SUB MUL DIV
%token lparenthesis rparenthesis

%%

calclist:
  | calclist exp EOL { intToRoman($2); printf("\nEnter a calculation:\n"); }
  ;

exp: factor
  | exp ADD factor { $$ = $1 + $3; }
  | exp SUB factor { $$ = $1 - $3; }
  ;

factor: parenthesis
  | factor MUL term { $$ = $1 * $3; }
  | factor DIV term { $$ = $1 / $3; }
  ;

parenthesis: term
  | lparenthesis exp rparenthesis { $$ = $2; }
  ;

term: ones
  | term ones  { $$ = $1 + $2; }                                //recursive call to sum all values passed upwards
  ;

ones: tens
    | ONE                 { $$ = 1; }
    | ONE FIVE            { $$ = 4; }
    | ONE TEN             { $$ = 9; }
    | ONE FIFTY           { $$ = 49; }
    | ONE HUNDRED         { $$ = 99; }
    | ONE FIVEHUNDRED     { $$ = 499; }
    | ONE THOUSAND        { $$ = 999; }
    | FIVE                { $$ = 5; }
    ;

tens: hundreds
    | TEN                 { $$ = 10; }
    | TEN FIFTY           { $$ = 40; }
    | TEN HUNDRED         { $$ = 90; }
    | TEN THOUSAND        { $$ = 990; }
    | FIFTY               { $$ = 50; }
    ;

hundreds: thousands
    | HUNDRED                     { $$ = 100; }
    | HUNDRED FIVEHUNDRED         { $$ = 400; }
    | HUNDRED THOUSAND            { $$ = 900; }
    | FIVEHUNDRED                 { $$ = 500; }
    ;

thousands:
    | THOUSAND            { $$ = 1000; }
    ;

%%

void intToRoman(int value)
{
  char result[150] = "";                                  //initialised null string for result
  char thousand[1] = "M";
  char fivehundred[1] = "D";
  char hundred[1] = "C";
  char fifty[1] = "L";
  char ten[1] = "X";
  char five[1] = "V";
  char one[1] = "I";
  char zero[1] = "Z";

  if (value == 0){
    strncat(result, zero, 1);
    printf("%s\n", result);
  }
  else if (value < 0){
    int positive_value = abs(value);
    printf("-");
    return intToRoman(positive_value);
  }
                                                                                                        
  while(value >= 1000){                                  //repeated subtraction to 0 while appending          
    value = value - 1000;                                //appropriate roman numeral char to string result 
    strncat(result, thousand, 1);
  }
  while(value >= 500){
    if (value >= 900){                                   //case where numeral has to be written as one unit less than the next symbol e.g 900 = CM
      strncat(result, hundred, 1);                       //if (900 <= value <= 1000){
      strncat(result, thousand, 1);                      //   hardcode appropriate symbol for 900
      value = value - 900;                               //   subtract symbol value
      break;                                             //   break out of while loop for next while comparison
    }                                                    //}
    value = value - 500;
    strncat(result, fivehundred, 1);
  }
  while(value >= 100){
    if (value >= 400){                                   // ""
      strncat(result, hundred, 1);
      strncat(result, fivehundred, 1);
      value = value - 400;
      break;
    }
    value = value - 100;
    strncat(result, hundred, 1);
  }
  while(value >= 50){
    if (value >= 90){
      strncat(result, ten, 1);
      strncat(result, hundred, 1);
      value = value - 90;
      break;
    }
    value = value - 50;
    strncat(result, fifty, 1);
  }
  while(value >= 10){
    if (value >= 40){
      strncat(result, ten, 1);
      strncat(result, fifty, 1);
      value = value - 40;
      break;
    }
    value = value - 10;
    strncat(result, ten, 1);
  }
  while(value >= 5){
    if (value == 9){
      strncat(result, one, 1);
      strncat(result, ten, 1);
      value = 0;
      break;
    }
    value = value - 5;
    strncat(result, five, 1);
  }
  while(value >= 1){
    if (value == 4){
      strncat(result, one, 1);
      strncat(result, five, 1);
      value = 0;
      break;
    }
    value = value - 1;
    strncat(result, one, 1);
  }
  printf("%s\n", result);
}


int main()
{
  printf("Enter a calculation:\n");
  yyparse();
  return 0;
}

void yyerror(const char *s)
{
  printf("Error: %s\n", s);
}
