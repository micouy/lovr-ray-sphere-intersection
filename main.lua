function lovr.draw(pass)
    local sphere = {
        center = vec3(0, 1.2, -0.8),
        radius = 0.3,
    }

    local ray = {
        origin    = vec3(lovr.headset.getPosition("hand/right/point")),
        direction = vec3(lovr.headset.getDirection("hand/right/point"))
    }

    if ray.origin then
        local areIntersecting = areIntersecting(ray, sphere)

        pass:setColor(1.0, 0.4, 0.1)
        pass:line(ray.origin, ray.origin + ray.direction)
        drawOpposite(pass, ray, sphere, areIntersecting)
    end

    drawSphere(pass, sphere)
end

function drawSphere(pass, sphere)
    pass:setColor(0.1, 0.4, 1.0)
    pass:points(sphere.center)
    pass:circle(sphere.center, sphere.radius, quat(vec3(1, 0, 0)), 'line')
    pass:circle(sphere.center, sphere.radius, quat(vec3(0, 1, 0)), 'line')
    pass:circle(sphere.center, sphere.radius, quat(vec3(0, 0, 1)), 'line')
end

function areIntersecting(ray, sphere)
    local translation = vec3(sphere.center):sub(ray.origin)
    local distance = translation:length()

    local adjacentLength = translation:dot(ray.direction)
    local oppositeLength = math.sqrt(distance ^ 2 - adjacentLength ^ 2)
    local areIntersecting = oppositeLength <= sphere.radius

    return areIntersecting
end

function drawOpposite(pass, ray, sphere, areIntersecting)
    local translation = vec3(sphere.center):sub(ray.origin)
    local distance = translation:length()

    local adjacentLength = translation:dot(ray.direction)
    local oppositeLength = math.sqrt(distance ^ 2 - adjacentLength ^ 2)

    local perpendicular = translation:cross(ray.direction)
    local oppositeDiretion = perpendicular:cross(ray.direction):normalize()
    local opposite = oppositeDiretion * oppositeLength

    if areIntersecting then
        pass:setColor(0.1, 1.0, 0.3)
    else
        pass:setColor(1.0, 1.0, 1.0)
    end

    pass:line(sphere.center, sphere.center + opposite)
end
