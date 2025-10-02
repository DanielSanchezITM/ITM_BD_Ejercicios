
-- a. ¿Cuántas canciones ha compuesto “JUANES”?

SELECT *
	FROM Cancion

SELECT COUNT(*) AS TotalCanciones
FROM CancionCompositor cc
JOIN Compositor c ON cc.IdCompositor = c.Id
WHERE CHARINDEX('JUANES', c.Nombre) > 0;

--b.¿Qué interpretaciones se tienen de la canción “Lluvia” y en qué ritmos?

SELECT i.Nombre AS Interprete, r.Ritmo
FROM Interpretacion interp
JOIN Cancion c ON interp.IdCancion = c.Id
JOIN Interprete i ON interp.IdInterprete = i.Id
JOIN Ritmo r ON interp.IdRitmo = r.Id
WHERE c.Titulo = 'Lluvia';

--c. ¿Qué canciones hay con el mismo Intérprete y Compositor del ritmo “Balada”?

SELECT DISTINCT c.Titulo AS Cancion
FROM Cancion c
JOIN Interpretacion i ON c.Id = i.IdCancion
JOIN Ritmo r ON i.IdRitmo = r.Id
JOIN Interprete it ON i.IdInterprete = it.Id
JOIN Tipo t ON it.IdTipo = t.Id
JOIN CancionCompositor cc ON c.Id = cc.IdCancion
JOIN Compositor comp ON cc.IdCompositor = comp.Id
WHERE r.Ritmo = 'Balada'
  AND t.Tipo = 'Solista'
  AND CHARINDEX(it.Nombre, comp.Nombre) > 0;

  --d. Listar los países que tienen grupos del ritmo “Salsa”

  SELECT DISTINCT p.Pais
FROM Interpretacion i
JOIN Ritmo r ON i.IdRitmo = r.Id
JOIN Interprete it ON i.IdInterprete = it.Id
JOIN Tipo t ON it.IdTipo = t.Id
JOIN Pais p ON it.IdPais = p.Id
WHERE r.Ritmo = 'Salsa'
  AND t.Tipo = 'Grupo';

  --e.¿Quiénes interpretan las canciones “Candilejas” y “Malaguena”?
 
 SELECT c.Titulo AS Cancion, i.Nombre AS Interprete
FROM Cancion c
JOIN Interpretacion interp ON c.Id = interp.IdCancion
JOIN Interprete i ON interp.IdInterprete = i.Id
WHERE c.Titulo IN ('Candilejas', 'Malaguena');

--f.Listar artistas que son intérpretes y compositores a la vez y con cuantas canciones compuestas e interpretadas

SELECT
    i.Nombre AS Artista,
    COUNT(DISTINCT cc.IdCancion) AS CancionesCompuestas,
    COUNT(DISTINCT interp.IdCancion) AS CancionesInterpretadas
FROM Interprete i
JOIN Compositor c ON CHARINDEX(i.Nombre, c.Nombre) > 0
LEFT JOIN CancionCompositor cc ON c.Id = cc.IdCompositor
LEFT JOIN Interpretacion interp ON i.Id = interp.IdInterprete
GROUP BY i.Nombre;