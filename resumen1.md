# PEP1

Created: May 12, 2025 11:23 AM
Class: INFERENCIAL

| **Método / Prueba** | **¿Para qué sirve?** | **Condiciones** |
| --- | --- | --- |
| **Prueba Z para una muestra** | Contrastar si la media poblacional es igual a un valor conocido | - Observaciones independientes  - Muestra ≥ 30 o se conoce σ  - Población con distribución normal |
| **Prueba t para una muestra** | Igual que la Z, pero sin conocer σ (para n < 30) | - Observaciones independientes  - Población con distribución normal |
| **Prueba t para dos muestras independientes** | Comparar medias de dos poblaciones independientes | - Muestras independientes  - Normalidad en cada grupo  - Igualdad de varianzas (si `var.equal=TRUE`) |
| **Prueba t para muestras pareadas** | Comparar medias de dos tratamientos en los mismos sujetos o pares naturales | - Observaciones apareadas  - Distribución normal de las diferencias |

### 🔹 PRUEBA Z PARA UNA MUESTRA

**¿Para qué sirve?**

Contrasta la hipótesis sobre si la media poblacional es igual a un valor hipotético, cuando se conoce la desviación estándar de la población o el tamaño muestral es grande (n ≥ 30).

**Ejemplos de estudios:**

1. ¿Es la utilidad promedio de las empresas apoyadas por una incubadora igual a 20 millones?
2. ¿El tiempo promedio de ejecución de un algoritmo supera los 60 segundos?

**Condiciones:**

- Observaciones independientes.
- Población con distribución normal.
- Tamaño muestral ≥ 30 o se conoce σ.

**Hipótesis:**

- H₀: μ = μ₀
- Hₐ: μ ≠ μ₀ (o μ < μ₀, μ > μ₀, según el caso)

**Función en R:**

z.test(x, mu=mu_hipotetico, stdev=desv_est, conf.level=0.95)

**Interpretación:** El valor p indica si hay evidencia suficiente para rechazar H₀ al nivel α.

### 🔹 PRUEBA t DE STUDENT PARA UNA MUESTRA

**¿Para qué sirve?**

Igual que la prueba Z, pero cuando la desviación estándar poblacional no se conoce y el tamaño muestral es pequeño (n < 30).

**Ejemplos de estudios:**

1. ¿El tiempo medio de respuesta de un sistema es menor a 500 ms?
2. ¿La concentración media de un compuesto químico es 8 mg/l?

**Condiciones:**

- Observaciones independientes.
- Población con distribución normal.

**Hipótesis:**

- H₀: μ = μ₀
- Hₐ: μ ≠ μ₀

**Función en R:**

```r
r
CopyEdit
t.test(x, mu = mu_hipotetico, alternative = "two.sided")

```

**Interpretación:** Si el valor p < α, se rechaza H₀.

### 🔹 PRUEBA t PARA DOS MUESTRAS INDEPENDIENTES

**¿Para qué sirve?**

Compara las medias de dos poblaciones independientes para evaluar si existe diferencia significativa.

**Ejemplos de estudios:**

1. ¿Las vacunas A y B generan igual concentración media de anticuerpos?
2. ¿Dos métodos de enseñanza producen igual rendimiento académico?

**Condiciones:**

- Muestras independientes.
- Cada muestra cumple condiciones de uso de la t (normalidad, independencia).

**Hipótesis:**

- H₀: μ₁ = μ₂
- Hₐ: μ₁ ≠ μ₂

**Función en R:**

```r
r
CopyEdit
t.test(x1, x2, var.equal = FALSE)

```

**Interpretación:** Si p < α, se concluye diferencia significativa entre medias.

---

<aside>
💡

si α = 0.05, la confianza es 0.95 (95%).
α = 1 - confianza

</aside>

### 🔹 PRUEBA t PARA DOS MUESTRAS PAREADAS

**¿Para qué sirve?**

Contrasta medias de dos tratamientos aplicados a los mismos sujetos (antes/después, o con pares naturales).

**Ejemplos de estudios:**

1. ¿Un curso mejora el puntaje en un test antes y después de tomarlo?
2. ¿La dieta baja el colesterol tras 6 semanas?

**Condiciones:**

- Pares de datos correspondientes a los mismos sujetos.
- Diferencias siguen distribución normal.

**Hipótesis:**

- H₀: μ_d = 0 (promedio de las diferencias es cero)
- Hₐ: μ_d ≠ 0

**Función en R:**

