DROP TABLE IF EXISTS products;
DROP TABLE IF EXISTS product_categories;

CREATE TABLE product_categories (
    id INT PRIMARY KEY AUTO_INCREMENT,
    parent_id INT,
    name VARCHAR(250) NOT NULL,
    last_updated DATETIME NOT NULL ON UPDATE CURRENT_TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY(parent_id) REFERENCES product_categories(id)
);

INSERT INTO product_categories (id, name) values (1, 'Books');
INSERT INTO product_categories (id, name) values (2, 'Clothes');
INSERT INTO product_categories (id, name) values (3, 'DVD/Movies');
INSERT INTO product_categories (id, name) values (4, 'Electronics');

CREATE TABLE products (
    id INT PRIMARY KEY AUTO_INCREMENT,
    category_id INT NOT NULL,
    name VARCHAR(250) NOT NULL,
    price FLOAT NOT NULL,
    quantity_available INT NOT NULL,
    image_url VARCHAR(250),
    last_updated DATETIME NOT NULL ON UPDATE CURRENT_TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY(category_id) REFERENCES product_categories(id)    
);


-- Books
INSERT INTO products (category_id, name, price, quantity_available, image_url) VALUES (1, 'The Great Gatsby, F. Scott Fitgerald, 1925', 9.99, 10, '/images/gatsby.jpeg');
INSERT INTO products (category_id, name, price, quantity_available, image_url) VALUES (1, 'The Catcher in the Rye, J.D. Salinger, 1951', 9.99, 10, '/images/catcher.jpeg');
INSERT INTO products (category_id, name, price, quantity_available, image_url) VALUES (1, '1984, George Orwell, 1949', 9.99, 10, '/images/1984.jpeg');
INSERT INTO products (category_id, name, price, quantity_available, image_url) VALUES (1, 'Catch-22, Joseph Heller, 1961', 9.99, 10, '/images/catch22.jpeg');
INSERT INTO products (category_id, name, price, quantity_available, image_url) VALUES (1, 'Invisible Man, Ralph Ellison, 1952', 9.99, 10, '/images/invisibleman.jpeg');
INSERT INTO products (category_id, name, price, quantity_available, image_url) VALUES (1, 'The Lord of the Rings, J.R.R. Tolkien, 1954', 9.99, 10, '/images/lordoftherings.jpeg');
INSERT INTO products (category_id, name, price, quantity_available, image_url) VALUES (1, 'Little Women, Louisa May Alcott, 1868', 9.99, 10, '/images/littlewomen.jpeg');
INSERT INTO products (category_id, name, price, quantity_available, image_url) VALUES (1, 'A Passage to India, E.M. Forster, 1924', 9.99, 10, '/images/passagetoindia.jpeg');
INSERT INTO products (category_id, name, price, quantity_available, image_url) VALUES (1, 'The Stranger, Albert Camus, 1942', 9.99, 10, '/images/thestranger.jpeg');
INSERT INTO products (category_id, name, price, quantity_available, image_url) VALUES (1, 'The Candy House, Jennifer Egan, 2022', 9.99, 10, '/images/thecandyhouse.jpeg');
INSERT INTO products (category_id, name, price, quantity_available) VALUES (1, 'Lord of the Flies, William Golding, 1954', 9.99, 10);
INSERT INTO products (category_id, name, price, quantity_available) VALUES (1, 'On the Road, Jack Kerouac, 1954', 9.99, 10);
INSERT INTO products (category_id, name, price, quantity_available) VALUES (1, 'Great Expectations, Charles Dickens, 1861', 9.99, 10);
INSERT INTO products (category_id, name, price, quantity_available) VALUES (1, 'Fahrenheit 451, Ray Bradury, 1953', 9.99, 10);
INSERT INTO products (category_id, name, price, quantity_available) VALUES (1, 'One Hundred Years of Solitude, Gabriel García Márquez, 1964', 9.99, 10);
INSERT INTO products (category_id, name, price, quantity_available) VALUES (1, 'Lolita, Vladimir Nabokov, 1955', 9.99, 10);
INSERT INTO products (category_id, name, price, quantity_available) VALUES (1, 'Beloved, Toni Morrison, 1987', 9.99, 10);
INSERT INTO products (category_id, name, price, quantity_available) VALUES (1, 'Brave New World, Aldous Huxley, 1932', 9.99, 10);
INSERT INTO products (category_id, name, price, quantity_available) VALUES (1, 'Ulysses, James Joyce, 1920', 9.99, 10);
INSERT INTO products (category_id, name, price, quantity_available) VALUES (1, 'Moby-Dick, Herman Melville, 1851', 9.99, 10);
INSERT INTO products (category_id, name, price, quantity_available) VALUES (1, 'Mrs Dalloway, Virginia Woolf, 1925', 9.99, 10);
INSERT INTO products (category_id, name, price, quantity_available) VALUES (1, 'The Handmaid\'s Tale, Margaret Atwood, 1985', 9.99, 10);
INSERT INTO products (category_id, name, price, quantity_available) VALUES (1, 'Atonement, Ian McEwan, 2001', 9.99, 10);
INSERT INTO products (category_id, name, price, quantity_available) VALUES (1, 'Tomorrow, and Tomorrow, and Tomorrow, Gabrielle Zevin, 2022', 9.99, 10);
INSERT INTO products (category_id, name, price, quantity_available) VALUES (1, 'The Grapes of Wrath, John Steinbeck, 1939', 9.99, 10);
INSERT INTO products (category_id, name, price, quantity_available) VALUES (1, 'Hamlet, William Shakespeare, 1847', 9.99, 10);
INSERT INTO products (category_id, name, price, quantity_available) VALUES (1, 'Sea of Tranquility, Emily St. John Mandel, 2022', 9.99, 10);
INSERT INTO products (category_id, name, price, quantity_available) VALUES (1, 'The Secret History, Donna Tartt, 1992', 9.99, 10);
INSERT INTO products (category_id, name, price, quantity_available) VALUES (1, 'Wolf Hall, Hilary Mantel, 2009', 9.99, 10);
INSERT INTO products (category_id, name, price, quantity_available) VALUES (1, 'Iliad, Homer, 1777', 9.99, 10);
INSERT INTO products (category_id, name, price, quantity_available) VALUES (1, 'The Kite Runner, Khaled Hosseini, 2003', 9.99, 10);
INSERT INTO products (category_id, name, price, quantity_available) VALUES (1, 'To Kill a Mockingbird, Harper Lee, 1960', 9.99, 10);
INSERT INTO products (category_id, name, price, quantity_available) VALUES (1, 'Anna Karenina, Leo Tolstoy, 1877', 9.99, 10);
INSERT INTO products (category_id, name, price, quantity_available) VALUES (1, 'Pride and Prejudice, Jane Austen, 1813', 9.99, 10);
INSERT INTO products (category_id, name, price, quantity_available) VALUES (1, 'Don Quixote, Miguel de Cervantes, 1605', 9.99, 10);
INSERT INTO products (category_id, name, price, quantity_available) VALUES (1, 'Things Fall Apart, Chinua Achebe, 1958', 9.99, 10);
INSERT INTO products (category_id, name, price, quantity_available) VALUES (1, 'Adventures of Huckleberry Finn, Mark Twain, 1884', 9.99, 10);
INSERT INTO products (category_id, name, price, quantity_available) VALUES (1, 'The Color Purple, Alice Walker, 1982', 9.99, 10);
INSERT INTO products (category_id, name, price, quantity_available) VALUES (1, 'Slaughterhouse-Five, Kurt Vonnegut, 1969', 9.99, 10);
INSERT INTO products (category_id, name, price, quantity_available) VALUES (1, 'In Search of Lost Time, Marcel Proust, 1913', 9.99, 10);
INSERT INTO products (category_id, name, price, quantity_available) VALUES (1, 'The Sun Also Rises, Ernest Hemingway, 1926', 9.99, 10);
INSERT INTO products (category_id, name, price, quantity_available) VALUES (1, 'The Brothers Karamazov, Fyodor Dostoyevsky, 1880', 9.99, 10);
INSERT INTO products (category_id, name, price, quantity_available) VALUES (1, 'Alice\'s Adventures in Wonderland, Lewis Carroll, 1865', 9.99, 10);
INSERT INTO products (category_id, name, price, quantity_available) VALUES (1, 'Crime and Punishment, Fyodor Dostoyevsky, 1866', 9.99, 10);
INSERT INTO products (category_id, name, price, quantity_available) VALUES (1, 'War and Peace, Leo Tolstoy, 1867', 9.99, 10);
INSERT INTO products (category_id, name, price, quantity_available) VALUES (1, 'The Age of Innocence, Edith Wharton, 1920', 9.99, 10);
INSERT INTO products (category_id, name, price, quantity_available) VALUES (1, 'Divine Comedy, Dante Alighieri, 1971', 9.99, 10);
INSERT INTO products (category_id, name, price, quantity_available) VALUES (1, 'Madame Bovary, Gustave Flaubert, 1856', 9.99, 10);

