In implementarea temei am urmarit, pe langa rezolvarea adecvata a cerintelor,
evitarea buclelor cu o complexitate mare. 

In prima functie, "rgbHistogram", am folosit functia "find" (care intoarce un
vector de indici) pentru a identifica valorile care se incadreaza in intervalelerespective, iar, mai apoi, am folosit functia length pentru a afla numarul
acestora.

Cea dea doua functie, "hsvHistogram", a fost implementata cu ajutorul
algoritmului din enuntul temei care a fost modificat pentru a fi mai eficient.
Astfel, toate operatiile au fost facute pe matrici, folosind, din nou, functia
"find" pentru evitarea buclelor. Identificarea si numararea valorilor a fost
facuta folosind procedeul din "rgbHistogram".

Functia "preprocess" este construita in mare parte din codul folosit pentru
functiile descrise mai sus, cod aplicat de aceasta data pentru mai multe
imagini, construindu-se, in acest fel, matricea X. Din cauza unor dificultati pe
care le-am intampinat am hotarat sa renunt la ideea de a apela, pur si simplu,
functiile de la task-urile 1 si 2, refolosind codul acestora.

In cadrul functiei "learn" am completat matricea X obtinuta anterior cu o
coloana de "1" si am descompus-o, folosind algoritmul Gram-Schmidt, (cunoscut
deja de pe primul semestru de la algebra si utilizat in laborator) in doua 
matrice, Q si R, prima ortonormala si cea de-a doua superior
triunghiulara. Apoi,pentru a obtine "w", am rezolvat un SST, la fel cum am
procedat in laborator.

Functia "evaluate" reia, aproape integral, operatiile facute in "preprocess" si
calculeaza procentul imaginilor care au fost clasificate corect, folosind "w"-ul
obtinut in functia "learn". Se poate observa ca acuratetea HSV este mult mai
buna ca cea RGB.