```r
r
CopyEdit
t.test(x, y, paired = TRUE)

```

**Interpretación:** Si p < α, existe evidencia de cambio entre condiciones.

---

| **Método / Prueba** | **¿Para qué sirve?** | **Condiciones** |
| --- | --- | --- |
| **Wald para una proporción** | Evaluar si una proporción poblacional es igual a un valor específico | - Observaciones independientes   - np≥10np ≥ 10 y n(1−p)≥10n(1-p) ≥ 10 |
| **Wald para dos proporciones** | Comparar si dos proporciones poblacionales son iguales | - Muestras independientes   - Ambas proporciones cumplen condición éxito-fracaso |
| **Wilson para una proporción** | Estimar un intervalo de confianza preciso para una proporción | - Observaciones independientes   - np≥10np ≥ 10 y n(1−p)≥10n(1-p) ≥ 10 |
| **Wilson para dos proporciones** | Comparar dos proporciones con mejor precisión que Wald | - Muestras independientes   - Cada grupo cumple condición éxito-fracaso |

### 🔹 Método de Wald para una proporción

**¿Para qué sirve?**

Permite contrastar si una proporción poblacional es igual a un valor específico, asumiendo una aproximación normal.

**Ejemplos de estudios:**

1. ¿Qué proporción de algoritmos se ejecutan en menos de 25 segundos?
2. ¿Más del 70% de los clientes están satisfechos con un producto?

**Condiciones:**

- Observaciones independientes.
- Condición éxito-fracaso: np≥10np ≥ 10np≥10 y n(1−p)≥10n(1-p) ≥ 10n(1−p)≥10.

**Hipótesis:**

- H₀: p=p0p = p₀p=p0
- Hₐ: p<p0p < p₀p<p0, p>p0p > p₀p>p0 o p≠p0p ≠ p₀p=p0

**Función en R:**

No existe una función directa; se calcula manualmente.

```r
r
CopyEdit
Z <- (phat - p0) / sqrt(p0 * (1 - p0) / n)
p <- pnorm(Z, lower.tail = FALSE)

```

**Interpretación:** Si p < α, se rechaza H₀.

---

### 🔹 Método de Wald para dos proporciones

**¿Para qué sirve?**

Compara si dos proporciones poblacionales son iguales.

**Ejemplos de estudios:**

1. ¿La tasa de reprobación difiere entre hombres y mujeres en un curso?
2. ¿Dos campañas publicitarias producen igual proporción de compras?

**Condiciones:**

- Independencia entre las muestras.
- Cada proporción por separado cumple la condición de éxito-fracaso.

**Hipótesis:**

- H₀: p1=p2p_1 = p_2p1=p2
- Hₐ: p1≠p2p_1 ≠ p_2p1=p2

**Función en R:**

Se puede calcular manualmente o con `prop.test()`.

```r
r
CopyEdit
Z <- (phat1 - phat2) / sqrt(p*(1-p)*(1/n1 + 1/n2))  # con p agrupada

```

---

### 🔹 Método de Wilson para una proporción

**¿Para qué sirve?**

Proporciona intervalos de confianza más precisos para una proporción que Wald, especialmente con muestras pequeñas.

**Ejemplos de estudios:**

1. ¿Más del 70% de productos pasan el control de calidad?
2. ¿Una vacuna es efectiva en al menos 80% de los casos?

**Condiciones:**

- Igual que Wald.

**Hipótesis:**

- H₀: p=p0p = p₀p=p0
- Hₐ: p≠p0p ≠ p₀p=p0

**Función en R:**

```r
r
CopyEdit
prop.test(x = éxitos, n = n, p = p0, alternative = "greater", conf.level = 0.95)

```

---

### 🔹 Método de Wilson para dos proporciones

**¿Para qué sirve?**

Contrasta si dos proporciones son iguales, con mejor rendimiento en muestras pequeñas.

**Ejemplos de estudios:**

1. ¿Hombres y mujeres se resfrían igual tras tomar un tónico?
2. ¿Hay diferencia en votantes a favor de una ley entre dos regiones?

**Condiciones:**

- Muestras independientes.
- Condición éxito-fracaso para cada grupo.

**Hipótesis:**

- H₀: p1=p2p_1 = p_2p1=p2
- Hₐ: p1≠p2p_1 ≠ p_2p1=p2

**Función en R:**

```r
r
CopyEdit
prop.test(x = c(éxitos1, éxitos2), n = c(n1, n2), alternative = "two.sided")

```

### 🔹 **Poder estadístico (1 - β)**

