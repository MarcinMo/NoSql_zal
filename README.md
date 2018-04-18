# Technologie NoSQL - Marcin Moroz


Wybrany zbiór danych (Dane zawierają 2 500 000 rekordów) - [link](https://drive.google.com/open?id=13hTWaidu0TK6la3UjAvsd6IJ1_7nHGVk)

Rozmiar wyniósł: 321 MB.


Informacje o komputerze na którym były wykonywane obliczenia:

| Nazwa                 | Wartość    |
|-----------------------|------------|
| System operacyjny     | Windows 7 Ultimate |
| Procesor              | Intel® Pentium® Dual Processor T2370 |
| Ilość rdzeni          | 2 |
| Pamięć                | 2048MB |
| Dysk                  | HDD |

\* do testu wybrano laptop o słabszych parametrach w celu uzyskania różnych wyników od grupy

___________________
#### Wersja mongo

- paczka: Windows Server 2008 R2 64-bit and later, with SSL support x64

Instalacja i konfiguracja oprogramowania należy ją pobrać ze [strony](https://www.mongodb.com/download-center#community) następnie, aby uruchomić bazę danych należy w konsoli cmd wpisać polecenie:

 ``` mongod```


___________________
Import danych do bazy Mongo (komenda)

 ``` mongoimport --db tweet --collection tweet --file dataset_marcin.json```
_______________
#### Wyniki tabelka

Wyniki zostały przedstawone w formie tabeli:

|   | opcje | średni wynik sekundy | średni wynik minuty |
| ------ | ------ | ------ | ------ |
| I | { "w" : 1, "wtimeout" : 0 } | 810 | 12,8 |
| II | { w: 1, j: false } | 789 | 12,5 |
| III | { w: 1, j: true } | 854 | 13,6 |
| IV | { w: 2, j: false } | 654 | 10,2 |
| V | { w: 2, j: true } | 889 | 14,1 |

#### Spostrzeżenia

Dwa najlepsze wyniki jakie można zobaczyć to podjeście II i IV. Oba podejścia mają wspólną opcję: 

 ```j: false  ```

co oznacza, że dane zostają zapisane w pamięci. Na kolejnym miejscu znajduje się podejście I które ma tą samą opcję dla j tylko nie podaną gdyż jest ona opcją domyślną. Opcja wtimeout jeśli nie jest większa od I nie ma wpływu na wynik dlatego wyniki II i I niewiele od siebie odbiegają. 

Najgorsze wyniki to podejścia III i V i posiadają opcję:

 ```j: true  ```

co oznacza że dane będą zapisywane w disk journal(On-disk journal).

Natomiast opcja "w" żąda potwierdzenia, że operacja zapisu została rozpropagowana do określonej liczby instancji mongo. Porównując IV i II wydawałoby się że im wyższy numer tym lepszy czas ale porównując II i V można odnieść inne wrażenie jakby zapis(On-disk journal) miał odwrotny wpływ na czas niż zapis(in memory).

Kolejność od najlepszego do najgorszego czasu: **IV, II, I, III, V**.

W formie tabeli:

|   | opcje | średni wynik sekundy | średni wynik minuty |
| ------ | ------ | ------ | ------ |
| IV | { w: 2, j: false } | 654 | 10,2 |
| II | { w: 1, j: false } | 789 | 12,5 |
| I | { "w" : 1, "wtimeout" : 0 } | 810 | 12,8 |
| III | { w: 1, j: true } | 854 | 13,6 |
| V | { w: 2, j: true } | 889 | 14,1 |

_______________
#### Wyniki tabelka
Wyniki zostały przedstawone w formie tabeli: moje dane **vs** pomorskie 

| opcje | user | system | time(elapsed) | seconds |  | user | system | time(elapsed) | seconds |
| ------ | ------ | ------ | ------ | ------ | ------ | ------ | ------ | ------ | ------ |
| { w: 1 wtimeout: 0 } |18|1.06| 0:48.08 |48|  |1.36|0.13| 1:00.62 |61| 
|  |18.18|1.17| 1:26.07 |86|  |1.5|0.25| 1:24.20 |84| 
|  |19.25|1.42| 2:21.16 |141|  |1.41|0.12| 1:05.21 |65| 
|  |18.79|1.12| 1:28.86 |89|  |1.47|0.14| 1:16.54 |76| 
|  |18.79|1.12| 1:28.86 |89|  |1.46|0.16| 1:12.79 |73| 
| średnie czasy |18.602|1.178|01:31|90.6|  |1.44|0.16|01:12|71.8| 

| opcje | user | system | time(elapsed) | seconds |  | user | system | time(elapsed) | seconds |
| ------ | ------ | ------ | ------ | ------ | ------ | ------ | ------ | ------ | ------ |
| { w: 1 j: false } |17.76|1.18| 0:54.11 |54|  |1.41|0.15| 1:04.81 |65| 
|  |18.84|1.17| 2:10.02 |130|  |1.53|0.14| 1:15.97 |76| 
|  |18.04|1.12| 0:58.49 |58|  |1.49|0.17| 1:15.61 |76| 
|  |20.06|1.19| 2:26.98 |147|  |1.56|0.22| 1:28.64 |89| 
|  |18.01|1.04| 0:55.97 |56|  |1.58|0.21| 1:27.82 |88| 
| średnie czasy |18.542|1.14|01:29|89|  |1.514|0.178|01:19|78.8| 

| opcje | user | system | time(elapsed) | seconds |  | user | system | time(elapsed) | seconds |
| ------ | ------ | ------ | ------ | ------ | ------ | ------ | ------ | ------ | ------ |
| { w: 1 j: true } |18.34|1.11| 1:27.11 |87|  |1.51|0.19| 1:19.27 |79| 
|  |18.78|1.18| 2:01.84 |122|  |1.43|0.18| 1:12.71 |73| 
|  |18.18|1.21| 1:49.84 |110|  |1.53|0.27| 1:28.22 |88| 
|  |18.1|1.3| 1:32.38 |92|  |1.66|0.2| 1:36.14 |96| 
|  |18.2|1.14| 1:30.37 |90|  |1.52|0.18| 1:20.99 |82| 
| średnie czasy |18.32|1.188|01:40|100.2|  |1.53|0.204|01:24|83.6| 

| opcje | user | system | time(elapsed) | seconds |  | user | system | time(elapsed) | seconds |
| ------ | ------ | ------ | ------ | ------ | ------ | ------ | ------ | ------ | ------ |
| { w: 2 j: false } |18.24|1.04| 1:47.63 |107|  |1.55|0.19| 1:30.69 |91| 
|  |18.4|1.13| 2:45.03 |165|  |1.61|0.2| 1:32.74 |93| 
|  |18.96|1.28| 3:21.35 |201|  |1.37|0.15| 1:03.61 |64| 
|  |18.84|1.25| 2:34.24 |154|  |1.41|0.12| 1:02.07 |62| 
|  |18.48|1.13| 2:00.34 |121|  |1.4|0.12| 1:02.38 |63| 
| średnie czasy |18.584|1.166|02:30|149.6|  |1.468|0.156|01:15|74.6| 

| opcje | user | system | time(elapsed) | seconds |  | user | system | time(elapsed) | seconds |
| ------ | ------ | ------ | ------ | ------ | ------ | ------ | ------ | ------ | ------ |
| { w: 2 j: true } |19.04|1.29| 2:17.12 |137|  |1.36|0.17| 0:57.78 |58| 
|  |19.19|1.16| 2:57.71 |177|  |1.44|0.09| 0:59.23 |59| 
|  |18.44|1.35| 3:39.54 |219|  |1.43|0.13| 1:00.64 |61| 
|  |18.43|1.17| 2:41.18 |161|  |1.35|0.17| 0:56.86 |57| 
|  |18.25|1.2| 2:12.84 |133|  |1.56|0.18| 1:14.56 |75| 
| średnie czasy |18.67|1.234|02:45|165.4|  |1.428|0.148|01:02|62| 


#### Spostrzeżenia
Dla danych województwa pomorskiego opcje:

  ``` { w: 2, j: true }  ```

wypadły teraz najlepiej, może to być spowodowane tym, że dane były spakowane gunzipem lub rozmiar paczki. 

Dla moich danych opcje:

  ```{ w: 2, j: false }  ```

wypadły już nieco gorzej możliwe, że dla mniejszych danych już nie wypadają tak korzystnie.

_______________

#### Real, user and sys

-**Real** is wall clock time - time from start to finish of the call. This is all elapsed time including time slices used by other processes and time the process spends blocked (for example if it is waiting for I/O to complete).

-**User** is the amount of CPU time spent in user-mode code (outside the kernel) within the process. This is only actual CPU time used in executing the process. Other processes and time the process spends blocked do not count towards this figure.

-**Sys** is the amount of CPU time spent in the kernel within the process. This means executing CPU time spent in system calls within the kernel, as opposed to library code, which is still running in user-space. Like 'user', this is only CPU time used by the process. See below for a brief description of kernel mode (also known as 'supervisor' mode) and the system call mechanism.

[źródło pod tym linkiem](https://stackoverflow.com/questions/556405/what-do-real-user-and-sys-mean-in-the-output-of-time1)
_______________

# Agregacje <br />
Operacje agregacji przetwarzają dokumenty i zwracają przeliczone wyniki.

Agregacje: <br />
- grupują w jedną wartości z różnych dokumentów,
- wykonują wiele różnych operacji na zgrupowanych danych,
- zwracając pojedynczy wynik.

![agr1](https://github.com/MarcinMo/NoSql_zal/blob/master/all.png "Logo Title Text 1")


Agregacja 1:
------------------------------
Time spent in executing function agr1 is: 0.074 sec.

![agr1](https://github.com/MarcinMo/NoSql_zal/blob/master/time.png "Logo Title Text 1")

Agregacja 2:
------------------------------
Time spent in executing function agr2 is: 16.5 sec.

![agr1](https://github.com/MarcinMo/NoSql_zal/blob/master/najm%C5%82odsze.png "Logo Title Text 1")


Agregacja 3:
------------------------------
Time spent in executing function agr3 is: 15.5 sec.

![agr2](https://github.com/MarcinMo/NoSql_zal/blob/master/najstarcze.png "Logo Title Text 1")


Obserwacje:
RAM do dysku ma duże znaczenie w szybkości wykonywania aggregacji.

_______________

#  Git sizer <br />

Komenda jaką trzeba uruchomić:

 ``` git sizer --verbose  ```


![agr1](https://github.com/MarcinMo/NoSql_zal/blob/master/git.png "Logo Title Text 1")



