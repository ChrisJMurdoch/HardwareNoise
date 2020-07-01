
#include <generation/heightmap.hpp>

Heightmap::Heightmap(int rows, int cols) : data(rows*cols)
{
    this->rows = rows;
    this->cols = cols;
}

float *Heightmap::operator[](int row)
{
    return &data[cols*row];
}

int Heightmap::size()
{
    return rows*cols;
}
