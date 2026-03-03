--- TAUX DE CONVERSION PAR STATUT
SELECT statut,
	COUNT(*) AS nombre,
    ROUND(COUNT(*)* 100.0 / (SELECT COUNT(*)FROM commandes), 2) 	AS pourcentage
from commandes
GROUP BY statut
ORDER BY nombre DESC;

--- TAUX DE CONVERSION PAR PRODUIT
SELECT 
    p.nom_produit,
    p.categorie,
    COUNT(DISTINCT c.id_commande) AS total_commandes,
    SUM(CASE WHEN c.statut = 'livré' THEN 1 ELSE 0 END) AS livrees,
    SUM(CASE WHEN c.statut = 'annulé' THEN 1 ELSE 0 END) AS annulees,
    ROUND(SUM(CASE WHEN c.statut = 'livré' THEN 1 ELSE 0 END) * 100.0 
        / COUNT(DISTINCT c.id_commande), 2) AS taux_conversion
FROM commandes c
JOIN details_commandes dc ON c.id_commande = dc.id_commande
JOIN produits p ON dc.id_produit = p.id_produit
GROUP BY p.id_produit, p.nom_produit, p.categorie
ORDER BY taux_conversion DESC;

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