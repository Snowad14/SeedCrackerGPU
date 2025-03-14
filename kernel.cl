#include <jrand.cl>

static inline Random get_random_with_structure_seed (long world_seed, int x, int z, int salt) {
    return get_random(x * 341873128712L + z * 132897987541L + world_seed + salt);
}

static inline int temple_at(ulong world_seed, int salt, int x, int z) {
    int rSize = 32;
    int rSep = 8;
    int int_7 = x + rSize * 0;
    int int_8 = z + rSize * 0;
    int int_9 = int_7 < 0 ? int_7 - rSize + 1 : int_7;
    int int_10 = int_8 < 0 ? int_8 - rSize + 1 : int_8;
    int rx = int_9 / rSize;
    int rz = int_10 / rSize;
    Random r = get_random_with_structure_seed(world_seed, rx, rz, salt);
    if (random_next_int(&r, rSize - rSep) != x - rx * rSize) return 0;
    if (random_next_int(&r, rSize - rSep) != z - rz * rSize) return 0;
    return 1;
}

static inline int monument_at(ulong world_seed, int x, int z) {
    int rSize = 32;
    int rSep = 5;
    int int_7 = x + rSize * 0;
    int int_8 = z + rSize * 0;
    int int_9 = int_7 < 0 ? int_7 - rSize + 1 : int_7;
    int int_10 = int_8 < 0 ? int_8 - rSize + 1 : int_8;
    int rx = int_9 / rSize;
    int rz = int_10 / rSize;
    Random r = get_random_with_structure_seed(world_seed, rx, rz, 10387313);
    if ((random_next_int(&r, rSize - rSep) + random_next_int(&r, rSize - rSep)) / 2 != x - rx * rSize) return 0;
    if ((random_next_int(&r, rSize - rSep) + random_next_int(&r, rSize - rSep)) / 2 != z - rz * rSize) return 0;
    return 1;
}

static inline int buried_treasure_at(long world_seed, int x, int z) {
    Random r = get_random_with_structure_seed(world_seed, x, z, 10387320);
    return random_next(&r, 24) < 167773;
}

static inline int bastion_remnant_at(ulong world_seed, int x, int z) {
    int rSize = 27;
    int rSep = 4;
    int constrained_x = x < 0 ? x - rSize + 1 : x;
    int constrained_z = z < 0 ? z - rSize + 1 : z;
    int rx = constrained_x / rSize;
    int rz = constrained_z / rSize;
    Random r = get_random_with_structure_seed(world_seed, rx, rz, 30084232);
    if (random_next_int(&r, rSize - rSep) != x - rx * rSize) return 0;
    if (random_next_int(&r, rSize - rSep) != z - rz * rSize) return 0;
    if (random_next_int(&r,5) < 2) return 0;
    return 1;
}

static inline int fortress_at(ulong world_seed, int x, int z) {
    int rSize = 27;
    int rSep = 4;
    int constrained_x = x < 0 ? x - rSize + 1 : x;
    int constrained_z = z < 0 ? z - rSize + 1 : z;
    int rx = constrained_x / rSize;
    int rz = constrained_z / rSize;
    Random r = get_random_with_structure_seed(world_seed, rx, rz, 30084232);
    if (random_next_int(&r, rSize - rSep) != x - rx * rSize) return 0;
    if (random_next_int(&r, rSize - rSep) != z - rz * rSize) return 0;
    if (random_next_int(&r,5) >= 2) return 0;
    return 1;
}

static inline int end_city_at(ulong world_seed, int x, int z) {
    int rSize = 20;
    int rSep = 11;
    int constrained_x = x < 0 ? x - rSize + 1 : x;
    int constrained_z = z < 0 ? z - rSize + 1 : z;
    int rx = constrained_x / rSize;
    int rz = constrained_z / rSize;
    Random r = get_random_with_structure_seed(world_seed, rx, rz, 10387313);
    if ((random_next_int(&r, rSize - rSep) + random_next_int(&r, rSize - rSep)) / 2 != x - rx * rSize) return 0;
    if ((random_next_int(&r, rSize - rSep) + random_next_int(&r, rSize - rSep)) / 2 != z - rz * rSize) return 0;
    return 1;
}

