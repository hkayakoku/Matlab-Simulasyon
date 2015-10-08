# Robot Gruplanma Algoritması Simulasyonu

Matlab tabanlı bu simulasyon; n-sayıda ve rastgele konumlara yerleştirilmiş robotlar için belli bir merkeze bağlı olmadan (decenteralize) önceden belirlenmiş sayıda robot kolonisi için farklı bir gruplanma algoritması sunar.

### Programa Bakış
Programa ait ana ekran aşağıdaki gibidir.

![main](http://i61.tinypic.com/2ywssa8.jpg)

## Senaryo
Robotlar; hedeflerin ve engellerin de bulunduğu bir ortamda rastgele dizilmişlerdir.
Simulasyon;

1. Robotların kendi iradesiyle (otonom) hareket etmeleri,

2. Robotların hız, konum, sensör vs. bilgilerinin değerlendirildiği merkezi bir işlem birimi olmadan (decenteralize), kendi içersinde karar vermeleri,

3. Robotların ilk durumda engellerden kaçarak önceden belirlenmiş bir sayıda gruplanmaları,

4. Gruplanmış robotların belirlenen hedefi grup olarak aramaları ve bulmaları.

görevlerini, geliştirilen algoritmalarla yerine getirmektedir.

Robotlar simulasyona manual veya random olarak eklenebilir.

Her bir robot üzerinde mesafe ölçmeye yarayan lazer uzaklık sensörü vardır. Dolayısyla robotların bulunduğu dünya düşünüldüğünde her bir robotun elde edebildiği tek veri, kendisi dışındaki elmanlara olan uzaklığıdır.


## Algoritma Tasarımı

Robotların birbirinden habersiz olarak ve decenteralize şekilde gruplanmasında **Newton Evrensel Kütle Çekim Kanunu** kullanılmıştır.

Kütle çekimi, nesnelerin birbirlerine doğru çekme kuvveti uygulamasına denir. Bu çekme kuvveti; cisimlerin kütleleriyle doğru orantılı, merkezleri arasındaki uzaklığın karesiyle de ters orantılıdır.

![Kütle Çekim](./images/NewtonsLawOfUniversalGravitation.png)

simulasyonda her bir robot için ilk olarak bir kütle ataması yapılmıştır. bu kütle izafi bir değer olup sistemin tepkilerine göre güncellenmektedir. Bu konu ilerleyen aşamalarda anlatılacaktır.

Robotun üzerindeki donanımlar lazer ile sınırlı olduğunda her bir robot için elde edilebilecek en güvenilir bilgi, robotun diğer robotlara olan uzaklık bilgisidir. Bu uzaklık bilgisi kullanılarak aşağıdaki algoritma geliştirilmiştir:

#####Yakınlaşma Algoritması

* Başlangıçta ortama rastgele yerleştirilmiş her bir robot, lazerden aldığı uzaklık verilerini kullanarak sırasıyla diğer roboların kendisine uyguladığı çekim kuvvetlerini hesaplar.
* Bütün çekim kuvvetleri hesaplanan robot bileşke kuvvet ve yön doğrultusunda hareket eder.
* Kütle Çekim doğrultusunda hareket eden robot, belirli bir değere çıktığında hareketini sonlandırır.

######Algoritmanın panelde gösterimi:

![Atama](./images/01_atama.png)
*ilk durum*

![Bileşke](./images/02_bileske.png)
*robotların lazer verisi kullanarak hesapladığı tüm kütle çekimlerin bileşeleri gösterilmiştir.*

![Gruplanma](./images/03_gruplama.png)
*Bileşke kuvvet yönünde hareket eden robotlar önceden belirlenmiş limit kütle çekim değerine ulaştığında durular*

Birbirlerine limit değer kadar yakınlaşan robotlar, gruplanmak için hazır haldedir.

Gruplanan robotların grup olarak hareket etmesi ve hedef taraması yapması amaçlanmıştır. bu noktada gruba ait robotların birbirleriyle ve diğer robotlarla anlık olarak haberleşmesi ve konum bilgilerini anlık paylaşmaları gerekmektedir. Donanımsal sınırlar göz önünde buludurulduğunda bu iletişim yoğunluğu sıkıntılara yol açmaktadır.

Bu sebeple robot grupları içerisinde bir hiyerarşi oluşturulmuştur. Her robot grubunun bir lideri vardır. Gruba ait diğer üye robotlar bu lider üzerinden haberleşirler. Lider robotlar ise diğer guruplara ait lider robotlar ile haberleşme yeteneğine sahiptir. Robot kolonilerinin bu yöntem ile daha verimli biçimde alan taraması yapması amaçlanmıştır.

#####Gruplama ve Lider Atama Algoritması

Yakınlaşma algoritması kullanarak birbirlerine yeterince yaklaşan robotlar arasında aşağıdaki algoritma kullanılarak bir lider seçilecek ve gruplama yapılacaktır.


* Yeterince yaklaşan (limit çekim değerine ulaşan) robot elindeki lazer verisi ile kendisine yakın olan robotları tespit eder.
* Robot Kendisini orijin kabul ederek, sırasıyla diğer robotların koordinatlarını inceler.
* Koordinatları incelenen robotların, orijin kabul edilen robota göre trigonometrik düzlemde hangi bölgeye ait olduğunu belirlenir.
* Robot, araştırdığı diğer robotlar içerisinde *(grupsayısı - 1)* sayıda robotu aynı trigonometrik bölgede yakalayabilirse Kendisini lider ilan eder.

######Örnek Senaryo:



### Kütle Çekim Algoritması
Robotların belli bir merkezden idare edilmediği ve donanımsal olarak sadece etrafı tarama yeteneğine sahip bir sensörü olduğu düşünüldüğünde mevcut roborlar için  
