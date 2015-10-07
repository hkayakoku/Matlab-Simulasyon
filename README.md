# Robot Gruplanma Algoritması Simulasyonu

Matlab tabanlı bu simulasyon; n-sayıda ve rastgele konumlara yerleştirilmiş robotlar için belli bir merkeze bağlı olmadan (decenteralize) önceden belirlenmiş sayıda robot kolonisi için farklı bir gruplanma algoritması sunar.

## Senaryo
Robotlar; hedeflerin ve engellerin de bulunduğu bir ortamda rastgele dizilmişlerdir.
Simulasyon Senaryo gereği;
1. Robotların kendi iradesiyle (otonom) hareket etmeleri,
2. Robotların hız, konum, sensör vs. bilgilerinin değerlendirildiği merkezi bir işlem birimi olmadan (decenteralize), kendi içersinde karar vermeleri,
3. Robotların ilk durumda engellerden kaçarak önceden belirlenmiş bir sayıda gruplanmaları,
4. Gruplanmış robotların belirlenen hedefi grup olarak aramaları ve bulmaları.
görevlerini geliştirilen algoritmalarla yerine getirmektedir.



### Programa Bakış
Programa ait ana ekran aşağıdaki gibidir.

![main](http://i61.tinypic.com/2ywssa8.jpg)

### Kütle Çekim Algoritması
Robotların belli bir merkezden idare edilmediği ve donanımsal olarak sadece etrafı tarama yeteneğine sahip bir sensörü olduğu düşünüldüğünde mevcut roborlar için  