static inline int fortress_old_at(ulong world_seed, int x, int z) {
    int shift_x = x >> 4;
    int shift_z = z >> 4;
    Random r = get_random((ulong)(shift_x ^ shift_z << 4) ^ world_seed );
    random_next(&r,32);
    if (random_next_int(&r,3) != 0) {
        return 0;
    }
    if (x != (shift_x << 4) + 4 + random_next_int(&r,8)) {
        return 0;
    }
    if (z != (shift_z << 4) + 4 + random_next_int(&r,8)) {
        return 0;
    }
    return 1;
}

static inline int portal_at(ulong world_seed, int x, int z, int precision) {
  int rSize = 40;
  int rSep = 15;
  for (int xsum = -precision; xsum <= precision; xsum++) {
    for (int zsum = -precision; zsum <= precision; zsum++) {
        int newx = x + xsum;
        int newz = z + zsum;
        int int_7 = newx + rSize * 0;
        int int_8 = newz + rSize * 0;
        int int_9 = int_7 < 0 ? int_7 - rSize + 1 : int_7;
        int int_10 = int_8 < 0 ? int_8 - rSize + 1 : int_8;
        int rx = int_9 / rSize;
        int rz = int_10 / rSize;
        Random r = get_random_with_structure_seed(world_seed, rx, rz, 34222645);
        if (random_next_int(&r, rSize - rSep) != newx - rx * rSize) continue;
        if (random_next_int(&r, rSize - rSep) != newz - rz * rSize) continue;
        return 1;
    }
  }
  return 0;
}

static inline int shipwrek_at(ulong world_seed, int x, int z, int precision) {
  int rSize = 24;
  int rSep = 4;
  for (int xsum = -precision; xsum <= precision; xsum++) {
    for (int zsum = -precision; zsum <= precision; zsum++) {
        int newx = x + xsum;
        int newz = z + zsum;
        int int_7 = newx + rSize * 0;
        int int_8 = newz + rSize * 0;
        int int_9 = int_7 < 0 ? int_7 - rSize + 1 : int_7;
        int int_10 = int_8 < 0 ? int_8 - rSize + 1 : int_8;
        int rx = int_9 / rSize;
        int rz = int_10 / rSize;
        Random r = get_random_with_structure_seed(world_seed, rx, rz, 165745295);
        if (random_next_int(&r, rSize - rSep) != newx - rx * rSize) continue;
        if (random_next_int(&r, rSize - rSep) != newz - rz * rSize) continue;
        return 1;
    }
  }
  return 0;
}

__kernel void start(ulong offset, ulong stride, __global ulong *seeds, __global ushort *ret) {
    size_t id = get_global_id(0);
    uchar max_count = 0;
    uchar max_last = 0;
    ulong seed_base = (offset + id) * stride;
    for (ulong i = 0; i < stride; i++) {
        ulong worldSeed = seed_base|i;
        //ulong worldSeed = 2277950512955552450;
        // Data test for the seed 2277950512955552450 (worldSeed) or 255001412924098 (structureSeed) or 0000e7ec24a272c2 (hex structureSeed)

                            // Desert Pyramid 14357617
                            // Igloo 14357618
                            // Jungle Temple 14357619
                            // Swamp Hut 14357620
                                                      
        if (!temple_at(worldSeed, /* Refer to the above to get the good number */ 14357619, 8, 589)) continue;
        if (!portal_at(worldSeed, 97, 881, 0)) continue;
        if (!portal_at(worldSeed, 8, 6, 1)) continue; // --> Use Chunk Coordinates and not simple coordinates !
        if (!portal_at(worldSeed, 14, 62, 1)) continue;
        if (!end_city_at(worldSeed, -40, 62)) continue;

        max_count++;
        seeds[id] = worldSeed;
    }
    ret[id] = (max_count << 8) | max_last;
}
