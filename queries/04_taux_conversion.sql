--- TAUX DE CONVERSION PAR STATUT
SELECT statut,
	COUNT(*) AS nombre,
    ROUND(COUNT(*)* 100.0 / (SELECT COUNT(*)FROM commandes), 2) 	AS pourcentage
from commandes
GROUP BY statut
ORDER BY nombre DESC;