
#pragma once

#include <noise/mathEngine.hpp>

class CPUMathEngine : public MathEngine
{
public:
    /** Create heightmap on cpu */
    Matrix generateHeightMap(std::map<std::string, std::string> &settings, int dimension, float xOff=0, float yOff=0 ) override;
};
