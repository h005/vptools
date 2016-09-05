#include <iostream>
#include <fstream>
#include <string>
#include <string.h>
// input 2D fea file name and 3D fea file name
// remove the case name only remains the fea vector

int main(int argc,char *argv[])
{
	if(argc < 3)
	{
		std::cout << "parameter not enough "<< std::endl;
	}
	else
	{
		// deal 2D fea file
		std::ifstream fin(argv[1]);
		int len = strlen(argv[1]);
		char *path;
		path = new char[len + 1];
		strcpy(path,argv[1]);
		path[len] = 'c';
		path[len+1] = '\0';
		std::ofstream fout(path);
		std::string ss;
		while(std::getline(fin,ss))
		{
			std::getline(fin,ss);
			fout << ss << std::endl;
		}
		fin.close();
		fout.close();
		fin.open(argv[2]);
		delete []path;
		len = strlen(argv[2]);
		path = new char[len+1];
		strcpy(path,argv[2]);
		path[len] = 'c';
		path[len+1] = '\0';
		fout.open(path);
		while(std::getline(fin,ss))
		{
			std::getline(fin,ss);
			fout << ss << std::endl;
		}
		fin.close();
		fout.close();		
	}
}