**¿Para qué sirve?**

Evalúa la probabilidad de detectar un efecto real (es decir, rechazar correctamente una hipótesis nula falsa). Se utiliza para:

- Diseñar estudios con tamaño muestral suficiente.
- Interpretar si una prueba no significativa puede deberse a falta de poder y no ausencia de efecto.

### **Ejemplos de estudios y preguntas de investigación**

1. **Ejemplo 1:**
    - *Estudio:* Evaluar si un nuevo algoritmo reduce el tiempo de ejecución en problemas complejos.
    - *Pregunta:* ¿El nuevo algoritmo tarda, en promedio, menos de 60 segundos para resolver una instancia de mochila con 20.000 objetos?
2. **Ejemplo 2:**
    - *Estudio:* Determinar si una píldora mejora el promedio de notas finales.
    - *Pregunta:* ¿El consumo diario de la píldora mejora en al menos 0.5 décimas el promedio de egreso?

### **Condiciones**

- Definir correctamente las hipótesis.
- Conocer la desviación estándar y tamaño muestral.
- Tener claro el nivel de significación α y la magnitud del efecto esperado (δ).

### **Hipótesis: ejemplo para prueba Z**

- **Hipótesis nula (H₀):** La media del tiempo de ejecución del algoritmo es 60 segundos.
    
    H0:μ=60H_0: \mu = 60H0:μ=60
    
- **Hipótesis alternativa (Hₐ):** La media del tiempo de ejecución es distinta de 60 segundos.
    
    HA:μ≠60H_A: \mu \ne 60HA:μ=60
    

### **Función en R para calcular poder (usando `pwr`):**

Para prueba Z bilateral:

```r
r
CopyEdit
library(pwr)
pwr.norm.test(n = 36, d = delta / sd, sig.level = 0.05, alternative = "two.sided")

```

- `d = delta / sd`: tamaño del efecto (diferencia esperada / desviación estándar).
- `n`: tamaño muestral.
- `sig.level`: nivel de significación α.
- `alternative`: tipo de prueba ("two.sided", "less", "greater").

**Interpretación:**

El resultado indica la **potencia** (entre 0 y 1). Un valor ≥ 0.80 se considera adecuado para detectar el efecto.

| **Método / Prueba** | **¿Para qué sirve?** | **Condiciones** |
| --- | --- | --- |
| **Prueba exacta de Fisher** | Evaluar si existe asociación entre dos variables categóricas binarias (2×2) | - Variables dicotómicas (2 niveles)  - Observaciones independientes  - Muestras pequeñas o con celdas con frecuencias ≤ 5 |

### 🔹 **Prueba exacta de Fisher**

**¿Para qué sirve?**

Evalúa si hay **asociación entre dos variables categóricas binarias** (dicotómicas), especialmente con **muestras pequeñas** o cuando las frecuencias observadas son muy bajas (incluso cero).

---

### **Ejemplos de estudios y preguntas de investigación**

1. **Estudio:** Comparar la efectividad de dos vacunas contra mordeduras de vampiro.
    - *Pregunta:* ¿El tipo de vacuna recibida (Argh vs Grrr) influye en si una persona se convierte en vampiro?
2. **Estudio:** Determinar si hay relación entre el género y aprobar un curso de estadística.
    - *Pregunta:* ¿Existe asociación entre el género del estudiante y su resultado (aprobado/reprobado)?

---

### **Condiciones**

- Dos variables categóricas **binarias** (sí/no, éxito/fracaso, etc.).
- Observaciones **independientes**.
- Tamaño muestral pequeño o alguna celda con frecuencias < 5 o igual a 0.
- Las sumas marginales (totales por fila y columna) están fijas.

---

### **Hipótesis**

- **Hipótesis nula (H₀):** Las variables son independientes (no hay asociación).
    
    *Ejemplo:* El resultado de la mordida (vampiro/humano) no depende de la vacuna recibida.
    
- **Hipótesis alternativa (Hₐ):** Las variables están asociadas.
    
    *Ejemplo:* El resultado de la mordida depende de la vacuna recibida.
    

---

### **Función en R**

```r
r
CopyEdit
fisher.test(matrix)

```

**Ejemplo en R:**

```r
r
CopyEdit
# Matriz de 2x2: filas = resultado, columnas = vacuna
tabla <- matrix(c(0, 5, 6, 6), nrow = 2, byrow = TRUE)
fisher.test(tabla)

```

**Interpretación del resultado:**

