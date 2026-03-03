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

--- TOP PRODUIT PAR CATEGORIE
SELECT 
    categorie,
    nom_produit,
    quantite_vendue,
    ca_total
FROM (
    SELECT 
        p.categorie,
        p.nom_produit,
        SUM(dc.quantite) AS quantite_vendue,
        ROUND(SUM(dc.prix_unitaire * dc.quantite), 2) AS ca_total,
        RANK() OVER (
            PARTITION BY p.categorie 
            ORDER BY SUM(dc.quantite) DESC
        ) AS rang
    FROM produits p
    JOIN details_commandes dc ON p.id_produit = dc.id_produit
    JOIN commandes c ON dc.id_commande = c.id_commande
    WHERE c.statut = 'livré'
    GROUP BY p.id_produit, p.nom_produit, p.categorie
) AS classement
WHERE rang = 1
ORDER BY ca_total DESC;

--- PRODUIT QUI RAPPORTENT LE PLUS
SELECT 
    p.nom_produit,
    p.categorie,
    p.prix AS prix_unitaire,
    SUM(dc.quantite) AS quantite_vendue,
    ROUND(SUM(dc.prix_unitaire * dc.quantite), 2) AS ca_total,
    ROUND(SUM(dc.prix_unitaire * dc.quantite) * 100.0 / (
        SELECT SUM(dc2.prix_unitaire * dc2.quantite)
        FROM details_commandes dc2
        JOIN commandes c2 ON dc2.id_commande = c2.id_commande
        WHERE c2.statut = 'livré'
    ), 2) AS part_ca
FROM produits p
JOIN details_commandes dc ON p.id_produit = dc.id_produit
JOIN commandes c ON dc.id_commande = c.id_commande
WHERE c.statut = 'livré'
GROUP BY p.id_produit, p.nom_produit, p.categorie, p.prix
ORDER BY ca_total DESC
LIMIT 10;