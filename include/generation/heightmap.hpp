
#pragma once

#include <vector>

class Heightmap
{
private:
    std::vector<float> data;
    int rows, cols;

public:
    Heightmap(int rows, int cols);

    /** Return pointer to sub-array */
    float *operator[](int row);

    /** Number of members in matrix */
    int size();
};
