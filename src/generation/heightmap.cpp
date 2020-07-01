
#include <generation/heightmap.hpp>

#include <string>

Heightmap::Heightmap( float *values, int width )
{
    nNodes = width*width;
    nodes = new float[nNodes];
    memcpy( nodes, values, nNodes*sizeof(float) );
}

Heightmap::Heightmap( float **values, int width )
{
    nNodes = width*width;
    nodes = *values;
    values = nullptr;
}

Heightmap::~Heightmap()
{
    delete[] nodes;
}
