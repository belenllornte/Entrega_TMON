p = [7/16, 4/16, 2/16, 3/16]; % funcion de masa de probabilidad
m = 4; % Número de intervalos
probabilidad_acumulada = cumsum(p); 
% probabilidad_acumulada =[0.4375 , 0.6875 , 0.8125 , 1.0000] = [7/16, 11/16, 13/16, 1]

q = zeros(1, m); % hay que darle lugar a q y se irá actualizando con el bucle
for j = 0:(m-1)
    % Encontrar el mínimo i tal que probabilidad_acumulada(i) >= j/m
    % j/m ={0,0.25,0.5,0.75}
    q(j+1) = find(probabilidad_acumulada >= j/m, 1); % si miramos el help de find(X,n), devuelve los n primeros elementos (por eso 1 pq queremos el menor indice que va a ir buscando en la lista de prob. acumulada) y el X puedes ponerle condiciones como es nuestro caso, ej: X<10
    %podemos poner X=[1,3,5,7,9], find(X>4,2) , nos devuelve los primeros
    %dos índices de los valores (posiciones en el vector) del vector X que
    %sean mayores que 4, es decir, en este caso serían los nº 5 y 7 que tiene
    %posicion 3 y 4, nos devolvería entonces 3 y 4.
end
% se nos queda así q=[1,1,2,3]

% simulacion para una sola observación con U = 15/32 -- lo que nos pide el
% ejercicio (o eso creo :)
U = 15/32;
j = floor(m * U); % j=[mU]
i = q(j + 1);     % i=q_j, MATLAB usa índices desde 1, por eso sumamos 1

while sum(p(1:i)) <= U
    i = i + 1;
end

% solución
X = i;
fprintf('El valor de X simulado para U=15/32: %d\n', i)


% ------------------------------------------------------------------ extra 

% Podriamos hacer una simulacion de 1000 observaciones por ejemplo???

n=1000; % nº de simulaciones
simulaciones_uniforme= rand(n,1); 
m=4;

X_simulada = zeros(n, 1); % Prealocar espacio para las simulaciones

for j_indice = 1:n
    U=rand(); % un numero aleatorio de la uniforme, es decir, entre 0 y 1
    j = floor(m * U);
    i = q(j + 1);
    while sum(p(1:i)) <= U
    i = i + 1;
    end
    X_simulada(j_indice)=i;
end

tabulate(X_simulada) % Muestra la frecuencia de cada valor en X