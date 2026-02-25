--- Produit les plus vendus
SELECT p.nom_produit, p.categorie,
	SUM(dc.quantite) AS quantite_vendue, 
    ROUND(SUM(dc.prix_unitaire * dc.quantite), 2) AS revenus
FROM produits p
JOIN details_commandes dc ON p.id_produit = dc.id_produit
JOIN commandes c ON dc.id_commande = c.id_commande
WHERE c.statut = 'livré'
GROUP BY p.id_produit, p.nom_produit, p.categorie
ORDER BY quantite_vendue DESC;