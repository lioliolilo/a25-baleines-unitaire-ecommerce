DROP DATABASE IF EXISTS rich_ricasso_shop;

CREATE DATABASE rich_ricasso_shop CHARACTER
SET
    utf8mb4 COLLATE utf8mb4_unicode_ci;

USE rich_ricasso_shop;

CREATE TABLE
    users (
        id INT AUTO_INCREMENT PRIMARY KEY,
        email VARCHAR(100) UNIQUE NOT NULL,
        username VARCHAR(50) NOT NULL,
        age INT,
        password VARCHAR(255) NOT NULL
    );

CREATE TABLE
    newsletter (
        id INT AUTO_INCREMENT PRIMARY KEY,
        email VARCHAR(100) UNIQUE NOT NULL
    );

CREATE TABLE
    produits (
        id INT AUTO_INCREMENT PRIMARY KEY,
        nom VARCHAR(100) NOT NULL,
        description TEXT,
        prix DECIMAL(10, 2) NOT NULL,
        image VARCHAR(255),
        image2 VARCHAR(255),
        type ENUM ('cravate', 'chemise') NOT NULL,
        couleur VARCHAR(30) NOT NULL
    );

CREATE TABLE
    tailles (
        id INT AUTO_INCREMENT PRIMARY KEY,
        code VARCHAR(10) UNIQUE NOT NULL,
        label VARCHAR(30) NOT NULL
    );

INSERT INTO
    tailles (code, label)
VALUES
    ('44', 'IT 44'),
    ('46', 'IT 46'),
    ('48', 'IT 48'),
    ('50', 'IT 50'),
    ('52', 'IT 52'),
    ('54', 'IT 54'),
    ('56', 'IT 56');

CREATE TABLE
    produit_taille (
        produit_id INT NOT NULL,
        taille_id INT NOT NULL,
        quantite INT NOT NULL DEFAULT 0,
        PRIMARY KEY (produit_id, taille_id),
        FOREIGN KEY (produit_id) REFERENCES produits (id) ON DELETE CASCADE,
        FOREIGN KEY (taille_id) REFERENCES tailles (id) ON DELETE RESTRICT,
        CHECK (quantite >= 0)
    );

INSERT INTO
    produits (
        nom,
        description,
        prix,
        image,
        image2,
        type,
        couleur
    )
VALUES
    (
        'Cravate Unicorne',
        'Cravate multicolore en soie avec un design unique de unicorne vaporwave.',
        129.00,
        'public/images/tieX.webp',
        'public/images/tie1.webp',
        'cravate',
        'multicolore'
    ),
    (
        'Chemise Unicorne',
        'Chemise violet en coton avec des motifs unicorne.',
        249.00,
        'public/images/shirt1.webp',
        'public/images/tie2.webp',
        'chemise',
        'violet'
    ),
    (
        'Cravate Pastel',
        'Cravate rose en soie pastel à rayures.',
        89.99,
        'public/images/tie3.webp',
        'public/images/tie4.webp',
        'cravate',
        'rose'
    ),
    (
        'T-Shirt Horizon Unicorne',
        'Chemise multicolore à motifs unicorne avec un effet de coucher du soleil.',
        279.00,
        'public/images/tshirt3.webp',
        'public/images/tshirt4.webp',
        'chemise',
        'multicolore'
    ),
    (
        'Cravate Lignes Colorées',
        'Cravate rose en soie avec des motifs de unicornes.',
        119.99,
        'public/images/tie7.webp',
        'public/images/tie8.webp',
        'cravate',
        'rose'
    ),
    (
        'T-Shirt Unicorne Horizons',
        'Chemise rose à effet horizon avec un unicorne.',
        299.00,
        'public/images/tshirt1.webp',
        'public/images/tshirt2.webp',
        'chemise',
        'rose'
    ),
    (
        'Cravate Unicorne Prismatique',
        'Cravate bleu en soie avec un motif futuriste.',
        135.00,
        'public/images/tie5.webp',
        'public/images/tie6.webp',
        'cravate',
        'bleu'
    ),
    (
        'Chemise Horizons Vaporwave',
        'Chemise bleu à effet horizon inspirée du vaporwave.',
        220.00,
        'public/images/tshirt5.webp',
        'public/images/tshirt6.webp',
        'chemise',
        'bleu'
    );

INSERT INTO
    produit_taille (produit_id, taille_id, quantite)
SELECT
    p.id,
    t.id,
    CASE t.code
        WHEN '44' THEN 5
        WHEN '46' THEN 6
        WHEN '48' THEN 4
        WHEN '50' THEN 3
        WHEN '52' THEN 2
        WHEN '54' THEN 1
        WHEN '56' THEN 0
    END
FROM
    produits p
    JOIN tailles t
WHERE
    p.type = 'chemise';

CREATE TABLE `order` (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    total_amount DECIMAL(10,2) NOT NULL,
    status ENUM('enattente','paye','echec') NOT NULL DEFAULT 'enattente',
    stripe_payment_id VARCHAR(255),
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);

CREATE TABLE order_items (
    id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT NOT NULL,
    produit_id INT NOT NULL,
    taille_id INT,
    quantity INT NOT NULL DEFAULT 1,
    price DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (order_id) REFERENCES `order`(id) ON DELETE CASCADE,
    FOREIGN KEY (produit_id) REFERENCES produits(id) ON DELETE CASCADE,
    FOREIGN KEY (taille_id) REFERENCES tailles(id) ON DELETE SET NULL
);