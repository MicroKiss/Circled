switch (dir) {
    case 0:
        x+=spd*global.deltaTime;
        break;
    case 1:
        y-=spd*global.deltaTime;
        break;
    case 2:
        x-=spd*global.deltaTime;
        break;
    case 3:
        y+=spd*global.deltaTime
        break;
}