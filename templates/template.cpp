#include <bits/stdc++.h>

using namespace std;

template<typename T>
ostream& operator<<(ostream& stream, vector<T> var) {
  stream << '{';
  for (int i = 0;i < var.size();i++) {
    i != var.size() - 1 ?
      stream << var[i] << ", " :
      stream << var[i] << '}';
  }
  stream << endl;
  return stream;
}
