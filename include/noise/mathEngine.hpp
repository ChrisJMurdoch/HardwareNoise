
#pragma once

#include <utility/matrix.hpp>

#include <map>
#include <string>

/** Maths engine interface to abstract cpu and gpu implementations */
class MathEngine
{
public:
    /** Type of point sampling for heightmap generation */
    enum Sample { hash, sin, perlin, perlinRidge, mountain };

protected:
    /** Map strings to enums */
    Sample getSample( std::string str );

public:
    /** Create heightmap */
    virtual Matrix generateHeightMap(std::map<std::string, std::string> &settings, int dimension, float xOff=0, float yOff=0 ) = 0;
};
