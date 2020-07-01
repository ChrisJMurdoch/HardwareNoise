
#pragma once

#include <math/mathEngine.hpp>

class CPUMathEngine : public MathEngine
{
public:
    /** Create heightmap on cpu */
    Heightmap generateHeightMap(std::map<std::string, std::string> &settings, int dimension, float xOff=0, float yOff=0 ) override;
};
