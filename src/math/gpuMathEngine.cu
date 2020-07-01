
#include <math/gpuMathEngine.hpp>

#include <utility/log.hpp>

#include "cuda.h"
#define GLM_FORCE_CUDA
#include <glm/glm.hpp>
namespace gpucommon
{
    #include "common.cu"
}

// Hardware settings
#define STREAMS 12
#define WARPS 16

// DEVICE SETUP

GPUMathEngine::GPUMathEngine()
{
    cudaCheck( cudaDeviceGetAttribute(&nSM, cudaDevAttrMultiProcessorCount, 0) );
}

// HEIGHTMAP GENERATION

__global__
void heightmapKernel(float *out, int dimension, float min, float max, GPUMathEngine::Sample sample, float period, int octaves )
{
    // Start index
    int startIndex = threadIdx.x + blockIdx.x * blockDim.x;

    // Grid stride
    int index = startIndex;

    // Thread calculation
    int x = index % dimension;
    int y = index / dimension;
    do
    {
        if ( x==0 || x==dimension-1 || y==0 || y==dimension-1 )
        {
            out[index] = -10;
            index += blockDim.x*gridDim.x;
            x = index % dimension;
            y = index / dimension;
            continue;
        }

        // Get sample
        float value;
        switch ( sample )
        {
        case GPUMathEngine::mountain:
            value = gpucommon::mountain(x, y, period);
            break;
        default:
            value = gpucommon::fractal(x, y, period, sample, octaves);
            break;
        }
        out[index] = min + ( value * (max-min) );

        // Stride forward
        index += blockDim.x*gridDim.x;
        x = index % dimension;
        y = index / dimension;
    }
    while ( y<dimension );
}

Heightmap GPUMathEngine::generateHeightMap(std::map<std::string, std::string> &settings, int dimension, float xOff, float yOff )
{
    float min = stof(settings["min"]),
          max = stof(settings["max"]);
    int period = stoi(settings["period"]),
        octaves = stoi(settings["octaves"]);
    Sample sample = getSample( settings["sampling"] );
    float *nodes = new float[dimension*dimension];

    // Allocate device memory
    float *d_out;
    int size = dimension*dimension*sizeof(float);
    cudaCheck( cudaMalloc( (void **)&d_out, size ) );
    heightmapKernel<<<nSM, WARPS*32>>>( d_out, dimension, min, max, sample, period, octaves );
    cudaCheck( cudaMemcpy(nodes, d_out, size, cudaMemcpyDeviceToHost) );
    cudaCheck( cudaFree(d_out) );

    return Heightmap(&nodes, dimension);
}

// MACROS

inline void GPUMathEngine::cudaCheck(cudaError_t err)
{
    if (err != cudaSuccess)
    {
        Log::println( Log::error, "CudaCheck:" );
        Log::println( Log::error, cudaGetErrorString(err) );
    }
}
