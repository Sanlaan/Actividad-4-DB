use fiesta_db;
-- Ejercicio 1 CASE SIMPLE

select
	nombre,
    apellido,
    metodo_invitacion,
    case metodo_invitacion
		when 'WhatsApp' then '📱 Mensaje'
        when 'Email' then '📧 Correo'
        when 'Llamada' then '☎️ Teléfono'
        when 'En persona' then '👥 Cara a cara'
        else '❓ Desconocido'
	end as tipo_invitacion
from personas p
join invitados i on p.id_persona = i.id_persona;

-- Ejercio 2 CASE SEARCHED

select
	p.nombre,
    p.apellido,
    c.estado as confirmacion,
    case
		when c.estado = 'Confirma' then '✅ Viene seguro'
        when c.estado = 'No puede' then '✖️ No puede venir'
        when c.estado = 'Tal vez' then '🤔 Tal vez viene'
        when c.estado is null then '😶 Sin repuesta'
		else '❓ Estado raro'
	end as situacion
from personas p
left join confirmaciones c on p.id_persona = c.id_persona
where p.id_persona in (select id_persona from invitados);

-- Ejercio 3 CASE SEARCHED
        
SELECT
	p.nombre,
    p.apellido,
    i.metodo_invitacion,
    c.estado
FROM personas p
LEFT JOIN invitados i ON p.id_persona = i.id_persona
LEFT JOIN confirmaciones c ON p.id_persona = c.id_persona
WHERE
	CASE
		WHEN i.metodo_invitacion = 'WhatsApp' THEN c.estado = 'Confirma'
        WHEN i.metodo_invitacion = 'Email' THEN c.estado IN ('Confirma', 'Tal vez')
        ELSE TRUE
	END;
    
    
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
