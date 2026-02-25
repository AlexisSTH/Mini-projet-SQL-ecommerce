-- Création des tables
CREATE TABLE clients (
    id_client INTEGER PRIMARY KEY,
    nom TEXT,
    email TEXT,
    ville TEXT,
    date_inscription DATE
);

CREATE TABLE produits (
    id_produit INTEGER PRIMARY KEY,
    nom_produit TEXT,
    categorie TEXT,
    prix DECIMAL(10,2)
);

CREATE TABLE commandes (
    id_commande INTEGER PRIMARY KEY,
    id_client INTEGER,
    date_commande DATE,
    statut TEXT,
    FOREIGN KEY (id_client) REFERENCES clients(id_client)
);

CREATE TABLE details_commandes (
    id_detail INTEGER PRIMARY KEY,
    id_commande INTEGER,
    id_produit INTEGER,
    quantite INTEGER,
    prix_unitaire DECIMAL(10,2),
    FOREIGN KEY (id_commande) REFERENCES commandes(id_commande),
    FOREIGN KEY (id_produit) REFERENCES produits(id_produit)
);

-- Insertion des clients
INSERT INTO clients VALUES
(1, 'Alice Martin', 'alice@email.com', 'Paris', '2023-01-15'),
(2, 'Bob Dupont', 'bob@email.com', 'Lyon', '2023-02-20'),
(3, 'Clara Petit', 'clara@email.com', 'Marseille', '2023-03-10'),
(4, 'David Moreau', 'david@email.com', 'Paris', '2023-04-05'),
(5, 'Emma Bernard', 'emma@email.com', 'Bordeaux', '2023-05-18'),
(6, 'François Leroy', 'francois@email.com', 'Lyon', '2023-06-22'),
(7, 'Grace Simon', 'grace@email.com', 'Paris', '2023-07-30'),
(8, 'Hugo Michel', 'hugo@email.com', 'Nantes', '2023-08-14');

-- Insertion des produits
INSERT INTO produits VALUES
(1, 'Laptop Pro', 'Informatique', 1299.99),
(2, 'Souris Sans Fil', 'Informatique', 29.99),
(3, 'Clavier Mécanique', 'Informatique', 89.99),
(4, 'Écran 4K', 'Informatique', 499.99),
(5, 'Casque Audio', 'Audio', 149.99),
(6, 'Webcam HD', 'Informatique', 79.99),
(7, 'Disque SSD', 'Stockage', 119.99),
(8, 'Hub USB', 'Accessoires', 39.99);

-- Insertion des commandes
INSERT INTO commandes VALUES
(1, 1, '2023-01-20', 'livré'),
(2, 2, '2023-02-25', 'livré'),
(3, 1, '2023-03-15', 'livré'),
(4, 3, '2023-03-20', 'annulé'),
(5, 4, '2023-04-10', 'livré'),
(6, 2, '2023-04-15', 'livré'),
(7, 5, '2023-05-20', 'livré'),
(8, 1, '2023-06-01', 'en attente'),
(9, 6, '2023-06-10', 'livré'),
(10, 7, '2023-07-05', 'livré'),
(11, 3, '2023-07-20', 'livré'),
(12, 8, '2023-08-15', 'livré');

-- Insertion des détails
INSERT INTO details_commandes VALUES
(1, 1, 1, 1, 1299.99),
(2, 1, 2, 2, 29.99),
(3, 2, 3, 1, 89.99),
(4, 2, 5, 1, 149.99),
(5, 3, 4, 1, 499.99),
(6, 4, 2, 1, 29.99),
(7, 5, 1, 1, 1299.99),
(8, 5, 6, 1, 79.99),
(9, 6, 7, 2, 119.99),
(10, 7, 5, 1, 149.99),
(11, 7, 8, 3, 39.99),
(12, 8, 3, 1, 89.99),
(13, 9, 4, 1, 499.99),
(14, 10, 1, 1, 1299.99),
(15, 11, 2, 4, 29.99),
(16, 12, 7, 1, 119.99);
