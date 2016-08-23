# MATLAB SWARM ROBOTIC SIMULASYONU

##### 1. Ana ekran:

![Ana Ekran](images//1-AnaEkran.png)

##### 2. Butonlar ve Anlamları

![Robot](images//icons//robot.png)
__ Panelde rastgele koordinata robot ekler __

![Obstacle](images//icons//obstacle.png)
__ Panelde rastgele koordinata engel ekler __

![Goal](images//icons//goal.png)
__ Panelde rastgele koordinata hedef ekler __

![Grav](images//icons//grav.png)
__ Kütle çekim algoritmasını çalıştırır __

![Anim](images//icons//startAnim.png)
__ Kütle çekimleri hesaplanmış robotlar için animasyonu başlatır __

![Leader](images//icons//assignleader.png)
__ Lider atama algoritmasını çalıştırır. __

![Delete](images//icons//delete.png)
__ Belirtilen tipte elemanı (Robot, Engel, Cisim) panelden siler __

![Print](images//icons//print.png)
__ Bütün elemanların özelliklerini workspace'e basar __

##### 3. Programın Çalışması

* Programa Robot, Engel ve Cisim elemanları butonlar yardımıyla random olarak eklendiği gibi işaretçi ile üzerine istenilen yere de eklenebilir.

![Ekleme](images//2-ElemanEkleme.png)

##### 4. Senoryo Kaydetme & Açma

* Programda, mevcut senaryoyu __Scenario > Save Scenario__  seçeneği ile kaydedebilir ve kayıtlı senaryoyu __Scenario > Load Scenario__ seçeneği ile tekrar yükleyebilirsiniz. Kaydedilen senorya __*.sec__ uzantılıdır.

![Senaryo Yükleme](images//3-Senaryo.png)

![Senaryo Yükleme](images//4-SenaryoYükleme.png)

##### 5. Kütle Çekim Algoritmasını Çalıştırma

* Programda, kütle çekim algoritması ![Grav](images//icons//grav.png) butonuna basarak çalıştırılır ve her bir robot için toplam çekim değeri hesaplanır. Kütle çekim değerleri hesaplanan robotların hareketleri ![Anim](images//icons//startAnim.png) butonu ile sağlanır. Bu sayede robotlar, belirlenin kütle çekim değerine kadar birbirlerine yaklaşırlar.

![Kütle Çekim](images//5-KütleÇekim.png)

![Kütle Çekim](images//6-KütleÇekim.png)

##### 6. Lider Atama Algoritması
* Kütle çekim algoritması hesaplanım animasyon çalıştırıldıktan __sonra__ lider atama algoritmasına seçilir. ![Leader](images//icons//assignleader.png) butonu lider atama algoritmasını çalıştırır ve algoritma gereği decenteralize olarak lider ataması yapılır. Lider olarak atanan robot kırmızı daire ile gösterilmektedir.

![Lider Ataması](images//7-LiderAtama.png)

##### 7. Kütle Çekimi & Ağırlık Merkezi Algoritması
* Lider ataması yapılan robotlar için bir sonraki aşama hedefe yönelme aşamasıdır. Bu aşamada lider robot hedefe yönelirken lideri takip eden robotlar da hedef araması yaparken; diğer yandan grup alanını korumaya çalışırlar.
* Robotların hedefe yönelebilmesi için kütle çekim algoritmasının tekrar çalışması gerekmektedir. Bunun için kütle çekim algoritmasını çalıştıran ![Grav](images//icons//grav.png) butonuna tekrar basılarak robotlara kütle çekim kuvveti verilir.
* ilk değerleri atanmış robotların hareket edebilmesi için ![Anim](images//icons//startAnim.png) butonuna tekrar basılır. Robot kolonisi hedefini bulana kadar hareketine devam edecektir.

![Kütle Çekim Kolonisi](images//8-KütleÇekimKoloni.png)

![Kütle Çekim Kolonisi 2](images//9-KütleÇekimKoloni2.png)

![Kütle Çekim Kolonisi 3](images//10-KütleÇekimKoloni3.png)

##### Görüntüleme Seçenekleri
* __Menu > Ayarlar__ sekmesi altında panel görüntülenme seçenekleri değiştirebilmektedir.

![Ayarlar](images//11-Ayarlar.png)
