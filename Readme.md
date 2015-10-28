## Matlab ile lazer simulasyonu

### Panel
Simulasyon için hazırlanan panel aşağıdaki gibidir.

![Panel](./images/panel.png)

Robotlar sisteme manual olarak **mouseClick** eventi ile eklenmektedir.

![robotEkle](./images/robotEkle.png)

**mouseHover** eventi ile roborların üzerinde gezildiğinde robot seçilmesi özelliği eklenmiştir.

Seçili robotun üzerine tıklandığında robota ait sensör verisine ulaşılmaktadır.

![robotSensor](./images/robotSensor.png)

Lazer sensörüne ait değişkenler __laserInfo.m__ classı içinde bulunmaktadır.

lazerInfo.m:

```
classdef laserInfo
    % Panelde o an seçili robot için tutulması gerekilen değerler.
    properties(Constant)
        range = 3 % Lazerin sahip olduğu range değeri
        interval = 5 % Lazerin sahip olduğu ışınların sıklık değeri
    end
end
```
