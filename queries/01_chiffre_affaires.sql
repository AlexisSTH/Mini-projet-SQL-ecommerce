--- chiffre d'affaires total
SELECT
	ROUND(SUM(dc.prix_unitaire * dc.quantite), 2) AS chiffre_affaire_total
FROM details_commandes dc
JOIN commandes c on dc.id_commande = c.id_commande
WHERE c.statut = 'livré';

--- chiffre d'affaires par mois 
SELECT
DATE_FORMAT(c.date_commande, '%Y-%m') AS mois,
ROUND(SUM(dc.prix_unitaire * dc.quantite), 2) AS ca_mensuel
FROM details_commandes dc
JOIN commandes c ON dc.id_commande = c.id_commande
WHERE c.statut = 'livré'
GROUP BY DATE_FORMAT(c.date_commande, '%Y-%m')
ORDER BY mois;