- El valor `p-value` indica si se rechaza H₀.
- Si `p < α`, se concluye que **hay asociación significativa** entre las dos variables.
- Si `p ≥ α`, no se rechaza H₀; **no hay evidencia de asociación**.

### 🔹 **Prueba de McNemar** (Capítulo 8)

**¿Para qué sirve?**

Detectar cambios en proporciones en estudios con datos pareados dicotómicos (pre/post o pruebas repetidas sobre el mismo grupo).

**Ejemplos:**

1. ¿Cambió el diagnóstico de una enfermedad después de aplicar un nuevo test?
2. ¿Mejoró el rendimiento tras un curso de capacitación?

**Condiciones:**

- Dos medidas dicotómicas (sí/no) en los mismos sujetos.
- Datos apareados.
- Interés en discordancias.

**Hipótesis:**

- H₀: No hay cambio significativo (proporciones iguales).
- Hₐ: Sí hay cambio significativo.

**Función en R:**

```r
r
CopyEdit
mcnemar.test(tabla, correct = FALSE)
```

### 🔹 **Prueba Q de Cochran** (Capítulo 8)

**¿Para qué sirve?**

Extensión de McNemar a más de dos tratamientos (medidas dicotómicas en múltiples condiciones).

**Ejemplos:**

1. ¿Hay diferencia en el éxito entre tres algoritmos de optimización?
2. ¿Distintas vacunas generan igual proporción de inmunidad?

**Condiciones:**

- Variable respuesta dicotómica.
- Medidas repetidas en tres o más condiciones.
- Datos pareados.

**Hipótesis:**

- H₀: Proporciones iguales en todas las condiciones.
- Hₐ: Al menos una difiere.

**Función en R:**

No base, pero implementable con paquetes como `rcompanion` o `DescTools`.

---

### 🔹 **Wilcoxon Rank Sum (Mann-Whitney U)** (Capítulo 11)

**¿Para qué sirve?**

Comparar si dos muestras independientes tienen igual tendencia central (mediana).

**Ejemplos:**

1. ¿Dos interfaces de software tienen igual usabilidad percibida?
2. ¿Los tiempos de respuesta difieren entre dos servidores?

**Condiciones:**

- Escala ordinal o superior.
- Muestras independientes.

**Hipótesis:**

- H₀: No hay diferencia de ubicación (medianas iguales).
- Hₐ: Hay diferencia.

**Función en R:**

```r
r
CopyEdit
wilcox.test(x, y, paired = FALSE)

```

### 🔹 **ANOVA de una vía (muestras independientes)**

- **ANOVA es un procedimiento ómnibus**, lo que implica que **si se encuentra diferencia significativa**, se **requiere un análisis post-hoc** para determinar **dónde** están las diferencias (entre qué pares de grupos).
- El análisis post-hoc más utilizado y sugerido es **Tukey HSD** (honestly significant difference), pero el desarrollo técnico de este método **se deja implícito** y **no se profundiza** en el capítulo.

**¿Para qué sirve?**

Contrasta si existen diferencias significativas entre las medias de **tres o más grupos independientes**. Es una generalización de la prueba t para más de dos grupos.

---

### **Ejemplos de estudios y preguntas de investigación**

1. **Estudio:** Evaluar si tres algoritmos distintos difieren en su tiempo promedio de ejecución.
    - *Pregunta:* ¿Existe diferencia en los tiempos promedio requeridos por los algoritmos A, B y C para resolver el mismo problema?
2. **Estudio:** Comparar la efectividad de tres métodos de enseñanza.
    - *Pregunta:* ¿Hay diferencia significativa en el rendimiento académico promedio entre los estudiantes que usaron los métodos 1, 2 y 3?

---

### **Condiciones**

- La variable dependiente se mide en escala de intervalos iguales (o de razón).
- Muestras independientes y aleatorias.
- Normalidad en cada grupo (comprobada con gráficos Q-Q o prueba de Shapiro-Wilk).
- Homogeneidad de varianzas entre los grupos (por ejemplo, ratio máx/mín ≤ 1.5).

---

### **Hipótesis**

- **Hipótesis nula (H₀):** Las medias de los grupos son iguales.
    
    H0:μ1=μ2=μ3=⋯=μkH_0: \mu_1 = \mu_2 = \mu_3 = \dots = \mu_kH0:μ1=μ2=μ3=⋯=μk
    
- **Hipótesis alternativa (Hₐ):** Al menos una media difiere de las otras.
    
    HA:∃ i,j ∣ μi≠μjH_A: \exists\ i, j\ |\ \mu_i \ne \mu_jHA:∃ i,j ∣ μi=μj
    

