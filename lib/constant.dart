
import 'dart:ui';

Map<int, ColorLabel> mapCategory 
= {
  1: new ColorLabel(1, "家居開支", Color.fromARGB(0, 255, 255, 255), Color.fromARGB(0, 0, 0, 255))
, 2: new ColorLabel(2, "老婆開支", Color.fromARGB(0, 255, 255, 255), Color.fromARGB(0, 0, 0, 255))
, 3: new ColorLabel(3, "囝囡開支", Color.fromARGB(0, 255, 255, 255), Color.fromARGB(0, 0, 0, 255))
, 4: new ColorLabel(4, "其他開出", Color.fromARGB(0, 255, 255, 255), Color.fromARGB(0, 0, 0, 255))
};

Map<int, ColorLabel> mapType
= {
  1: new ColorLabel(1, "管理費", Color.fromARGB(0, 255, 255, 255), Color.fromARGB(0, 0, 0, 255))
, 2: new ColorLabel(2, "寬頻費", Color.fromARGB(0, 255, 255, 255), Color.fromARGB(0, 0, 0, 255))
, 3: new ColorLabel(3, "電費", Color.fromARGB(0, 255, 255, 255), Color.fromARGB(0, 0, 0, 255))
, 4: new ColorLabel(4, "水費", Color.fromARGB(0, 255, 255, 255), Color.fromARGB(0, 0, 0, 255))
, 5: new ColorLabel(5, "煤氣費", Color.fromARGB(0, 255, 255, 255), Color.fromARGB(0, 0, 0, 255))
, 6: new ColorLabel(6, "傞餉", Color.fromARGB(0, 255, 255, 255), Color.fromARGB(0, 0, 0, 255))
, 7: new ColorLabel(7, "家庭雜費", Color.fromARGB(0, 255, 255, 255), Color.fromARGB(0, 0, 0, 255))
, 8: new ColorLabel(8, "老婆支費", Color.fromARGB(0, 255, 255, 255), Color.fromARGB(0, 0, 0, 255))
, 9: new ColorLabel(9, "網購", Color.fromARGB(0, 255, 255, 255), Color.fromARGB(0, 0, 0, 255))
, 10: new ColorLabel(10, "囝囡雜費", Color.fromARGB(0, 255, 255, 255), Color.fromARGB(0, 0, 0, 255))
, 11: new ColorLabel(11, "囝囡學費", Color.fromARGB(0, 255, 255, 255), Color.fromARGB(0, 0, 0, 255))
, 12: new ColorLabel(12, "囝囡課外", Color.fromARGB(0, 255, 255, 255), Color.fromARGB(0, 0, 0, 255))
, 13: new ColorLabel(13, "老婆醫療", Color.fromARGB(0, 255, 255, 255), Color.fromARGB(0, 0, 0, 255))
, 14: new ColorLabel(14, "囝囡醫療", Color.fromARGB(0, 255, 255, 255), Color.fromARGB(0, 0, 0, 255))
, 15: new ColorLabel(15, "老婆保費", Color.fromARGB(0, 255, 255, 255), Color.fromARGB(0, 0, 0, 255))
, 16: new ColorLabel(16, "家居保險", Color.fromARGB(0, 255, 255, 255), Color.fromARGB(0, 0, 0, 255))
, 17: new ColorLabel(17, "家庭電器", Color.fromARGB(0, 255, 255, 255), Color.fromARGB(0, 0, 0, 255))
, 18: new ColorLabel(18, "旅遊娛樂", Color.fromARGB(0, 255, 255, 255), Color.fromARGB(0, 0, 0, 255))
, 19: new ColorLabel(19, "封利是", Color.fromARGB(0, 255, 255, 255), Color.fromARGB(0, 0, 0, 255))
, 20: new ColorLabel(20, "家品", Color.fromARGB(0, 255, 255, 255), Color.fromARGB(0, 0, 0, 255))
, 21: new ColorLabel(21, "其它", Color.fromARGB(0, 255, 255, 255), Color.fromARGB(0, 0, 0, 255))
};

class ColorLabel
{
  ColorLabel(this.id, this.text, this.forecolor, this.backcolor);
  int id;
  String text;
  Color forecolor;
  Color backcolor;
}
