
#include <math/cpuMathEngine.hpp>

#include <glm/glm.hpp>
namespace cpucommon
{
    #include "common.cu"
}

#include <utility/log.hpp>

// FUNCTIONS

Heightmap CPUMathEngine::generateHeightMap(std::map<std::string, std::string> &settings, int dimension, float xOff, float yOff )
{
    // Get settings
    float min = stof(settings["min"]),
          max = stof(settings["max"]);
    int period = stoi(settings["period"]),
        octaves = stoi(settings["octaves"]);
    Sample sample = getSample( settings["sampling"] );
    float *nodes = new float[dimension*dimension];
    
    for (int y=0; y<dimension; y++) for (int x=0; x<dimension; x++)
    {
        if ( x==0 || x==dimension-1 || y==0 || y==dimension-1 )
        {
            nodes[y*dimension + x] = -10;
            continue;
        }

        // Custom sampling
        float value;
        switch ( sample )
        {
        case mountain:
            value = cpucommon::mountain(x, y, period);
            break;
        default:
            value = cpucommon::fractal(x, y, period, sample, octaves);
            break;
        }
        
        nodes[y*dimension + x] = min + ( value * (max-min) );
    }

    return Heightmap(&nodes, dimension);
}
