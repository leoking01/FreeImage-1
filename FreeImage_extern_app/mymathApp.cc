#include <iostream>

#include "freeimage.h"
//#include "minus_opera.h"

//using namespace std;

int main(int argc, char const *argv[])
{
//    double a = add(1.1, 1.1);
     const char * Version = FreeImage_GetVersion( );
    std:: cout << "Version = " << Version <<std:: endl;
//    std::  cout << "1加1等于" << b <<std:: endl;

//    a = minus_my((double)1.1, 1.1);
//    b = minus ((double)1.1, 1.1);
//    std:: cout << "1.1 减去 1.1等于" << a<<std:: endl;
//    std::  cout << "1减去1等于" << b <<std:: endl;

//  b =  std::minus<double,double> ((double)1.1, 1.1);
//   std::  cout << "1减去1等于" << b <<std:: endl;
    return 0;
}
