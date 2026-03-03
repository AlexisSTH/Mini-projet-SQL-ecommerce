--- TAUX DE CONVERSION PAR STATUT
SELECT statut,
	COUNT(*) AS nombre,
    ROUND(COUNT(*)* 100.0 / (SELECT COUNT(*)FROM commandes), 2) 	AS pourcentage
from commandes
GROUP BY statut
ORDER BY nombre DESC;

--- TAUX DE LIVRAISON VS ANNULATION
SELECT 
    ROUND(SUM(CASE WHEN statut = 'livré' THEN 1 ELSE 0 END) * 100.0 
        / COUNT(*), 2) AS taux_livraison,
    ROUND(SUM(CASE WHEN statut = 'annulé' THEN 1 ELSE 0 END) * 100.0 
        / COUNT(*), 2) AS taux_annulation,
    ROUND(SUM(CASE WHEN statut = 'en cours' THEN 1 ELSE 0 END) * 100.0 
        / COUNT(*), 2) AS taux_en_cours
FROM commandes;