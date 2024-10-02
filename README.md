# Ray-sphere intersection detection in five lines of LÖVR

![Screenshot 1](screenshot1.png)
![Screenshot 2](screenshot2.png)

The gist:

```lua
local translation = vec3(sphere.center):sub(ray.origin)
local distance = translation:length()

local adjacentLength = translation:dot(ray.direction)
local oppositeLength = math.sqrt(distance ^ 2 - adjacentLength ^ 2)
local areIntersecting = oppositeLength <= sphere.radius
```

Run with:

```bash
./run.sh
```