---

### **Función en R**

```r
r
CopyEdit
aov(resultado ~ grupo, data = datos)
summary(modelo)

```

**Ejemplo en R:**

```r
r
CopyEdit
datos <- data.frame(
  tiempo = c(23,19,25,23,20, 26,24,28,23,29, 19,24,20,21,17),
  algoritmo = factor(rep(c("A", "B", "C"), each = 5))
)

modelo <- aov(tiempo ~ algoritmo, data = datos)
summary(modelo)

```

**Interpretación del resultado:**

- Si el valor `Pr(>F)` del resumen es menor que α, se **rechaza H₀**.
- Se concluye que **al menos un grupo difiere significativamente en su media**.
- Si se rechaza H₀, se puede aplicar un **post-hoc** (TukeyHSD) para identificar entre qué grupos están las diferencias:
    
    ```r
    r
    CopyEdit
    TukeyHSD(modelo)
    
    ```
    

### 🔹 **ANOVA de una vía para muestras correlacionadas (medidas repetidas)**

**¿Para qué sirve?**

Permite contrastar si existen diferencias significativas entre tres o más tratamientos aplicados a los mismos sujetos o unidades (diseño de medidas repetidas o bloques aleatorios). Controla la variabilidad entre individuos.

---

### **Ejemplos de estudios y preguntas de investigación**

1. **Estudio:** Comparar el rendimiento de 4 algoritmos aplicados a las mismas instancias.
    - *Pregunta:* ¿Existe diferencia significativa entre los tiempos de ejecución promedio de Quicksort, Bubblesort, Mergesort y Radixsort al ordenar los mismos arreglos?
2. **Estudio:** Medir el avance académico de estudiantes en distintos niveles escolares.
    - *Pregunta:* ¿Hay diferencia significativa en la estatura promedio de estudiantes al comenzar 7º básico, 8º básico y 1º medio?

---

### **Condiciones**

- Variable dependiente con escala de intervalos iguales (o razón).
- Observaciones independientes dentro de cada nivel.
- Suposición razonable de normalidad para las mediciones.
- Esfericidad: varianzas de las diferencias entre todos los pares de niveles deben ser iguales.

---

### **Hipótesis**

- **Hipótesis nula (H₀):** Las medias de los tratamientos (medidas repetidas) son iguales.
    
    H0:μ1=μ2=μ3=⋯=μkH_0: \mu_1 = \mu_2 = \mu_3 = \dots = \mu_kH0:μ1=μ2=μ3=⋯=μk
    
- **Hipótesis alternativa (Hₐ):** Al menos una media difiere.
    
    HA:∃ i,j ∣ μi≠μjH_A: \exists\ i, j\ |\ \mu_i \ne \mu_jHA:∃ i,j ∣ μi=μj
    

---

### **Función en R**

Usando el paquete `ez` con datos en formato largo:

```r
r
CopyEdit
library(ez)
ezANOVA(data = datos_largos, dv = .(variable_dependiente),
        wid = .(id_sujeto), within = .(condicion), detailed = TRUE)

```

**Ejemplo:**

```r
r
CopyEdit
library(ez)
datos_largos <- pivot_longer(datos_anchos, -Instancia, names_to = "Algoritmo", values_to = "Tiempo")
ezANOVA(data = datos_largos, dv = .(Tiempo), wid = .(Instancia), within = .(Algoritmo), detailed = TRUE)

```

**Interpretación del resultado:**

- Si el valor p asociado al efecto principal es < α, se **rechaza H₀**.
- Concluimos que **al menos un tratamiento difiere en promedio**.
- Se puede realizar análisis post-hoc con `emmeans` para explorar las diferencias entre pares de niveles.

### 🔹 **Transformaciones de datos**

Este capítulo **no introduce nuevas pruebas estadísticas**, sino **métodos de transformación de variables numéricas** que **no cumplen las condiciones necesarias para pruebas paramétricas** (como normalidad o linealidad).

---

### 1. **Transformación lineal**

**¿Para qué sirve?**

Para **cambiar unidades de medida** sin alterar la forma de la distribución (escalado o traslación).

**Ejemplos de estudios:**

1. ¿La temperatura media en Santiago supera los 20 °C (convertida a °F)?
    - *Pregunta:* ¿La temperatura media diaria en verano es mayor a 68 °F?
2. ¿Un sensor de presión calibrado en psi equivale a una media de 2 bar?
    - *Pregunta:* ¿La presión media registrada es igual a 2 bar?

