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

--- TAUX DE REACHAT CLIENT
SELECT 
    ROUND(COUNT(CASE WHEN nb_commandes > 1 THEN 1 END) * 100.0 
        / COUNT(*), 2) AS taux_reachat,
    COUNT(CASE WHEN nb_commandes = 1 THEN 1 END) AS clients_uniques,
    COUNT(CASE WHEN nb_commandes > 1 THEN 1 END) AS clients_fidelises,
    COUNT(*) AS total_clients
FROM (
    SELECT 
        id_client, 
        COUNT(*) AS nb_commandes
    FROM commandes
    WHERE statut = 'livré'
    GROUP BY id_client
) AS frequences;