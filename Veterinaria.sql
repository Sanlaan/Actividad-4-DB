USE veterinaria;

-- Ejercicio 4 Procedimientos sin parámetros

-- Paso 1: CREA EL PROCEDIMIENTO
DELIMITER //

CREATE PROCEDURE mostrar_todas_mascotas()
BEGIN
	SELECT
		m.id_mascota AS 'ID Mascota',
        m.nombre AS 'Nombre Mascota',
        m.especie AS 'Especie',
        m.raza AS 'Raza',
        m.edad AS 'Edad',
        m.peso AS 'Peso (kg)',
        CONCAT(p.nombre, ' ', p.apellido) AS 'Propietario',
        p.telefono AS 'Teléfono Propietario'
	FROM mascotas m
    INNER JOIN propietarios p ON m.id_propietario = p.id_propietario
    ORDER BY m.nombre;
END //
DELIMITER ;

CALL mostrar_todas_mascotas();

SHOW PROCEDURE STATUS WHERE db = 'veterinaria';

DROP PROCEDURE IF EXISTS mostrar_todas_mascotas;

-- Ejercicio 5: Procedimientos con IN

-- Paso 1: Crear el procedimiento con IN
DELIMITER //
CREATE PROCEDURE buscar_mascota_por_id(IN p_id INT)
BEGIN
    -- Validar que el ID sea válido
    IF p_id <= 0 THEN
        SELECT 'Error: El ID debe ser mayor a 0' AS 'Mensaje';
    ELSE
        -- Buscar la mascota por ID
        SELECT 
            id_mascota AS 'ID',
            nombre AS 'Nombre',
            especie AS 'Especie',
            raza AS 'Raza',
            edad AS 'Edad (años)',
            peso AS 'Peso (kg)'
        FROM mascotas 
        WHERE id_mascota = p_id;
    END IF;
END //
DELIMITER ;

CALL buscar_mascota_por_id(1);
CALL buscar_mascota_por_id(0);
 
 
-- Ejercicio 6: Procedimientos con OUT

-- Paso 1: CREAR EL PROCEDIMIENTO CON OUT
DELIMITER //
CREATE PROCEDURE contar_mascotas(OUT p_total INT)
BEGIN
	-- Contar todas las mascotas y guardar en p_total
	SELECT COUNT(*) INTO p_total
	FROM mascotas;
END //
DELIMITER ;

-- Declaramos una variable para recibir el reesultado
SET @resultado_de_contar_mascotas = 0;

-- Ejecutamos el procedimiento
CALL contar_mascotas(@resultado_de_contar_mascotas);

-- Ver el resultado
SELECT @resultado_de_contar_mascotas as 'Total de Mascotas';


-- Ejercicio 7: Procedimientos con IN y OUT

DELIMITER //

CREATE PROCEDURE actualizar_peso_mascota(IN p_id INT, INOUT p_peso DECIMAL(5,2))
BEGIN
    DECLARE peso_anterior DECIMAL(5,2) DEFAULT 0;
    DECLARE mascota_existe INT DEFAULT 0;

    -- 1. Verificamos si la mascota existe
    SELECT COUNT(*) INTO mascota_existe 
    FROM mascotas 
    WHERE id_mascota = p_id;

    IF mascota_existe = 0 THEN
        SET p_peso = -1; -- Error: mascota no encontrada
    ELSE
        -- 2. Buscamos el peso actual antes de cambiarlo
        SELECT peso INTO peso_anterior 
        FROM mascotas 
        WHERE id_mascota = p_id;

        -- 3. Actualizamos el 'peso' en la tabla 'mascotas'
        UPDATE mascotas 
        SET peso = p_peso 
        WHERE id_mascota = p_id;

        -- 4. Devolvemos el peso anterior en la misma variable
        SET p_peso = peso_anterior;
    END IF;
END //

DELIMITER ;

SELECT id_mascota, nombre, peso as 'Peso Actual' FROM mascotas;

SET @nuevo_peso = 27.8; -- Aquí cambiamos el peso a 27.8

SELECT @nuevo_peso as 'Peso que vamos a ponerle al id de la mascota';

CALL actualizar_peso_mascota(1, @nuevo_peso);

SELECT id_mascota, nombre, peso as 'nuevo peso (debe ser 27.8) ' 
FROM mascotas WHERE id_mascota = 1


-- Ejercicio 8: Procedimiento de mantenimiento
DELIMITER //

CREATE PROCEDURE agregar_nueva_mascota(
    IN p_nombre VARCHAR(50),
    IN p_especie VARCHAR(30), 
    IN p_raza VARCHAR(50),
    IN p_edad INT,
    IN p_peso DECIMAL(5,2),
    IN p_color VARCHAR(30),
    IN p_id_propietario INT
)
BEGIN
    DECLARE propietario_existe INT DEFAULT 0;

    -- 1. Validamos que el propietario exista
    SELECT COUNT(*) INTO propietario_existe
    FROM propietarios 
    WHERE id_propietario = p_id_propietario;

    IF propietario_existe = 0 THEN
        SELECT 'Error: El propietario no existe' AS Mensaje;
    ELSE
        -- 2. Insertamos la nueva mascota
        INSERT INTO mascotas (nombre, especie, raza, edad, peso, color, id_propietario)
        VALUES (p_nombre, p_especie, p_raza, p_edad, p_peso, p_color, p_id_propietario);

        SELECT 'Mascota agregada exitosamente' AS Mensaje;
    END IF;
END //

DELIMITER ;

CALL agregar_nueva_mascota('Nachito', 'Gato', 'Naranja', 2, 15.5, 'Negro', 1);

SELECT * FROM mascotas WHERE nombre = 'Nachito';


-- Ejercicio 8: Procedimiento de validación
DELIMITER //

CREATE PROCEDURE validar_edad_mascota(
    IN p_id_mascota INT, 
    OUT p_es_valida VARCHAR(50)
)
BEGIN
    DECLARE v_edad INT DEFAULT 0;
    DECLARE mascota_existe INT DEFAULT 0;

    -- Verificar si la mascota existe
    SELECT COUNT(*) INTO mascota_existe
    FROM mascotas 
    WHERE id_mascota = p_id_mascota;

    -- Si existe, obtener su edad
    IF mascota_existe > 0 THEN
        SELECT edad INTO v_edad
        FROM mascotas 
        WHERE id_mascota = p_id_mascota;
    END IF;

    -- Validar resultados
    IF mascota_existe = 0 THEN
        SET p_es_valida = 'Error: Mascota no encontrada';
    ELSEIF v_edad <= 0 THEN
        SET p_es_valida = 'Error: Edad inválida';
    ELSE
        -- Regla de negocio: máximo 25 años
        IF v_edad <= 25 THEN
            SET p_es_valida = 'Edad válida';
        ELSE
            SET p_es_valida = 'Edad muy alta (máximo 25 años)';
        END IF;
    END IF;
END //

DELIMITER ;

-- Paso 1: Asignamos el valor a la variable
SET @resultado = '';
-- Paso 2: Verificamos la edad de la mascota con ID 3
SELECT id_mascota, nombre, edad FROM mascotas WHERE id_mascota = 3;
-- Paso 3: Ejecutamos el procedimiento de validación al ID 3
CALL validar_edad_mascota(3, @resultado);
-- Paso 4: Vemos el resultado de la validación
SELECT @resultado as 'Resultado de validación';
