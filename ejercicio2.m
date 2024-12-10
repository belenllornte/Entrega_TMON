rng(42); % Fijamos la semilla para reproducibilidad

% Definición de la función a integrar
f = @(x) (x + 3) ./ (3 * x.^4 + 2 * x.^2 + 1);

% Límites de integración
a = -10; % Usamos un intervalo grande para simular infinito
b = 10;

% Valor exacto de la integral
valor_exacto = integral(f, -inf, inf);

% Número de iteraciones y tamaños de muestra
iters = 10;
N1 = 1000; 
N2 = 10000;

% Vectores para almacenar aproximaciones
aproximaciones_N1 = zeros(1, iters);
aproximaciones_N2 = zeros(1, iters);

% Monte Carlo para diferentes iteraciones
for k = 1:iters
    % Generación de muestras aleatorias en [a, b]
    X1 = a + (b - a) * rand(1, N1);
    X2 = a + (b - a) * rand(1, N2);

    % Evaluación de la función
    f_X1 = f(X1);
    f_X2 = f(X2);

    % Cálculo de las aproximaciones
    aproximaciones_N1(k) = (b - a) * mean(f_X1);
    aproximaciones_N2(k) = (b - a) * mean(f_X2);

    % Incrementar muestras
    N1 = N1 * 2;
    N2 = N2 * 2;
end

% Mostrar resultados finales
fprintf('Valor exacto de la integral: %.6f\n', valor_exacto);
fprintf('Aproximación final para N inicial=1000: %.6f\n', aproximaciones_N1(end));
fprintf('Aproximación final para N inicial=10000: %.6f\n', aproximaciones_N2(end));

% Gráficos de dispersión
figure (1)
scatter(X1, f_X1, 'b.');
title('Dispersión de puntos generados');
xlabel('X');
ylabel('f(X)');
legend('N inicial=1000', 'Location', 'best');
grid on;

figure (2)
scatter(X2, f_X2, 'r.');
title('Dispersión de puntos generados');
xlabel('X');
ylabel('f(X)');
legend('N inicial=10000', 'Location', 'best');
grid on;

% Gráfica de aproximaciones
figure (3)
plot(1:iters, aproximaciones_N1, '-o', 'LineWidth', 2, 'MarkerSize', 6, 'DisplayName', 'N inicial=1000');
hold on;
plot(1:iters, aproximaciones_N2, '-s', 'LineWidth', 2, 'MarkerSize', 6, 'DisplayName', 'N inicial=10000');
yline(valor_exacto, 'g--', 'LineWidth', 2, 'DisplayName', 'Valor exacto');
title('Aproximaciones sucesivas de Monte Carlo');
xlabel('Iteración');
ylabel('Valor de la integral');
legend('Location', 'best');
grid on;