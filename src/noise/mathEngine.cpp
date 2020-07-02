
#include <noise/mathEngine.hpp>

MathEngine::Sample MathEngine::getSample( std::string str )
{
    const char *s = str.c_str();

    if ( strcmp(s, "hash") == 0 )
        return MathEngine::hash;
    else if ( strcmp(s, "perlin") == 0 )
        return MathEngine::perlin;
    else if ( strcmp(s, "perlinRidge") == 0 )
        return MathEngine::perlinRidge;
    else if ( strcmp(s, "mountain") == 0 )
        return MathEngine::mountain;
    else if ( strcmp(s, "plateau") == 0 )
        return MathEngine::plateau;
    else
        return MathEngine::hash;
}
