function y = winograd(x, h)
    % Valido que efectivamente el filtro sea multiplo de 3 antes de
    % comenzar
    assert(mod(length(h), 3) == 0, 'El largo del filtro debe ser múltiplo de 3');

    % Parámetros del algoritmo original F(2,3)
    r = 3; % Largo del subfiltro
    m = 2; % Cantidad de salidas por iteración
    n = m + r - 1;  % Largo del tramo de entrada: 4

    % Guardo los largos originales para corte final
    largo_original_x = length(x);
    largo_original_h = length(h);

    % Cero padding de el x para ajustar el h cuando sea invertido
    x = [zeros(1,2), x];

    % Verifico que h sea multiplo de 3
    % Agrego cero padding para ajustar
    if mod(length(h), 3) ~= 0
        h = [h, zeros(1, 3 - mod(length(h), 3))];
    end

    % Verifico que x sea multiplo de 4
    % Agrego cero padding para ajustar
    if mod(length(x), 4) ~= 0
        x = [x, zeros(1, 4 - mod(length(x), 4))];
    end

    % largo de la salida
    largo_salida = length(x) + length(h) - 1;
    y = zeros(1, largo_salida);  % Salida seteada en lista de ceros

    % Se invierte h para aplicar convolución
    h = fliplr(h);

    % Cuántos bloques de 3 tiene el filtro
    num_bloques_h = length(h) / r;

    % por cada bloque h filtro sobre la señal x:
    for i = 1:num_bloques_h
        % Separo el filtro en una sublista de 3 elementos
        g = h((i-1)*r + 1 : i*r);

        % Para este subfiltro, recorro la señal en x tramos de sublistas de
        % 4 elementos
        num_tramos_x = floor((length(x) - n) / m) + 1;
        for j = 1:num_tramos_x
            % Índice de inicio del bloque actual de la señal de 4 elementos
            % en la sub-señal de x
            bloque_x = (j - 1)*m + 1;
            if bloque_x + 3 > length(x)
                continue;  % Por si salgo del rango de 3
            end
            d = x(bloque_x : bloque_x + 3);

            % Se obtiene y_local (1) e y_local(2) desde Winograd F(2,3)
            % original, de forma que trabajaremos con el algoritmo original
            y_local = winograd_23(d, g);

            % Calcula la posición donde sumar los resultados
            % Desfase por el filtro para obtener la posición del sub-filtro de h
            desfase_h = length(h) - (i * 3);
            % Índice de y donde se acumula y_local(1) y y_local(2)
            y_acum = bloque_x + desfase_h;

            % Suma los 2 valores generados y_local(1) y y_local(2) 
            % tal que es la señal de la salida acomulada para guardarse
            % en la señal de salida
            if y_acum + 0 <= largo_salida
                y(y_acum) = y(y_acum) + y_local(1);
            end
            if y_acum + 1 <= largo_salida
                y(y_acum + 1) = y(y_acum + 1) + y_local(2);
            end
        end
    end

    % Me aseguro que y tenga largo m + r - 1
    y = y(1 : largo_original_x + largo_original_h - 1);
end

% instancia original del algoritmo F(2,3), extraida para ser utilizada
% iterativamente
function y = winograd_23(d, g)
    % Transformación de entrada con Bᵗ
    % El equivalemte simplificado, equivalente a Bᵗ * d
    u1 = d(1) - d(3);
    u2 = d(2) + d(3);
    u3 = d(3) - d(2);
    u4 = d(2) - d(4);

    % aplicacion del filtro  G * g, el equivalemte simplificado
    g1 = (g(1) + g(2) + g(3)) / 2;  
    g2 = (g(1) - g(2) + g(3)) / 2;

    % Multiplicación elemento a elemento, el equivalente a U ∘ V
    % tal que con el filtro que es V = G * g
    v1 = u1 * g(1);
    v2 = u2 * g1;
    v3 = u3 * g2;
    v4 = u4 * g(3);

    % versión simplificada de Aᵗ * M
    y1 = v1 + v2 + v3;
    y2 = v2 - v3 - v4;
    y = [y1, y2];
end


%100 repeticiones para obtener el promedio de error de Winograd vs conv y
%Toeplitz
n = 100;
total_error_conv = 0;
total_error_toep = 0;

for i = 1:n
    x = 2 * rand(1, 8) - 1;
    h = 2 * rand(1, 6) - 1;
    
    %se obtiene y con winegrad, conv y toeplitz
    y_win = winograd(x, h);
    y_conv = conv(x, h);
    HT = toeplitz([h(:); zeros(length(x)-1, 1)], [h(1), zeros(1, length(x)-1)]);
    y_toep = (HT * x(:))';

    % Error promedio por prueba
    total_error_conv = total_error_conv + mean(abs(y_win - y_conv));
    total_error_toep = total_error_toep + mean(abs(y_win - y_toep));
end

promedio_error_conv = total_error_conv / n;
promedio_error_toep = total_error_toep / n;

disp("Error promedio por prueba con conv():   " + promedio_error_conv);
disp("Error promedio por prueba con Toeplitz: " + promedio_error_toep);


% Para probar la eficiencia en el tiempo de Winograd vs Toeplitz
% Rango de tamaños: 2^3 a 2^13
N = 2.^(3:13);
%listas donde se guardará por cada iteración el tiempo que se demoran las
%funciones
t_win = zeros(size(N));
t_toep = zeros(size(N));

% Filtro fijo de largo 6
h0 = 2 * rand(1, 6) - 1;
%iteraciones tal que N es la longitud de la señal
for i = 1:length(N)
    x0 = 2 * rand(1, N(i)) - 1;

    % toma de tiempo por funcion
    f_win = @() winograd(x0, h0);
    f_toe = @() toeplitz([h0(:); zeros(length(x0)-1, 1)], [h0(1), zeros(1, length(x0)-1)]) * x0(:);

    t_win(i) = timeit(f_win);
    t_toep(i) = timeit(f_toe);
end
figure;
semilogy(1:length(N), t_win, '-o', 'DisplayName', 'Winograd');
hold on;
semilogy(1:length(N), t_toep, '-x', 'DisplayName', 'Toeplitz');
xlabel('Tamaño de la señal x[n] (2^i)');
ylabel('Tiempo de ejecución (segundos, escala logarítmica)');
title('Comparación de tiempo (escala log): Winograd vs Toeplitz');
legend('Location', 'northwest');
grid on;

% Vector de etiquetas como celdas de texto
labels = {'2^{3}', '2^{4}', '2^{5}', '2^{6}', '2^{7}', ...
          '2^{8}', '2^{9}', '2^{10}', '2^{11}', '2^{12}', '2^{13}'};

% Aplicar al gráfico
set(gca, 'XTick', 1:length(labels));
set(gca, 'XTickLabel', labels);
set(gca, 'TickLabelInterpreter', 'tex');  % Para que los superíndices se vean bien

