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