--- TOP CLIENTS
SELECT cl.nom, cl.ville, 
	COUNT(DISTINCT c.id_commande) AS nb_commandes,
    ROUND(SUM(dc.prix_unitaire * dc.quantite), 2) AS total_depense
FROM clients cl
JOIN commandes c ON cl.id_client = c.id_client
JOIN details_commandes dc ON c.id_commande = dc.id_commande
WHERE c.statut = 'livré'
GROUP BY cl.id_client, cl.nom, cl.ville
ORDER BY total_depense DESC;

--- PANIER MOYEN PAR CLIENT 
SELECT 
    c.nom,
    COUNT(DISTINCT co.id_commande) AS nb_commandes,
    ROUND(SUM(dc.prix_unitaire * dc.quantite), 2) AS ca_total,
    ROUND(SUM(dc.prix_unitaire * dc.quantite) / 
        COUNT(DISTINCT co.id_commande), 2) AS panier_moyen
FROM clients c
JOIN commandes co ON c.id_client = co.id_client
JOIN details_commandes dc ON co.id_commande = dc.id_commande
WHERE co.statut = 'livré'
GROUP BY c.id_client, c.nom
ORDER BY panier_moyen DESC
LIMIT 10;

--- clients qui commandent le plus souvent 
SELECT 
    c.nom,
    COUNT(DISTINCT co.id_commande) AS nb_commandes,
    DATEDIFF(MAX(co.date_commande), 
             MIN(co.date_commande)) AS jours_entre,
    ROUND(DATEDIFF(MAX(co.date_commande), 
        MIN(co.date_commande)) / 
        COUNT(DISTINCT co.id_commande), 0) AS jours_entre_commandes
FROM clients c
JOIN commandes co ON c.id_client = co.id_client
WHERE co.statut = 'livré'
GROUP BY c.id_client, c.nom
HAVING nb_commandes > 1
ORDER BY jours_entre_commandes ASC
LIMIT 10;