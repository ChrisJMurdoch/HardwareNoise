
#pragma once

#include <map>
#include <string>

class Heightmap
{
public:
    float *nodes;
    int nNodes;

public:
    /** Standard memcpy ctor */
    Heightmap( float *values, int width );

    /** Move ctor, takes array and leaves nullptr */
    Heightmap( float **values, int width );

    ~Heightmap();
};
