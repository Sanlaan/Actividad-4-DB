# 📘 Actividad 4 – Uso de CASE y Procedimientos Almacenados en SQL

En esta actividad se realizaron **ejercicios prácticos en SQL** aplicando:

- La instrucción **`CASE`** para condicionales dentro de consultas.  
- La creación, ejecución y validación de **procedimientos almacenados**.  

El propósito fue comprender cómo usar **condicionales en SQL** y cómo implementar **procedimientos que mejoran la modularidad, eficiencia y reutilización** en una base de datos.

---

## 📂 Archivos del proyecto

### 1. **`Ejercicios_fiesta.sql`**
- Se trabajó con la base de datos `fiesta_db` (creada en la Actividad 3).
- Incluye consultas que utilizan **`CASE`** para condicionar resultados, por ejemplo:
  - Mostrar mensajes personalizados dependiendo de si una persona confirmó o no.
  - Clasificar invitados como “Asistió”, “Confirmó pero no asistió” o “No asistió”.
- Permite practicar el uso de **expresiones condicionales** dentro de consultas.



### 2. **`schema_vet.sql`**
- Crea la base de datos **`veterinaria`** y su **esquema de tablas**.  
- Ejemplo de tablas incluidas:
  - `clientes` → información de clientes y sus datos de contacto.  
  - `mascotas` → datos de las mascotas (nombre, especie, edad, etc.).  
  - `citas` → registro de citas veterinarias, con fechas y estatus.  
  - `tratamientos` → catálogo de tratamientos disponibles.  
- Este archivo es la base sobre la cual se ejecutan los ejercicios y procedimientos.



### 3. **`Veterinaria.sql`**
- Archivo principal de la **actividad**.  
- Contiene:
  - **Consultas con `CASE`** para mostrar mensajes según el estado de citas o tratamientos.
  - **Procedimientos almacenados** (`CREATE PROCEDURE`) para:
    - Insertar nuevos clientes y mascotas.  
    - Consultar citas de un cliente en específico.  
    - Actualizar estados de tratamientos.  
    - Ejemplos de validaciones y modularidad de procesos.  
- Permite **ejecutar y validar procedimientos** mostrando resultados y comprobando cómo simplifican consultas repetitivas.

---

## 📌 Objetivos de la actividad

- **Comprender `CASE` en SQL** → útil para condicionales y clasificaciones dentro de consultas.
- **Introducir procedimientos almacenados** → encapsulan lógica compleja, mejorando la modularidad y eficiencia.
- **Aplicar en distintos contextos**:
  - Reutilización de `fiesta_db` para seguir trabajando con la base previa.  
  - Creación de la nueva base `veterinaria` como ejemplo práctico más completo.  

---

## 📌 Diagrama de la Base de Datos (veterinaria)
![Diagrama DB Act4](https://github.com/user-attachments/assets/aeef2e83-7436-4f27-b89a-d149fd7ac9ef)

---

## Autor
- Santiago Sebastian Rojo Márquez(@Sanlaan)
