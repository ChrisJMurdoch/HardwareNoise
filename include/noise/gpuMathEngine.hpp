
#pragma once

#include <noise/mathEngine.hpp>

#include <cuda_runtime_api.h>

class GPUMathEngine : public MathEngine
{
private:
    /** Number of streaming multiprocessors on device */
    int nSM;

public:
    GPUMathEngine();

    /** Create heightmap on gpu */
    Matrix generateHeightMap(std::map<std::string, std::string> &settings, int dimension, float xOff=0, float yOff=0 ) override;

private:

    inline void GPUMathEngine::cudaCheck(cudaError_t err);
    inline void GPUMathEngine::multiCudaMalloc(int size, void **a, void **b, void **c);
    inline void GPUMathEngine::multiCudaFree(void *a, void *b, void *c);
};
