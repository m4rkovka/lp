#include <iostream>
#include <fstream>
#include <string>
#include <map>
#include <utility>
#include <regex>

struct Human {
	std::string sex;
	std::string name;
};

bool isINDI(std::string temp) {
	std::regex regular("0 @I[0-9]+@ INDI");
	if (std::regex_search(temp.c_str(), regular))
		return true;

	return false;
}

std::string getINDI(std::string temp) {
	std::cmatch result;
	std::regex regular("(@I[0-9]+@)");

	std::regex_search(temp.c_str(), result, regular);
	return result[1];
}

bool isNAME(std::string temp) {
	std::regex regular("1 NAME ([a-zA-Z]+ )/([a-zA-Z]+)/");
	if (std::regex_search(temp.c_str(), regular))
		return true;

	return false;
}

std::string getNAME(std::string temp) {
	std::cmatch result;
	std::regex regular("([a-zA-Z]+ )/([a-zA-Z]+)/");

	std::regex_search(temp.c_str(), result, regular);
	std::string str;
	str += result[1];
	str += result[2];
	return str;
}

bool isSEX(std::string temp) {
	std::regex regular("1 SEX [FM]");
	if (std::regex_search(temp.c_str(), regular))
		return true;
	return false;
}

std::string getSEX(std::string temp) {
	std::cmatch result;
	std::regex regular("1 SEX ([FM])");

	std::regex_search(temp.c_str(), result, regular);
	return result[1];
}

bool isFAM(std::string temp) {
	std::regex regular("0 @F[0-9]+@ FAM");
	if (std::regex_search(temp.c_str(), regular))
		return true;

	return false;
}

std::string getFAM(std::string temp) {
	std::cmatch result;
	std::regex regular("0 (@F[0-9]+@) FAM");

	std::regex_search(temp.c_str(), result, regular);
	return result[1];
}

bool isHUSB(std::string temp) {
	std::regex regular("1 HUSB @I[0-9]+@");
	if (std::regex_search(temp.c_str(), regular))
		return true;

	return false;
}

std::string getHUSB(std::string temp) {
	std::cmatch result;
	std::regex regular("1 HUSB (@I[0-9]+@)");

	std::regex_search(temp.c_str(), result, regular);
	return result[1];
}

bool isWIFE(std::string temp) {
	std::regex regular("1 WIFE @I[0-9]+@");
	if (std::regex_search(temp.c_str(), regular))
		return true;

	return false;
}

std::string getWIFE(std::string temp) {
	std::cmatch result;
	std::regex regular("1 WIFE (@I[0-9]+@)");

	std::regex_search(temp.c_str(), result, regular);
	return result[1];
}

bool isCHIL(std::string temp) {
	std::regex regular("1 CHIL @I[0-9]+@");
	if (std::regex_search(temp.c_str(), regular))
		return true;

	return false;
}

std::string getCHIL(std::string temp) {
	std::cmatch result;
	std::regex regular("1 CHIL (@I[0-9]+@)");

	std::regex_search(temp.c_str(), result, regular);
	return result[1];
}

int main() {
	std::ifstream in("famMarkov.txt");
	Human temp_human;
	std::string temp, temp_indi, temp_name, temp_fam;
	std::map<std::string, Human> peoples;

	while (std::getline(in, temp)) {
		if (isINDI(temp)) {
			temp_indi = getINDI(temp);
			continue;
		}
		if (isNAME(temp)) {
			temp_human.name = getNAME(temp);
			continue;
		}

		if (isSEX(temp)) {
			temp_human.sex = getSEX(temp);
			peoples.insert(std::pair<std::string, Human>(temp_indi, temp_human));
			continue;
		}

		if (isFAM(temp))
			break;
	}

	std::string father_id, mother_id, child_id;
	std::ofstream out("predicates.txt");

	while (std::getline(in, temp)) {
		if (isFAM(temp)) {
			father_id = mother_id = child_id = "";
		}

		if (isHUSB(temp)) {
			father_id = getHUSB(temp);
			continue;
		}

		if (isWIFE(temp)) {
			mother_id = getWIFE(temp);
			continue;
		}

		if (isCHIL(temp)) {
			child_id = getCHIL(temp);
			if (!father_id.empty()) {
				out << "father(\"" << peoples.find(father_id)->second.name << "\", \"" << peoples.find(child_id)->second.name << "\")." << std::endl;
			}
			if (!mother_id.empty()) {
				out << "mother(\"" << peoples.find(mother_id)->second.name << "\", \"" << peoples.find(child_id)->second.name << "\")." << std::endl;
			}
		}
	}	

	for (auto it = peoples.begin(); it != peoples.end(); it++) {
		out << "sex(\"" << it->second.name << "\", \"" << it->second.sex << "\").\n";
	}

	return 0;
}