**Condiciones:**

- Escala numérica continua
- Se conoce la relación entre unidades

**Hipótesis:**

(No cambia la prueba estadística, solo se transforma la escala).

**Función en R:**

```r
r
CopyEdit
nueva_variable <- m * original + n

```

---

### 2. **Transformación logarítmica**

**¿Para qué sirve?**

Reducir la **asimetría positiva** de una variable y acercarla a una distribución normal.

Utilizada antes de aplicar pruebas que requieren normalidad (t, ANOVA).

**Ejemplos de estudios:**

1. ¿La media del logaritmo del ingreso mensual es mayor a 10?
    - *Pregunta:* ¿El ingreso promedio, después de log-transformar, supera cierto umbral?
2. ¿Los pesos de cerebros en especies animales muestran correlación logarítmica con el peso corporal?
    - *Pregunta:* ¿Existe relación lineal entre log(peso corporal) y log(peso cerebral)?

**Condiciones:**

- Valores positivos (no se puede aplicar log a cero o negativos).
- Asimetría positiva evidente en la variable original.

**Hipótesis (ejemplo):**

- H0:μlog⁡(x)=2H_0: \mu_{\log(x)} = 2H0:μlog(x)=2
- HA:μlog⁡(x)>2H_A: \mu_{\log(x)} > 2HA:μlog(x)>2

**Función en R:**

```r
r
CopyEdit
log(x)  # o log10(x) si se quiere base 10

```

---

### 3. **Escalera de potencias de Tukey**

**¿Para qué sirve?**

Explorar distintas potencias (λ) para transformar una variable y **aproximarla a la normalidad**.

Se usa para ajustar mejor la forma de la distribución o linealizar relaciones.

**Ejemplos de estudios:**

1. ¿Qué transformación aproxima mejor la distribución de la población de EE.UU. entre 1610-1850?
2. ¿Qué transformación permite linealizar la relación entre ingresos y gastos en un estudio económico?

**Condiciones:**

- Datos numéricos y positivos
- Se busca aproximar a normalidad o mejorar relaciones funcionales

**Hipótesis (implícita):**

- H0:Distribucioˊn transformada sigue siendo no normalH_0: \text{Distribución transformada sigue siendo no normal}H0:Distribucioˊn transformada sigue siendo no normal
- HA:Distribucioˊn transformada se asemeja a normalH_A: \text{Distribución transformada se asemeja a normal}HA:Distribucioˊn transformada se asemeja a normal

**Función en R:**

```r
r
CopyEdit
library(rcompanion)
transformTukey(x)

```

### 🔹 **Wilcoxon Signed Rank (con signo)** (Capítulo 11)

**¿Para qué sirve?**

Comparar dos tratamientos en muestras pareadas cuando no se puede asumir normalidad.

**Ejemplos:**

1. ¿La presión arterial cambia tras una dieta?
2. ¿El desempeño mejora con una nueva metodología?

**Condiciones:**

- Muestras pareadas.
- Diferencias simétricas respecto a cero.

**Hipótesis:**

- H₀: La mediana de las diferencias es cero.
- Hₐ: La mediana difiere de cero.

**Función en R:**

```r
r
CopyEdit
wilcox.test(x, y, paired = TRUE)

```

| **Prueba no paramétrica** | **¿Para qué sirve?** | **Condiciones** |
| --- | --- | --- |
| **Prueba exacta de Fisher** | Evaluar asociación entre dos variables dicotómicas en tablas 2×2 | - Variables binarias  - Observaciones independientes  - Muestra pequeña o frecuencias esperadas < 5 |
| **Prueba de McNemar** | Evaluar cambios en proporciones dicotómicas con datos pareados (pre/post o condiciones repetidas) | - Variable binaria  - Datos apareados  - Enfoque en discordancias |
| **Prueba Q de Cochran** | Extensión de McNemar para ≥3 tratamientos en muestras pareadas con variable dicotómica | - Variable binaria  - Muestras apareadas  - ≥ 3 tratamientos o condiciones |
| **Wilcoxon rank sum** | Comparar dos grupos independientes (alternativa no paramétrica a t de Student independiente) | - Escala ordinal o superior  - Muestras independientes  - No requiere normalidad |
| **Wilcoxon signed rank** | Comparar dos condiciones en muestras apareadas (alternativa a t de muestras pareadas) | - Datos pareados  - Diferencias simétricas respecto a 0  - Escala ordinal o superior |