-- Clothes
INSERT INTO products (category_id, name, price, quantity_available) VALUES (2, 'Jeans', 9.99, 10);
INSERT INTO products (category_id, name, price, quantity_available) VALUES (2, 'T-Shirt', 9.99, 10);
INSERT INTO products (category_id, name, price, quantity_available) VALUES (2, 'Hoodie', 9.99, 10);
INSERT INTO products (category_id, name, price, quantity_available) VALUES (2, 'Socks', 9.99, 10);
INSERT INTO products (category_id, name, price, quantity_available) VALUES (2, 'Shorts', 9.99, 10);
INSERT INTO products (category_id, name, price, quantity_available) VALUES (2, 'Underwear', 9.99, 10);
INSERT INTO products (category_id, name, price, quantity_available) VALUES (2, 'Ring', 9.99, 10);
INSERT INTO products (category_id, name, price, quantity_available) VALUES (2, 'Shoes', 9.99, 10);
INSERT INTO products (category_id, name, price, quantity_available) VALUES (2, 'Blouse', 9.99, 10);
INSERT INTO products (category_id, name, price, quantity_available) VALUES (2, 'Skirt', 9.99, 10);

-- Movies
INSERT INTO products (category_id, name, price, quantity_available) VALUES (3, 'The Shawshank Redemption (1994)', 9.99, 10);
INSERT INTO products (category_id, name, price, quantity_available) VALUES (3, 'The Godfather (1972)', 9.99, 10);
INSERT INTO products (category_id, name, price, quantity_available) VALUES (3, 'The Dark Knight (2008)', 9.99, 10);
INSERT INTO products (category_id, name, price, quantity_available) VALUES (3, 'The Godfather Part II (1974)', 9.99, 10);
INSERT INTO products (category_id, name, price, quantity_available) VALUES (3, '12 Angry Men (1957)', 9.99, 10);
INSERT INTO products (category_id, name, price, quantity_available) VALUES (3, 'Schindler\'s List (1993)', 9.99, 10);
INSERT INTO products (category_id, name, price, quantity_available) VALUES (3, 'The Lord of the Rings: The Return of the King (2003)', 9.99, 10);
INSERT INTO products (category_id, name, price, quantity_available) VALUES (3, 'Pulp Fiction (1994)', 9.99, 10);
INSERT INTO products (category_id, name, price, quantity_available) VALUES (3, 'The Lord of the Rings: The Fellowship of the Ring (2001)', 9.99, 10);
INSERT INTO products (category_id, name, price, quantity_available) VALUES (3, 'The Good, the Bad and the Ugly (1966)', 9.99, 10);
INSERT INTO products (category_id, name, price, quantity_available) VALUES (3, 'Forrest Gump (1994)', 9.99, 10);
INSERT INTO products (category_id, name, price, quantity_available) VALUES (3, 'Fight Club (1999)', 9.99, 10);
INSERT INTO products (category_id, name, price, quantity_available) VALUES (3, 'The Lord of the Rings: The Two Towers (2002)', 9.99, 10);
INSERT INTO products (category_id, name, price, quantity_available) VALUES (3, 'Inception (2010)', 9.99, 10);
INSERT INTO products (category_id, name, price, quantity_available) VALUES (3, 'Star Wars: Episode V - The Empire Strikes Back (1980)', 9.99, 10);
INSERT INTO products (category_id, name, price, quantity_available) VALUES (3, 'The Matrix (1999)', 9.99, 10);
INSERT INTO products (category_id, name, price, quantity_available) VALUES (3, 'Goodfellas (1990)', 9.99, 10);
INSERT INTO products (category_id, name, price, quantity_available) VALUES (3, 'One Flew Over the Cuckoo\'s Nest (1975)', 9.99, 10);
INSERT INTO products (category_id, name, price, quantity_available) VALUES (3, 'Se7en (1995)', 9.99, 10);
INSERT INTO products (category_id, name, price, quantity_available) VALUES (3, 'Seven Samurai (1954)', 9.99, 10);
INSERT INTO products (category_id, name, price, quantity_available) VALUES (3, 'It\'s a Wonderful Life (1946)', 9.99, 10);
INSERT INTO products (category_id, name, price, quantity_available) VALUES (3, 'The Silence of the Lambs (1991)', 9.99, 10);
INSERT INTO products (category_id, name, price, quantity_available) VALUES (3, 'Saving Private Ryan (1998)', 9.99, 10);
INSERT INTO products (category_id, name, price, quantity_available) VALUES (3, 'City of God (2002)', 9.99, 10);
INSERT INTO products (category_id, name, price, quantity_available) VALUES (3, 'Interstellar (2014)', 9.99, 10);
INSERT INTO products (category_id, name, price, quantity_available) VALUES (3, 'Life Is Beautiful (1997)', 9.99, 10);
INSERT INTO products (category_id, name, price, quantity_available) VALUES (3, 'The Green Mile (1999)', 9.99, 10);
INSERT INTO products (category_id, name, price, quantity_available) VALUES (3, 'Star Wars: Episode IV - A New Hope (1977)', 9.99, 10);
INSERT INTO products (category_id, name, price, quantity_available) VALUES (3, 'Terminator 2: Judgment Day (1991)', 9.99, 10);
INSERT INTO products (category_id, name, price, quantity_available) VALUES (3, 'Back to the Future (1985)', 9.99, 10);
INSERT INTO products (category_id, name, price, quantity_available) VALUES (3, 'Spirited Away (2001)', 9.99, 10);
INSERT INTO products (category_id, name, price, quantity_available) VALUES (3, 'The Pianist (2002)', 9.99, 10);
INSERT INTO products (category_id, name, price, quantity_available) VALUES (3, 'Psycho (1960)', 9.99, 10);
INSERT INTO products (category_id, name, price, quantity_available) VALUES (3, 'Parasite (2019)', 9.99, 10);
INSERT INTO products (category_id, name, price, quantity_available) VALUES (3, 'Léon: The Professional (1994)', 9.99, 10);
INSERT INTO products (category_id, name, price, quantity_available) VALUES (3, 'The Lion King (1994)', 9.99, 10);
INSERT INTO products (category_id, name, price, quantity_available) VALUES (3, 'Gladiator (2000)', 9.99, 10);
INSERT INTO products (category_id, name, price, quantity_available) VALUES (3, 'American History X (1998)', 9.99, 10);
INSERT INTO products (category_id, name, price, quantity_available) VALUES (3, 'The Departed (2006)', 9.99, 10);
INSERT INTO products (category_id, name, price, quantity_available) VALUES (3, 'The Prestige (2006)', 9.99, 10);
INSERT INTO products (category_id, name, price, quantity_available) VALUES (3, 'Whiplash (2014)', 9.99, 10);
INSERT INTO products (category_id, name, price, quantity_available) VALUES (3, 'The Usual Suspects (1995)', 9.99, 10);
INSERT INTO products (category_id, name, price, quantity_available) VALUES (3, 'Casablanca (1942)', 9.99, 10);
INSERT INTO products (category_id, name, price, quantity_available) VALUES (3, 'Grave of the Fireflies (1988)', 9.99, 10);
INSERT INTO products (category_id, name, price, quantity_available) VALUES (3, 'Harakiri (1962)', 9.99, 10);
INSERT INTO products (category_id, name, price, quantity_available) VALUES (3, 'The Intouchables (2011)', 9.99, 10);
INSERT INTO products (category_id, name, price, quantity_available) VALUES (3, 'Modern Times (1936)', 9.99, 10);
INSERT INTO products (category_id, name, price, quantity_available) VALUES (3, 'Once Upon a Time in the West (1968)', 9.99, 10);
INSERT INTO products (category_id, name, price, quantity_available) VALUES (3, 'Cinema Paradiso (1988)', 9.99, 10);
INSERT INTO products (category_id, name, price, quantity_available) VALUES (3, 'Rear Window (1954)', 9.99, 10);

-- Electronics
INSERT INTO products (category_id, name, price, quantity_available) VALUES (4, 'High-Definition Television (HDTV)', 999.99, 10);
INSERT INTO products (category_id, name, price, quantity_available) VALUES (4, 'Desktop PC', 599.99, 10);
INSERT INTO products (category_id, name, price, quantity_available) VALUES (4, 'Laptop', 499.99, 10);
INSERT INTO products (category_id, name, price, quantity_available) VALUES (4, 'Smartphone', 999.99, 10);
INSERT INTO products (category_id, name, price, quantity_available) VALUES (4, 'Tablet', 699.99, 10);
INSERT INTO products (category_id, name, price, quantity_available) VALUES (4, 'Monitor', 59.99, 10);
INSERT INTO products (category_id, name, price, quantity_available) VALUES (4, 'Smart TV', 999.99, 10);
INSERT INTO products (category_id, name, price, quantity_available) VALUES (4, 'PlayStation 5', 299.99, 10);
INSERT INTO products (category_id, name, price, quantity_available) VALUES (4, 'Xbox', 299.99, 10);
INSERT INTO products (category_id, name, price, quantity_available) VALUES (4, 'Speakers', 199.99, 10);

