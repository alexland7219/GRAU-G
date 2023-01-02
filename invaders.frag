#version 330 core

in vec2 vtexCoord;
out vec4 fragColor;
uniform sampler2D colormap;

const float UNIT_X = 0.066666666666666667;
const float UNIT_Y = 0.0625;


void paintFigure(vec2 low, vec2 high, vec2 outlow, vec2 outhigh, int rotation){
    // Rotation clockwise
    rotation = rotation % 4;

    if (vtexCoord.x < outhigh.x && vtexCoord.x > outlow.x && vtexCoord.y < outhigh.y && vtexCoord.y > outlow.y)
    {
        vec2 pos = vtexCoord;
        pos -= outlow;
        pos *= vec2(1 / (outhigh.x - outlow.x), 1/ (outhigh.y - outlow.y));

        if (rotation == 3) {
            float z = pos.y;
            pos.y = 1-pos.x;
            pos.x = z;

        } else if (rotation == 2){
            pos.y = 1 - pos.y;
            pos.x = 1 - pos.x;
        } else if (rotation == 1){
            float z = pos.y;
            pos.y = pos.x;
            pos.x = 1-z;
        }


        pos *= vec2((high.x - low.x), (high.y - low.y));
        pos += low;



        fragColor = texture(colormap, pos);
    } 

}


void main()
{
    fragColor = vec4(0,0,0,1);

    paintFigure(vec2(0.5,0.75), vec2(0.75,1), vec2(0.333333, 0.333333), vec2(0.66666667, 0.66666667), 3);



}
