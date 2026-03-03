--- VUE GLOBAL PAR MOIS
SELECT 
    DATE_FORMAT(c.date_commande, '%Y-%m') AS mois,
    COUNT(DISTINCT c.id_commande) AS nb_commandes,
    COUNT(DISTINCT c.id_client) AS nb_clients_actifs,
    ROUND(SUM(dc.prix_unitaire * dc.quantite), 2) AS ca_mensuel,
    ROUND(SUM(dc.prix_unitaire * dc.quantite) / 
        COUNT(DISTINCT c.id_commande), 2) AS panier_moyen
FROM commandes c
JOIN details_commandes dc ON c.id_commande = dc.id_commande
WHERE c.statut = 'livré'
GROUP BY DATE_FORMAT(c.date_commande, '%Y-%m')
ORDER BY mois;

--- chiffre d'affaires par mois 
SELECT
DATE_FORMAT(c.date_commande, '%Y-%m') AS mois,
ROUND(SUM(dc.prix_unitaire * dc.quantite), 2) AS ca_mensuel
FROM details_commandes dc
JOIN commandes c ON dc.id_commande = c.id_commande
WHERE c.statut = 'livré'
GROUP BY DATE_FORMAT(c.date_commande, '%Y-%m')
ORDER BY mois;

--- panier moyen par mois 
SELECT 
    DATE_FORMAT(c.date_commande, '%Y-%m') AS mois,
    ROUND(AVG(dc.prix_unitaire * dc.quantite), 2) AS panier_moyen
FROM commandes c
JOIN details_commandes dc ON c.id_commande = dc.id_commande
WHERE c.statut = 'livré'
GROUP BY DATE_FORMAT(c.date_commande, '%Y-%m')
ORDER BY mois;

--- NOUVEAUX CLIENTS PAR MOIS 
SELECT 
    DATE_FORMAT(premiere_commande, '%Y-%m') AS mois,
    COUNT(*) AS nouveaux_clients
FROM (
    SELECT 
        id_client,
        MIN(date_commande) AS premiere_commande
    FROM commandes
    WHERE statut = 'livré'
    GROUP BY id_client
) AS premiers_achats
GROUP BY DATE_FORMAT(premiere_commande, '%Y-%m')
ORDER BY mois;